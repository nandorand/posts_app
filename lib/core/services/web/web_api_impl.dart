import 'dart:convert';

import 'package:posts_app/core/business_logic/models/post.dart';
import 'package:posts_app/core/services/web/web_api.dart';

import 'package:http/http.dart' as http;

class WebApiImpl implements WebApi {
  Future<List<Post>> fetchAllPosts() async {
    final String url = 'https://jsonplaceholder.typicode.com/posts';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Iterable results = jsonDecode(response.body);
      return results.map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception("Failed to get request");
    }
  }
}
