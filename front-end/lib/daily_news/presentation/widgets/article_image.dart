import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_constants.dart';
import 'package:news_app/daily_news/domain/entities/article.dart';

class ArticleImageWidget extends StatelessWidget {
  final ArticleEntity? article;

  const ArticleImageWidget({super.key, this.article});

  @override
  Widget build(BuildContext context) {
    final imageUrl = article?.urlToImage ?? '';

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: 100,
        height: 120,
        fit: BoxFit.cover,
        memCacheWidth: 300,
        placeholder: (_, __) => Container(
          color: AppConstants.borderColor,
          alignment: Alignment.center,
          child: const CircularProgressIndicator(strokeWidth: 2),
        ),
        errorWidget: (_, __, ___) => Container(
          color: AppConstants.borderColor,
          alignment: Alignment.center,
          child: const Icon(Icons.broken_image_outlined),
        ),
      ),
    );
  }
}
