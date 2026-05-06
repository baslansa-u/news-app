package config

import (
	"log"
	"os"

	"github.com/joho/godotenv"
)

type Config struct {
	APIKey    string
	RedisAddr string
	Port      string
}

func Load() *Config {
	err := godotenv.Load()
	if err != nil {
		log.Println(".env not found, using system env")
	}

	return &Config{
		APIKey:    os.Getenv("NEWS_API_KEY"),
		RedisAddr: os.Getenv("REDIS_ADDR"),
		Port:      os.Getenv("PORT"),
	}
}
