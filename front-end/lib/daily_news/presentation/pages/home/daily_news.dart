import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants/app_constants.dart';
import 'package:news_app/config/routes/routes.dart';
import 'package:news_app/daily_news/domain/entities/article.dart';
import 'package:news_app/daily_news/presentation/bloc/remote/article_bloc.dart';
import 'package:news_app/daily_news/presentation/bloc/remote/article_event.dart';
import 'package:news_app/daily_news/presentation/bloc/remote/article_state.dart';
import 'package:news_app/daily_news/presentation/widgets/article_tile.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
      backgroundColor: AppConstants.backgroundColor,
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Daily News'),
      backgroundColor: AppConstants.surfaceColor,
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.bookmark_outline),
          onPressed: () => _onShowSavedArticles(context),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return BlocBuilder<ArticlesBloc, ArticleState>(
      builder: (context, state) {
        if (state is ArticlesLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ArticlesError) {
          return _buildErrorState(context);
        }
        if (state is ArticlesDone) {
          return _buildArticles(context, state.articles);
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<ArticlesBloc>().add(GetArticles());
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height - kToolbarHeight,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.error_outline,
                    size: 64, color: AppConstants.errorColor),
                SizedBox(height: AppConstants.paddingLarge),
                Text('Failed to load articles'),
                SizedBox(height: AppConstants.paddingSmall),
                Text('Pull down to retry'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildArticles(BuildContext context, List<ArticleEntity> articles) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: AppConstants.paddingXLarge),
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return ArticleWidget(
          article: articles[index],
          onArticlePressed: (article) => _onArticlePressed(context, article),
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
}
