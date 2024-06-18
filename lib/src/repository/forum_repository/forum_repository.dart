import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fyp/src/features/forum_post/models/forum_model.dart';

class ForumPostRepository extends GetxController {
  static ForumPostRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<ForumPostModel>> getAllPosts() async {
    try {
      QuerySnapshot querySnapshot = await _db.collection("ForumPost").get();
      return querySnapshot.docs
          .map((doc) => ForumPostModel.fromSnapshot(doc as DocumentSnapshot<Map<String, dynamic>>))
          .toList();
    } catch (e) {
      print("Error fetching posts: $e");
      return [];
    }
  }

  Future<void> createPost(ForumPostModel post) async {
    await _db.collection("ForumPost").add(post.toJson()).whenComplete(
      () => Get.snackbar(
        "Success",
        "Your post has been created.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      ),
    ).catchError((error, stackTrace) {
      Get.snackbar(
        "Error",
        "Something went wrong. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
      print(error.toString());
    });
  }

  Future<void> toggleLike(String postId, bool isLiked, int currentLikeNum) async {
    try {
      if (isLiked) {
        // Decrease like count
        await _db.collection("ForumPost").doc(postId).update({
          "LikeNum": currentLikeNum - 1,
        });
      } else {
        // Increase like count
        await _db.collection("ForumPost").doc(postId).update({
          "LikeNum": currentLikeNum + 1,
        });
      }
    } catch (e) {
      print("Error toggling like: $e");
    }
  }
}
