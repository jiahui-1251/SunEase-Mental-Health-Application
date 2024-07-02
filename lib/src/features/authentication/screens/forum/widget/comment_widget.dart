import 'package:flutter/material.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/features/forum_post/models/post_comment_model.dart';

class CommentWidget extends StatelessWidget {
  final PostCommentModel comment;
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
                      Text(comment.commentContent),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      timeAgo(comment.commentTime.toDate()),
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