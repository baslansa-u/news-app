import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants/app_constants.dart';
import 'package:news_app/daily_news/domain/entities/article.dart';
import 'package:news_app/daily_news/presentation/bloc/local/local_article_bloc.dart';
import 'package:news_app/daily_news/presentation/bloc/local/local_article_event.dart';
import 'package:news_app/injection_container.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ArticleDetailsView extends HookWidget {
  final ArticleEntity? article;
  const ArticleDetailsView({super.key, this.article});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LocalArticleBloc>(),
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: article == null ? _buildEmptyState() : _buildBody(),
        floatingActionButton:
            article == null ? null : _buildFloatingActionButton(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppConstants.surfaceColor,
      elevation: 0,
      iconTheme: const IconThemeData(color: AppConstants.textPrimary),
    );
  }

  Widget _buildEmptyState() {
    return const Center(child: Text('No Article found'));
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(),
          Padding(
            padding: const EdgeInsets.all(AppConstants.paddingLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article?.title ?? 'No Title',
                  style: const TextStyle(
                    fontSize: AppConstants.fontSizeXXLarge,
                    fontWeight: FontWeight.w700,
                    color: AppConstants.textPrimary,
                  ),
                ),
                const SizedBox(height: AppConstants.paddingMedium),
                Row(
                  children: [
                    const Icon(Icons.schedule_outlined,
                        size: 16, color: AppConstants.textSecondary),
                    const SizedBox(width: AppConstants.paddingXSmall),
                    Text(
                      article?.publishedAt ?? 'Unknown date',
                      style: const TextStyle(
                        fontSize: AppConstants.fontSizeSmall,
                        color: AppConstants.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.paddingLarge),
                Text(
                  '${article?.description ?? ''}\n\n${article?.content ?? ''}'
                      .trim(),
                  style: const TextStyle(
                    fontSize: AppConstants.fontSizeRegular,
                    color: AppConstants.textPrimary,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    if (article?.urlToImage == null || article!.urlToImage!.isEmpty) {
      return Container(
        height: 260,
        color: AppConstants.borderColor,
        child: const Center(
          child: Icon(Icons.image_not_supported_outlined,
              size: 48, color: AppConstants.textSecondary),
        ),
      );
    }

    return SizedBox(
      height: 260,
      width: double.infinity,
      child: Image.network(
        article!.urlToImage!,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(child: CircularProgressIndicator());
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: AppConstants.borderColor,
            child: const Center(
              child: Icon(Icons.broken_image_outlined,
                  size: 48, color: AppConstants.textSecondary),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        BlocProvider.of<LocalArticleBloc>(context).add(SaveArticle(article!));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Article saved')),
        );
      },
      backgroundColor: AppConstants.accentColor,
      child: const Icon(Icons.bookmark_outline),
    );
  }
}
