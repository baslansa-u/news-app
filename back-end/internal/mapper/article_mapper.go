package mapper

import "go-news-api/internal/model"

func MapArticle(a model.NewsAPIArticle) model.Article {
	return model.Article{
		Author:      a.Author,
		Title:       a.Title,
		Description: a.Description,
		URL:         a.URL,
		URLToImage:  a.URLToImage,
		PublishedAt: a.PublishedAt,
		Content:     a.Content,
	}
}

func MapArticles(list []model.NewsAPIArticle) []model.Article {
	result := make([]model.Article, 0, len(list))

	for _, item := range list {
		result = append(result, MapArticle(item))
	}

	return result
}
