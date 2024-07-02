import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp/src/features/forum_post/models/post_comment_model.dart';

class PostCommentRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addComment(PostCommentModel comment) async {
    await _firestore.collection('PostComment').doc(comment.commentID).set(comment.toMap());
  }

  Stream<List<PostCommentModel>> getComments(String parentID) {
    return _firestore.collection('PostComment')
      .where('ParentID', isEqualTo: parentID)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => PostCommentModel.fromMap(doc.data()))
          .toList());
  }
}
