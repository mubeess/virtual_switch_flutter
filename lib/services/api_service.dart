import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';
import '../models/comment.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/posts'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<Post> fetchPost(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/posts/$id'));

    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<List<Comment>> fetchComments(int postId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/posts/$postId/comments'),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.take(3).map((json) => Comment.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }
}
