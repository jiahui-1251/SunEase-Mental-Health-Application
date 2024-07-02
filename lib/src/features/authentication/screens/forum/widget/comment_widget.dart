import 'package:flutter/material.dart';
import 'package:fyp/src/constants/colors.dart';

// Dummy comment model
class CommentModel {
  final String userType;
  final String content;
  final DateTime dateTime;
  final int likeNum;

  CommentModel({
    required this.userType,
    required this.content,
    required this.dateTime,
    required this.likeNum,
  });
}

// Dummy comments data
final List<CommentModel> comments = [
  CommentModel(userType: 'Counsellor', content: 'Great post!', dateTime: DateTime.now().subtract(Duration(minutes: 28)), likeNum: 5),
  CommentModel(userType: 'User', content: 'Thank you for sharing.', dateTime: DateTime.now().subtract(Duration(hours: 1)), likeNum: 3),
];

class CommentWidget extends StatelessWidget {
  final CommentModel comment;
  final String Function(DateTime) timeAgo;

  const CommentWidget({required this.comment, required this.timeAgo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: tOrangeColor,
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comment.userType,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(height: 5),
                      Text(comment.content),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      timeAgo(comment.dateTime),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    SizedBox(width: 20),
                    Icon(Icons.favorite_border, size: 16, color: tOrangeColor),
                    SizedBox(width: 5),
                    Text(comment.likeNum.toString(), style: Theme.of(context).textTheme.bodySmall),
                    SizedBox(width: 20),
                    Icon(Icons.reply, size: 16, color: tOrangeColor),
                    SizedBox(width: 5),
                    Text('Reply', style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
