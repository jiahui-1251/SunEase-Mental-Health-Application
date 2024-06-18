import 'package:get/get.dart';
import 'package:fyp/src/features/forum_post/models/forum_model.dart';
import 'package:fyp/src/repository/forum_repository/forum_repository.dart';

class PostController extends GetxController {
  static PostController get instance => Get.find();

  final _forumPostRepo = Get.find<ForumPostRepository>();

  Future<List<ForumPostModel>> getAllPosts() async {
    try {
      List<ForumPostModel> posts = await _forumPostRepo.getAllPosts();
      print("Fetched posts: ${posts.length}");
      return posts;
    } catch (e) {
      print("Error fetching posts: $e");
      return [];
    }
  }

  Future<void> createPost(ForumPostModel post) async {
    try {
      await _forumPostRepo.createPost(post);
    } catch (e) {
      print("Error creating post: $e");
    }
  }
}
