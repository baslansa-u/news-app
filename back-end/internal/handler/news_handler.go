package handler

import (
	"go-news-api/internal/service"
	"net/http"

	"github.com/gin-gonic/gin"
)

type NewsHandler struct {
	service *service.NewsService
}

func NewNewsHandler(s *service.NewsService) *NewsHandler {
	return &NewsHandler{service: s}
}

func (h *NewsHandler) GetNews(c *gin.Context) {
	country := c.DefaultQuery("country", "us")

	data, err := h.service.GetNews(country)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"error": err.Error(),
		})
		return
	}

	c.JSON(http.StatusOK, data)
}
