import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:news_app/core/constants/app_constants.dart';
import 'package:news_app/daily_news/domain/entities/article.dart';
import 'package:news_app/daily_news/presentation/bloc/local/local_article_bloc.dart';
import 'package:news_app/daily_news/presentation/bloc/local/local_article_event.dart';
import 'package:news_app/injection_container.dart';

class ArticleDetailsView extends HookWidget {
  final ArticleEntity? article;

  const ArticleDetailsView({
    super.key,
    this.article,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LocalArticleBloc>(),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: article == null ? _buildEmptyState(context) : _buildBody(context),
        floatingActionButton:
            article == null ? null : _buildFloatingActionButton(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Text(
        'No Article Found',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(context),
          Padding(
            padding: const EdgeInsets.all(
              AppConstants.paddingLarge,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article?.title ?? 'No Title',
                  style: Theme.of(context).textTheme.titleLarge,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: AppConstants.paddingMedium,
                ),
                _buildMetaInfo(context),
                const SizedBox(
                  height: AppConstants.paddingLarge,
                ),
                Text(
                  '${article?.description ?? ''}\n\n'
                          '${article?.content ?? ''}'
                      .trim(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: 1.7,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetaInfo(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.schedule_outlined,
          size: 16,
          color: Theme.of(context).textTheme.labelSmall?.color,
        ),
        const SizedBox(
          width: AppConstants.paddingXSmall,
        ),
        Expanded(
          child: Text(
            article?.publishedAt ?? 'Unknown date',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
      ],
    );
  }

  Widget _buildImage(BuildContext context) {
    final imageUrl = article?.urlToImage ?? '';

    if (imageUrl.isEmpty) {
      return Container(
        height: 260,
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: Center(
          child: Icon(
            Icons.image_not_supported_outlined,
            size: 48,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      );
    }

    return SizedBox(
      height: 260,
      width: double.infinity,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        memCacheHeight: 600,
        fadeInDuration: const Duration(milliseconds: 200),
        placeholder: (context, url) {
          return Container(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
        errorWidget: (context, url, error) {
          return Container(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Center(
              child: Icon(
                Icons.broken_image_outlined,
                size: 48,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFloatingActionButton(
    BuildContext context,
  ) {
    return FloatingActionButton(
      onPressed: () {
        context.read<LocalArticleBloc>().add(
              SaveArticle(article!),
            );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Article saved'),
          ),
        );
      },
      child: const Icon(
        Icons.bookmark_outline,
      ),
    );
  }
}
