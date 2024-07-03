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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addComment(String postId) async {
    if (commentController.text.trim().isEmpty) return;

    final comment = PostCommentModel(
      commentID: _firestore.collection('PostComment').doc().id,
      parentID: postId,
      commentContent: commentController.text.trim(),
      commentTime: Timestamp.now(),
      userType: 'User', // replace with actual user type if necessary
      likeNum: 0,
    );

    await _firestore.runTransaction((transaction) async {
      final postRef = _firestore.collection('ForumPost').doc(postId);
      final postSnapshot = await transaction.get(postRef);
      if (!postSnapshot.exists) {
        throw Exception("Post does not exist!");
      }

      int newComNum = postSnapshot.get('ComNum') + 1;
      transaction.set(_firestore.collection('PostComment').doc(comment.commentID), comment.toMap());
      transaction.update(postRef, {'ComNum': newComNum});
    });

    commentController.clear();
  }


    Future<void> _increaseCommentCount(String postID) async {
    final postRef = FirebaseFirestore.instance.collection('ForumPost').doc(postID);
    await postRef.update({'ComNum': FieldValue.increment(1)});
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

    Future<void> toggleLike(String commentID, bool isLiked) async {
    final DocumentReference commentRef = _firestore.collection('PostComment').doc(commentID);

    await _firestore.runTransaction((transaction) async {
      final DocumentSnapshot snapshot = await transaction.get(commentRef);
      if (!snapshot.exists) {
        throw Exception("Comment does not exist!");
      }

      int newLikeNum = snapshot.get('likeNum');
      if (isLiked) {
        newLikeNum -= 1;
      } else {
        newLikeNum += 1;
      }

      transaction.update(commentRef, {'likeNum': newLikeNum});
    });
  }
}
