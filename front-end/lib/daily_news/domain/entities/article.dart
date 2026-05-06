import 'package:equatable/equatable.dart';

class ArticleEntity extends Equatable {
  final int? id;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  const ArticleEntity(
      {this.id,
      this.author,
      this.url,
      this.urlToImage,
      this.content,
      this.title,
      this.description,
      this.publishedAt});

  @override
  List<Object?> get props {
    return [
      id,
      author,
      title,
      url,
      urlToImage,
      description,
      publishedAt,
      content
    ];
  }
}
