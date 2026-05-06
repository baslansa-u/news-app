package repository

import (
	"context"
	"encoding/json"
	"time"

	"github.com/redis/go-redis/v9"
)

var ctx = context.Background()

type CacheRepository struct {
	rdb *redis.Client
}

func NewCacheRepository(rdb *redis.Client) *CacheRepository {
	return &CacheRepository{rdb: rdb}
}

func (r *CacheRepository) Get(key string) (map[string]interface{}, error) {
	val, err := r.rdb.Get(ctx, key).Result()
	if err != nil {
		return nil, err
	}

	var data map[string]interface{}
	err = json.Unmarshal([]byte(val), &data)

	return data, err
}

func (r *CacheRepository) Set(key string, value map[string]interface{}) error {
	jsonData, err := json.Marshal(value)
	if err != nil {
		return err
	}

	return r.rdb.Set(ctx, key, jsonData, 5*time.Minute).Err()
}
