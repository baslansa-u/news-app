import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/routes/routes.dart';
import 'package:news_app/daily_news/domain/entities/article.dart';
import 'package:news_app/daily_news/presentation/bloc/remote/article_bloc.dart';
import 'package:news_app/daily_news/presentation/bloc/remote/article_event.dart';
import 'package:news_app/daily_news/presentation/bloc/remote/article_state.dart';
import 'package:news_app/daily_news/presentation/widgets/article_tile.dart';
import 'package:news_app/daily_news/presentation/widgets/theme_switch.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Daily News'),
      elevation: 0,
      actions: [
        const ThemeSwitch(),
        IconButton(
          icon: const Icon(Icons.bookmark_outline),
          onPressed: () => _onShowSavedArticles(context),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return BlocBuilder<ArticlesBloc, ArticleState>(
      buildWhen: (previous, current) {
        return current is ArticlesLoading ||
            current is ArticlesDone ||
            current is ArticlesError;
      },
      builder: (context, state) {
        if (state is ArticlesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is ArticlesError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                ),
                const SizedBox(height: 12),
                Text(
                  'Failed to load articles',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    context.read<ArticlesBloc>().add(GetArticles());
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (state is ArticlesDone) {
          _prefetchImages(
            context,
            state.articles,
          );

          return _buildArticles(
            context,
            state.articles,
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildArticles(
    BuildContext context,
    List<ArticleEntity> articles,
  ) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      cacheExtent: 1000,
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];

        return ArticleWidget(
          key: ValueKey(article.urlToImage),
          article: article,
          onArticlePressed: (article) {
            _onArticlePressed(
              context,
              article,
            );
          },
        );
      },
    );
  }

  void _onArticlePressed(BuildContext context, ArticleEntity article) {
    Navigator.pushNamed(context, AppRoutes.articleDetails, arguments: article);
  }

  void _onShowSavedArticles(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.savedArticles);
  }

  // โหลด image ก่อน user เห็น
  void _prefetchImages(
    BuildContext context,
    List<ArticleEntity> articles,
  ) {
    final prefetchItems = articles.take(12);

    for (final article in prefetchItems) {
      final imageUrl = article.urlToImage;

      if (imageUrl != null && imageUrl.isNotEmpty) {
        precacheImage(
          NetworkImage(imageUrl),
          context,
        );
      }
    }
  }
}
