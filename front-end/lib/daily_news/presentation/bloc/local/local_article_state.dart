import 'package:equatable/equatable.dart';
import 'package:news_app/daily_news/domain/entities/article.dart';

abstract class LocalArticleState extends Equatable {
  final List<ArticleEntity>? articles;

  const LocalArticleState({this.articles});

  @override
  List<Object> get props => [articles!];
}

class LocalArticlesLoading extends LocalArticleState {
  const LocalArticlesLoading();
}

class LocalArticlesDone extends LocalArticleState {
  const LocalArticlesDone(List<ArticleEntity> articles)
      : super(articles: articles);
}

class LocalArticlesError extends LocalArticleState {
  final String message;
  const LocalArticlesError(this.message);

  @override
  List<Object> get props => [message];
}
