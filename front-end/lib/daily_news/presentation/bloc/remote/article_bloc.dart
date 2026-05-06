import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/daily_news/domain/usecases/get_articles.dart';
import 'package:news_app/daily_news/presentation/bloc/remote/article_event.dart';
import 'package:news_app/daily_news/presentation/bloc/remote/article_state.dart';

class ArticlesBloc extends Bloc<ArticleEvent, ArticleState> {
  final GetArticlesUsecase _getArticlesUsecase;

  ArticlesBloc(this._getArticlesUsecase) : super(ArticlesLoading()) {
    on<GetArticles>(onGetArticles);
  }

  void onGetArticles(GetArticles event, Emitter<ArticleState> emit) async {
    emit(ArticlesLoading());
    final dataState = await _getArticlesUsecase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      // print("ckg ${dataState.data}");
      emit(ArticlesDone(dataState.data!));
    }
    if (dataState is DataFailed) {
      // print("ckg ${dataState.error!.message}");
      emit(ArticlesError(dataState.error!));
    }
  }
}
