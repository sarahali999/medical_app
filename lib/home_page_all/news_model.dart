import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  Future<List<Article>> fetchArticles() async {
    final response = await http.get(Uri.parse(
        'https://newsdata.io/api/1/latest?apikey=pub_44521c8236902fa9a9522b31d5af4752f3bcd&q=pegasus&language=en'));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      return (parsed['results'] as List)
          .map<Article>((json) => Article.fromJson(json))
          .toList();
    } else {
      print('Failed to load news: ${response.statusCode}');
      throw Exception('Failed to load news');
    }
  }
}

class Article {
  final String title;
  final String link;
  final String description;
  final String imageUrl;

  Article({
    required this.title,
    required this.link,
    required this.description,
    required this.imageUrl,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? '',
      link: json['link'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['image_url'] ?? '',
    );
  }
}