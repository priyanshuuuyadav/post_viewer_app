import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/post.dart';

class PostService {
  final String baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts data');
    }
  }

  Future<Post> fetchPostById(int postId) async {
    final response = await http.get(Uri.parse('$baseUrl/$postId'));
    if (response.statusCode == 200) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post details data');
    }
  }

  Future<void> savePostsToLocal(List<Post> posts) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> jsonPosts = posts.map((post) => json.encode(post.toJson())).toList();
    print("jsonPosts.length   -->> ${jsonPosts.length}");
    await prefs.setStringList('posts', jsonPosts);
  }

  Future<List<Post>> getPostsFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? jsonPosts = prefs.getStringList('posts');
    if (jsonPosts != null) {
      return jsonPosts.map((jsonPost) => Post.fromJson(json.decode(jsonPost))).toList();
    }
    return [];
  }
}
