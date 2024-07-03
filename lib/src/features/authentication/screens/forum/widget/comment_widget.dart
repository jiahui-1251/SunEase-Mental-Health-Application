import 'package:flutter/material.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/features/forum_post/controllers/post_comment_controller.dart';
import 'package:fyp/src/features/forum_post/models/post_comment_model.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentWidget extends StatefulWidget {
  final PostCommentModel comment;
  final String Function(DateTime) timeAgo;

  CommentWidget({required this.comment, required this.timeAgo});

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  final PostCommentController _controller = Get.find<PostCommentController>();
  bool isLiked = false;
  int likeNum = 0;

  @override
  void initState() {
    super.initState();
    // Initialize isLiked and likeNum
    isLiked = false; // You may want to fetch this from Firestore based on the user's interaction
    likeNum = widget.comment.likeNum;
  }

  DateTime _convertTimestampToDateTime(Timestamp timestamp) {
    return timestamp.toDate();
  }

  void _toggleLike() async {
    await _controller.toggleLike(widget.comment.commentID, isLiked);
    setState(() {
      if (isLiked) {
        likeNum -= 1;
      } else {
        likeNum += 1;
      }
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    final commentTime = _convertTimestampToDateTime(widget.comment.commentTime);

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
                        widget.comment.userType,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(height: 5),
                      Text(widget.comment.commentContent),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      widget.timeAgo(commentTime),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    SizedBox(width: 20),
                    GestureDetector(
                      onTap: _toggleLike,
                      child: Row(
                        children: [
                          Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            size: 16,
                            color: tOrangeColor,
                          ),
                          SizedBox(width: 5),
                          Text(likeNum.toString(),
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ),
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
