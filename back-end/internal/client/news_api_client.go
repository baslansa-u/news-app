package client

import (
	"encoding/json"
	"fmt"
	"go-news-api/internal/model"
	"net/http"
	"time"
)

type NewsClient struct {
	apiKey  string
	baseURL string
}

func NewNewsClient(apiKey string) *NewsClient {
	return &NewsClient{
		apiKey:  apiKey,
		baseURL: "https://newsapi.org/v2/top-headlines",
	}
}

func (c *NewsClient) FetchNews(country string) (model.NewsAPIResponse, error) {
	var result model.NewsAPIResponse

	// build url
	url := fmt.Sprintf("%s?country=%s&apiKey=%s", c.baseURL, country, c.apiKey)

	// http client with timeout
	client := http.Client{
		Timeout: 5 * time.Second,
	}

	resp, err := client.Get(url)
	if err != nil {
		return result, err
	}
	defer resp.Body.Close()

	// check status code
	if resp.StatusCode != http.StatusOK {
		return result, fmt.Errorf("news api error: status %d", resp.StatusCode)
	}

	// decode
	err = json.NewDecoder(resp.Body).Decode(&result)
	if err != nil {
		return result, err
	}

	return result, nil
}
