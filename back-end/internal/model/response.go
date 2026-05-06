package model

type NewsResponse struct {
	Status   string    `json:"status"`
	Count    int       `json:"count"`
	Articles []Article `json:"articles"`
}
