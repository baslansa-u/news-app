import 'package:news_app/core/usecase/usecase.dart';
import 'package:news_app/daily_news/domain/entities/article.dart';
import 'package:news_app/daily_news/domain/repositories/article_repository.dart';

class RemoveArticlesUsecase implements Usecase<void, ArticleEntity> {
  final ArticleRepository _articleRepository;

  RemoveArticlesUsecase(this._articleRepository);

  @override
  Future<void> call({ArticleEntity? params}) {
    return _articleRepository.removeArticle(params!);
  }
}
