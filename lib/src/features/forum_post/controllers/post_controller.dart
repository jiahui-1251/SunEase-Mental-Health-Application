import 'package:fyp/src/features/forum_post/models/forum_model.dart';
import 'package:fyp/src/repository/forum_repository/forum_repository.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  static PostController get instance => Get.find();

  final _forumPostRepo = Get.find<ForumPostRepository>();

  //Future<List<ForumPostModel>> getAllPosts() async {
    // return await _forumPostRepo.getAllPosts();
  //}

  Future<void> createPost(ForumPostModel post) async {
    await _forumPostRepo.createPost(post);
  }
}
