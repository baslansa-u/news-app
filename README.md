# News App (Flutter + Go + Redis)

A simple full-stack news application using Flutter for frontend and Go for backend with Redis caching and NewsAPI integration.

## Tech Stack
- Flutter (Dart)
- Go (Gin)
- Redis
- NewsAPI

## Architecture
Flutter → Go Backend → Redis Cache → NewsAPI

## Features
- Get top headlines by country
- Image caching on Flutter
- Redis caching for API performance
- API key secured in backend

## Performance
- First request: fetch from NewsAPI (~500–1000ms)
- Cached request: Redis (~1–10ms)

## API
GET /news?country=us

## How to run

### Backend
cd backend  
go run cmd/main.go  

### Redis
redis-server  

### Flutter
cd flutter  
flutter pub get  
flutter run  
