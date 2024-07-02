import 'package:cloud_firestore/cloud_firestore.dart';

class PostCommentModel {
  final String commentID;
  final String parentID;
  final int likeNum;
  final Timestamp commentTime;
  final String userType;
  final String commentContent;

  PostCommentModel({
    required this.commentID,
    required this.parentID,
    required this.likeNum,
    required this.commentTime,
    required this.userType,
    required this.commentContent,
  });

  Map<String, dynamic> toMap() {
    return {
      'CommentID': commentID,
      'ParentID': parentID,
      'LikeNum': likeNum,
      'CommentTime': commentTime,
      'UserType': userType,
      'CommentContent': commentContent,
    };
  }

  factory PostCommentModel.fromMap(Map<String, dynamic> map) {
    return PostCommentModel(
      commentID: map['CommentID'] ?? '',
      parentID: map['ParentID'] ?? '',
      likeNum: map['LikeNum'] ?? 0,
      commentTime: map['CommentTime'],
      userType: map['UserType'] ?? '',
      commentContent: map['CommentContent'] ?? '',
    );
  }
}
