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
  final bool isLoadingMore;
  final bool hasReachedMax;

  const ArticlesDone(
    this.articles, {
    this.isLoadingMore = false,
    this.hasReachedMax = false,
  });

  ArticlesDone copyWith({
    List<ArticleEntity>? articles,
    bool? isLoadingMore,
    bool? hasReachedMax,
  }) {
    return ArticlesDone(
      articles ?? this.articles,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [articles, isLoadingMore, hasReachedMax];
}

class ArticlesError extends ArticleState {
  final DioException error;

  const ArticlesError(this.error);

  @override
  List<Object?> get props => [error];
}
