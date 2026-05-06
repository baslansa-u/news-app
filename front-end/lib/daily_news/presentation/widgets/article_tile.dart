import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_constants.dart';
import 'package:news_app/daily_news/domain/entities/article.dart';
import 'package:news_app/daily_news/presentation/widgets/article_image.dart';

class ArticleWidget extends StatelessWidget {
  final ArticleEntity? article;
  final bool isRemoveable;
  final void Function(ArticleEntity article)? onRemove;
  final void Function(ArticleEntity article)? onArticlePressed;

  const ArticleWidget({
    super.key,
    this.article,
    this.isRemoveable = false,
    this.onRemove,
    this.onArticlePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingLarge,
        vertical: AppConstants.paddingSmall,
      ),
      decoration: BoxDecoration(
        color: AppConstants.surfaceColor,
        borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
        border: Border.all(color: AppConstants.borderColor, width: 0.5),
        boxShadow: const [
          BoxShadow(
            color: Color(0x15000000),
            blurRadius: 8,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
          onTap: () {
            if (onArticlePressed != null && article != null) {
              onArticlePressed!(article!);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.paddingMedium),
            child: Row(
              children: [
                ArticleImageWidget(article: article),
                const SizedBox(width: AppConstants.paddingLarge),
                Expanded(child: _buildTextContent(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleRow(context),
        const SizedBox(height: AppConstants.paddingSmall),
        Text(
          article?.description ?? '',
          maxLines: AppConstants.descriptionMaxLines,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppConstants.textSecondary,
              ),
        ),
        const SizedBox(height: AppConstants.paddingSmall),
        Row(
          children: [
            const Icon(Icons.schedule_outlined,
                size: 16, color: AppConstants.textTertiary),
            const SizedBox(width: AppConstants.paddingXSmall),
            Text(
              article?.publishedAt ?? '',
              style: const TextStyle(
                fontSize: AppConstants.fontSizeSmall,
                color: AppConstants.textTertiary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTitleRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            article?.title ?? 'No title',
            maxLines: AppConstants.titleMaxLines,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: AppConstants.fontSizeLarge,
              fontWeight: FontWeight.w700,
              color: AppConstants.textPrimary,
            ),
          ),
        ),
        if (isRemoveable)
          GestureDetector(
            onTap: () {
              if (onRemove != null && article != null) {
                onRemove!(article!);
              }
            },
            child: const Icon(Icons.delete_outline,
                color: AppConstants.errorColor),
          ),
      ],
    );
  }
}
