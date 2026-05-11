import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_constants.dart';
import 'package:news_app/daily_news/domain/entities/article.dart';

class ArticleImageWidget extends StatelessWidget {
  final ArticleEntity? article;

  const ArticleImageWidget({super.key, this.article});

  @override
  Widget build(BuildContext context) {
    final imageUrl = article?.urlToImage;

    if (imageUrl == null || imageUrl.isEmpty) {
      return Container(
        width: 100,
        height: 120,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Icon(
          Icons.broken_image_outlined,
          color: Theme.of(context).textTheme.labelSmall?.color,
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: 100,
        height: 120,
        fit: BoxFit.cover,
        memCacheWidth: 200,
        fadeInDuration: const Duration(milliseconds: 150),
        placeholder: (context, __) => Container(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        errorWidget: (context, __, ___) => Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Icon(
            Icons.broken_image_outlined,
            color: Theme.of(context).textTheme.labelSmall?.color,
          ),
        ),
      ),
    );
  }
}
