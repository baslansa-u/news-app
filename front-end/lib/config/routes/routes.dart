import 'package:flutter/material.dart';
import 'package:news_app/daily_news/domain/entities/article.dart';
import 'package:news_app/daily_news/presentation/pages/article_deatil/article_detail.dart';
import 'package:news_app/daily_news/presentation/pages/save_article/saved_article.dart';

class AppRoutes {
  static const String articleDetails = '/ArticleDetails';
  static const String savedArticles = '/SavedArticles';
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case articleDetails:
        final args = settings.arguments;

        if (args is ArticleEntity) {
          return MaterialPageRoute(
            builder: (_) => ArticleDetailsView(article: args),
          );
        } else {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(child: Text('Invalid Article Data')),
            ),
          );
        }

      case savedArticles:
        return MaterialPageRoute(
          builder: (_) => const SavedArticlesView(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('No route found')),
          ),
        );
    }
  }
}
