import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/daily_news/data/data_sources/local/app_database.dart';
import 'package:news_app/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:news_app/daily_news/data/repositories/article_repository_impl.dart';
import 'package:news_app/daily_news/domain/repositories/article_repository.dart';
import 'package:news_app/daily_news/domain/usecases/get_articles.dart';
import 'package:news_app/daily_news/presentation/bloc/local/local_article_bloc.dart';
import 'package:news_app/daily_news/presentation/bloc/remote/article_bloc.dart';

import 'daily_news/domain/usecases/get_save_article.dart';
import 'daily_news/domain/usecases/remove_article.dart';
import 'daily_news/domain/usecases/save_article.dart';

final sl = GetIt.instance;

Future<void> initiallizeDependencies() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(database);

  // Dio
  sl.registerSingleton<Dio>(Dio());

  // Dependencies
  sl.registerSingleton<NewsApiService>(NewsApiService(sl()));

  sl.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(sl(), sl()));

  // UseCases
  sl.registerSingleton<GetArticlesUsecase>(GetArticlesUsecase(sl()));
  sl.registerSingleton<GetSavedArticlesUsecase>(GetSavedArticlesUsecase(sl()));
  sl.registerSingleton<SaveArticlesUsecase>(SaveArticlesUsecase(sl()));
  sl.registerSingleton<RemoveArticlesUsecase>(RemoveArticlesUsecase(sl()));

  // Bloc
  sl.registerFactory<ArticlesBloc>(() => ArticlesBloc(sl()));

  sl.registerFactory<LocalArticleBloc>(
    () => LocalArticleBloc(sl(), sl(), sl()),
  );
}
