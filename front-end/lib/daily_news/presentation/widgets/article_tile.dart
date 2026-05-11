import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_constants.dart';
import 'package:news_app/daily_news/domain/entities/article.dart';

class ArticleWidget extends StatelessWidget {
  final ArticleEntity article;
  final bool isRemoveable;
  final void Function(ArticleEntity article)? onRemove;
  final void Function(ArticleEntity article)? onArticlePressed;

  const ArticleWidget({
    super.key,
    required this.article,
    this.isRemoveable = false,
    this.onRemove,
    this.onArticlePressed,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingLarge,
          vertical: AppConstants.paddingSmall,
        ),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppConstants.radiusLarge,
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(
            AppConstants.radiusLarge,
          ),
          onTap: () {
            onArticlePressed?.call(article);
          },
          child: Padding(
            padding: const EdgeInsets.all(
              AppConstants.paddingMedium,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImage(context),
                const SizedBox(
                  width: AppConstants.paddingLarge,
                ),
                Expanded(
                  child: _buildContent(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    final imageUrl = article.urlToImage ?? '';

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 100,
        height: 100,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          memCacheHeight: 200,
          placeholder: (context, url) {
            return Container(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
            );
          },
          errorWidget: (context, url, error) {
            return Container(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: const Icon(
                Icons.image_not_supported,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                article.title ?? 'No title',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            if (isRemoveable)
              IconButton(
                onPressed: () {
                  onRemove?.call(article);
                },
                icon: Icon(
                  Icons.delete_outline,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          article.description ?? '',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(
              Icons.schedule_outlined,
              size: 14,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                article.publishedAt ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
