import 'dart:convert';

import 'package:app1/riverpod/riverapi/post_model.dart';
import 'package:http/http.dart' as http;

class PostService {
  static const String baseUrl = "https://jsonplaceholder.typicode.com/posts";

  /// G E T

  Future<List<PostModel>> getPosts() async {
    final response = await http.get(
      Uri.parse(baseUrl),
    );
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => PostModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  /// P O S T

  Future<PostModel> createPost(PostModel post) async {
    final response = await http.post(Uri.parse(baseUrl),
        body: jsonEncode(post.toJson()),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 201) {
      return PostModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create post');
    }
  }

  /// P U T

  Future<PostModel> updatePost(PostModel post) async {
    final response = await http.put(
      Uri.parse("$baseUrl/${post.id}"),
      body: jsonEncode(post.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return PostModel.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw Exception("Failed to update post");
    }
  }

  /// D E L E T E

  Future<void> deletePost(int id) async {
    final response = await http.delete(Uri.parse("$baseUrl/$id"));
    if (response.statusCode != 200) {
      throw Exception("Failed to delete post");
    }
  }
}
