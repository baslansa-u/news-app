package main

import (
	"log"
	"os"

	"go-news-api/internal/client"
	"go-news-api/internal/config"
	"go-news-api/internal/handler"
	"go-news-api/internal/repository"
	"go-news-api/internal/service"
	redisPkg "go-news-api/pkg/redis"

	"github.com/gin-gonic/gin"
)

func main() {
	// set gin mode
	gin.SetMode(gin.ReleaseMode)

	// load config
	cfg := config.Load()

	// validate config (สำคัญ)
	if cfg.APIKey == "" {
		log.Fatal("API key is missing")
	}
	if cfg.RedisAddr == "" {
		log.Fatal("Redis address is missing")
	}

	// redis
	rdb := redisPkg.NewRedis(cfg.RedisAddr)

	// layers
	cacheRepo := repository.NewCacheRepository(rdb)
	newsClient := client.NewNewsClient(cfg.APIKey)
	newsService := service.NewNewsService(cacheRepo, newsClient)
	newsHandler := handler.NewNewsHandler(newsService)

	// router
	r := gin.Default()

	r.GET("/news", newsHandler.GetNews)

	port := cfg.Port
	if port == "" {
		port = "8080"
	}

	log.Println("Server running on port:", port)

	if err := r.Run(":" + port); err != nil {
		log.Fatal("server failed to start:", err)
	}

	os.Exit(0)
}
