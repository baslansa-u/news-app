import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:news_app/config/routes/routes.dart';
import 'package:news_app/core/constants/app_constants.dart';
import 'package:news_app/daily_news/domain/entities/article.dart';
import 'package:news_app/daily_news/presentation/bloc/local/local_article_bloc.dart';
import 'package:news_app/daily_news/presentation/bloc/local/local_article_event.dart';
import 'package:news_app/daily_news/presentation/bloc/local/local_article_state.dart';
import 'package:news_app/daily_news/presentation/widgets/article_tile.dart';
import 'package:news_app/injection_container.dart';

class SavedArticlesView extends HookWidget {
  const SavedArticlesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LocalArticleBloc>()..add(const GetSavedArticles()),
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildBody(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Saved Articles'),
      elevation: 0,
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<LocalArticleBloc, LocalArticleState>(
      builder: (context, state) {
        if (state is LocalArticlesLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is LocalArticlesDone) {
          final articles = state.articles ?? [];
          if (articles.isEmpty) {
            return const Center(child: Text('No saved articles'));
          }
          return ListView.builder(
            padding: const EdgeInsets.only(bottom: AppConstants.paddingXLarge),
            itemCount: articles.length,
            itemBuilder: (context, index) {
              return ArticleWidget(
                article: articles[index],
                isRemoveable: true,
                onRemove: (article) => _onRemoveArticle(context, article),
                onArticlePressed: (article) =>
                    _onArticlePressed(context, article),
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }

  void _onRemoveArticle(BuildContext context, ArticleEntity article) {
    BlocProvider.of<LocalArticleBloc>(context).add(RemoveArticle(article));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Article removed')),
    );
  }

  void _onArticlePressed(BuildContext context, ArticleEntity article) {
    Navigator.pushNamed(context, AppRoutes.articleDetails, arguments: article);
  }
}
