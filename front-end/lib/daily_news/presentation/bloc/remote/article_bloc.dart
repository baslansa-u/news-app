import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/daily_news/domain/entities/article.dart';
import 'package:news_app/daily_news/domain/usecases/get_articles.dart';
import 'package:news_app/daily_news/presentation/bloc/remote/article_event.dart';
import 'package:news_app/daily_news/presentation/bloc/remote/article_state.dart';

class ArticlesBloc extends Bloc<ArticleEvent, ArticleState> {
  final GetArticlesUsecase _getArticlesUsecase;

  List<ArticleEntity> _allArticles = [];
  // pagination size
  final int _pageSize = 10;

  ArticlesBloc(this._getArticlesUsecase) : super(ArticlesLoading()) {
    on<GetArticles>(onGetArticles);
    on<LoadMoreArticles>(onLoadMoreArticles);
  }

  void onGetArticles(GetArticles event, Emitter<ArticleState> emit) async {
    emit(ArticlesLoading());
    final dataState = await _getArticlesUsecase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(ArticlesDone(dataState.data!));
    }
    if (dataState is DataFailed) {
      emit(ArticlesError(dataState.error!));
    }
  }

  void onLoadMoreArticles(
    LoadMoreArticles event,
    Emitter<ArticleState> emit,
  ) {
    final currentState = state;

    if (currentState is! ArticlesDone) return;

    if (currentState.isLoadingMore) return;
    if (currentState.hasReachedMax) return;

    emit(currentState.copyWith(isLoadingMore: true));

    final currentLength = currentState.articles.length;

    final nextItems = _allArticles.skip(currentLength).take(_pageSize).toList();

    final updatedList = [
      ...currentState.articles,
      ...nextItems,
    ];

    emit(
      ArticlesDone(
        updatedList,
        isLoadingMore: false,
        hasReachedMax: updatedList.length >= _allArticles.length,
      ),
    );
  }
}
