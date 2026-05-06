package service

import (
	"encoding/json"
	"log"

	"go-news-api/internal/client"
	"go-news-api/internal/mapper"
	"go-news-api/internal/model"
	"go-news-api/internal/repository"
)

type NewsService struct {
	cache  *repository.CacheRepository
	client *client.NewsClient
}

func NewNewsService(
	cache *repository.CacheRepository,
	client *client.NewsClient,
) *NewsService {
	return &NewsService{
		cache:  cache,
		client: client,
	}
}

func (s *NewsService) GetNews(country string) (model.NewsResponse, error) {
	// 1. Try to get from cache
	cached, err := s.cache.Get(country)
	if err == nil && cached != nil {
		// Cache hit - convert map to struct
		jsonBytes, _ := json.Marshal(cached)
		var cachedResponse model.NewsResponse
		if err := json.Unmarshal(jsonBytes, &cachedResponse); err == nil {
			log.Printf("✅ Cache hit for country: %s", country)
			return cachedResponse, nil
		}
	}

	// 2. Fetch from API
	log.Printf("🔄 Fetching from API for country: %s", country)
	raw, err := s.client.FetchNews(country)
	if err != nil {
		return model.NewsResponse{}, err
	}

	articles := mapper.MapArticles(raw.Articles)

	response := model.NewsResponse{
		Status:   raw.Status,
		Count:    len(articles),
		Articles: articles,
	}

	// 3. Store in cache
	cacheData := map[string]interface{}{
		"status":   response.Status,
		"count":    response.Count,
		"articles": response.Articles,
	}
	go func() {
		if err := s.cache.Set(country, cacheData); err != nil {
			log.Printf("⚠️  Failed to cache: %v", err)
		}
	}()

	return response, nil
}
