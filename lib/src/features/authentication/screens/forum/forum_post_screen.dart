import 'package:flutter/material.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/features/authentication/screens/forum/widget/comment_widget.dart';
import 'package:fyp/src/features/forum_post/controllers/post_comment_controller.dart';
import 'package:fyp/src/features/forum_post/models/forum_model.dart';
import 'package:fyp/src/features/authentication/screens/widgets/page_title_widget.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ForumPostScreen extends StatefulWidget {
  final ForumPostModel post;

  ForumPostScreen({super.key, required this.post});

  @override
  _ForumPostScreenState createState() => _ForumPostScreenState();
}

class _ForumPostScreenState extends State<ForumPostScreen> {
  final PostCommentController _controller = Get.put(PostCommentController());

  @override
  void initState() {
    super.initState();
    _controller.loadComments(widget.post.PostID!);
  }

  String timeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays >= 1) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PageTitleWidget(title: "Forum Post", backIcon: LineAwesomeIcons.angle_left_solid),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.post.PostTitle, style: Theme.of(context).textTheme.titleSmall),
                    SizedBox(height: 10),
                    Text(widget.post.PostContent, style: Theme.of(context).textTheme.bodyMedium),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(Icons.favorite, color: tOrangeColor),
                        SizedBox(width: 5),
                        Text(widget.post.LikeNum.toString()),
                        SizedBox(width: 20),
                        Icon(Icons.comment, color: tOrangeColor),
                        SizedBox(width: 5),
                        Text(widget.post.ComNum.toString()),
                      ],
                    ),
                    SizedBox(height: 20),
                    Divider(color: Colors.grey),
                    SizedBox(height: 10),
                    Text("Comments", style: Theme.of(context).textTheme.titleSmall),
                    SizedBox(height: 10),
                    Obx(() {
                      return Column(
                        children: _controller.comments.map((comment) {
                          return CommentWidget(
                            comment: comment,
                            timeAgo: timeAgo,
                          );
                        }).toList(),
                      );
                    }),
                    SizedBox(height: 80), // Extra space for the comment panel
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: tBlackColor,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: TextField(
                          controller: _controller.commentController,
                          decoration: InputDecoration(
                            hintText: 'Write a comment...',
                            hintStyle: Theme.of(context).textTheme.bodyMedium,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _controller.addComment(widget.post.PostID!);
                      },
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.black,
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
