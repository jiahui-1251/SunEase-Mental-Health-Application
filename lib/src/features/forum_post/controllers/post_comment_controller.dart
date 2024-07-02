import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/src/features/forum_post/models/post_comment_model.dart';
import 'package:fyp/src/repository/forum_repository/post_comment_repository.dart';
import 'package:get/get.dart';

class PostCommentController extends GetxController {
  final PostCommentRepository _repository = PostCommentRepository();
  final TextEditingController commentController = TextEditingController();
  final RxList<PostCommentModel> comments = <PostCommentModel>[].obs;

  void addComment(String parentID) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final userType = await _getUserType(userId);

    final comment = PostCommentModel(
      commentID: FirebaseFirestore.instance.collection('PostComment').doc().id,
      parentID: parentID,
      likeNum: 0,
      commentTime: Timestamp.now(),
      userType: userType,
      commentContent: commentController.text,
    );

    await _repository.addComment(comment);
    commentController.clear();
  }

  Future<String> _getUserType(String userId) async {
    final userDoc = await FirebaseFirestore.instance.collection('Users').doc(userId).get();
    return userDoc.data()?['UserType'] ?? 'User';
  }

  void loadComments(String parentID) {
    _repository.getComments(parentID).listen((newComments) {
      comments.value = newComments;
    });
  }
}
