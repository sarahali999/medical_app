import 'dart:convert';
import 'package:http/http.dart' as http;
import 'news_model.dart'; // Assuming the updated Article class is saved in article_model.dart

class ArticleService {
  final String apiUrl = 'https://www.thenewsapi.com/email/verify/6930/a99e93790070de3143bda77a3a3d6d685239e458?expires=1716880917&signature=fef04a86ce7182c73f50125c7da4f3efe8cc8da5f03c60df6ed9a7f085d40ab5';

  Future<List<Article>> fetchArticles() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body)['data']; // Ensure the correct JSON key is used
        return jsonResponse.map((article) => Article.fromJson(article)).toList();
      } else {
        print('Failed to load articles, status code: ${response.statusCode}');
        throw Exception('Failed to load articles');
      }
    } catch (e) {
      print('Error occurred: $e');
      throw Exception('Failed to load articles');
    }
  }
}
