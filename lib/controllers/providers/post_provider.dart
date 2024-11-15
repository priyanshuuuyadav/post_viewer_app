import 'dart:async';
import 'package:get/get.dart';
import '../services/api_services.dart';
import '/models/post.dart';

class PostController extends GetxController {
  var posts = <Post>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  final postService = PostService();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> loadPosts() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      var localPosts = await postService.getPostsFromLocal();
      if (localPosts.isNotEmpty) {
        posts.value = localPosts;
      }

      var fetchedPosts = await postService.fetchPosts();
      posts.value = fetchedPosts;
      await postService.savePostsToLocal(fetchedPosts);
    } catch (e) {
      errorMessage.value = 'Failed to load posts data. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  void markAsRead(int postId) {
    var post = posts.firstWhere((post) => post.id == postId);
    post.isRead = true;
    posts.refresh();
  }
}
