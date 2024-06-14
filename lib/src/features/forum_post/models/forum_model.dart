import 'package:cloud_firestore/cloud_firestore.dart';

class ForumPostModel {
  final String? PostID;
  final String Category;
  final int? ComNum;
  final int? LikeNum;
  final String PostContent;
  final Timestamp PostDateTime;
  final String PostTitle;

  //Constructor
  ForumPostModel({
    this.PostID,
    required this.Category,
    this.ComNum = 0,
    this.LikeNum = 0,
    required this.PostContent,
    required this.PostDateTime,
    required this.PostTitle,
  });

  //Empty Helper Function
  static ForumPostModel empty() => ForumPostModel(
    Category: '',
    PostContent: '',
    PostDateTime: Timestamp.now(), 
    PostTitle: ''
  );

  //Convert model to JSON structure so that you can store data in Firebase
  Map<String, dynamic> toJson() {
    return {
      "PostID": PostID,
      "Category": Category,
      "ComNum": ComNum,
      "LikeNum": LikeNum,
      "PostContent": PostContent,
      "PostDateTime": PostDateTime,
      "PostTitle": PostTitle,
    };
  }

  //Factory constructor to create an instance from a Firestore snapshot
  factory ForumPostModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      // Map JSON record to the model
      return ForumPostModel(
        PostID: document.id,
        Category: data['Category'] ?? '', 
        ComNum: data['ComNum'] ?? 0, 
        LikeNum: data['LikeNum'] ?? 0, 
        PostContent: data['PostContent'] ?? '', 
        PostDateTime: data['PostDateTime'] ?? Timestamp.now(), 
        PostTitle: data['PostTitle'] ?? '', 
      );
    } else {
      return ForumPostModel.empty();
    }
  }
}
