import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/daily_news/domain/usecases/get_save_article.dart';
import 'package:news_app/daily_news/domain/usecases/remove_article.dart';
import 'package:news_app/daily_news/domain/usecases/save_article.dart';
import 'package:news_app/daily_news/presentation/bloc/local/local_article_event.dart';
import 'package:news_app/daily_news/presentation/bloc/local/local_article_state.dart';

class LocalArticleBloc extends Bloc<LocalArticleEvent, LocalArticleState> {
  final GetSavedArticlesUsecase _getSavedArticlesUsecase;
  final SaveArticlesUsecase _saveArticlesUsecase;
  final RemoveArticlesUsecase _removeArticlesUsecase;

  LocalArticleBloc(
    this._getSavedArticlesUsecase,
    this._saveArticlesUsecase,
    this._removeArticlesUsecase,
  ) : super(const LocalArticlesLoading()) {
    on<GetSavedArticles>(onGetSavedArticles);
    on<RemoveArticle>(onRemoveArticles);
    on<SaveArticle>(onSaveArticles);
  }

  void onGetSavedArticles(
      GetSavedArticles event, Emitter<LocalArticleState> emit) async {
    try {
      final articles = await _getSavedArticlesUsecase();
      emit(LocalArticlesDone(articles));
    } catch (e) {
      emit(LocalArticlesError(e.toString()));
    }
  }

  void onRemoveArticles(
      RemoveArticle removeArticle, Emitter<LocalArticleState> emit) async {
    await _removeArticlesUsecase(params: removeArticle.article);

    final articles = await _getSavedArticlesUsecase();
    emit(LocalArticlesDone(articles));
  }

  void onSaveArticles(
      SaveArticle saveArticle, Emitter<LocalArticleState> emit) async {
    await _saveArticlesUsecase(params: saveArticle.article);

    final articles = await _getSavedArticlesUsecase();
    emit(LocalArticlesDone(articles));
  }
}
