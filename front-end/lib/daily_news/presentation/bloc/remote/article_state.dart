import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/daily_news/domain/entities/article.dart';

abstract class ArticleState extends Equatable {
  const ArticleState();

  @override
  List<Object?> get props => [];
}

class ArticlesLoading extends ArticleState {}

class ArticlesDone extends ArticleState {
  final List<ArticleEntity> articles;

  const ArticlesDone(this.articles);

  @override
  List<Object?> get props => [articles];
}

class ArticlesError extends ArticleState {
  final DioException error;

  const ArticlesError(this.error);

  @override
  List<Object?> get props => [error];
}
