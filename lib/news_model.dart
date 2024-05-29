class Article {
  final String id;
  final String title;
  final String description;
  final String url;
  final String imageUrl;
  final String publishedAt;
  final String source;

  Article({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.imageUrl,
    required this.publishedAt,
    required this.source,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] ?? '', // Adjust this if the API provides a different field for ID
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      imageUrl: json['image_url'] ?? '',
      publishedAt: json['published_at'] ?? '',
      source: json['source']['name'] ?? '', // Assuming source is an object with a name field
    );
  }
}
