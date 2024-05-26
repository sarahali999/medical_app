import 'dart:convert';
import 'package:http/http.dart' as http;
import 'news_model.dart';

class ProductService {

  final String apiUrl = 'https://dummyjson.com/products';

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body)['products']; // Ensure the correct JSON key is used
        return jsonResponse.map((product) => Product.fromJson(product)).toList();
      } else {
        print('Failed to load products, status code: ${response.statusCode}');
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error occurred: $e');
      throw Exception('Failed to load products');
    }
  }
}
