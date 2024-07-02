import 'package:flutter/material.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/features/authentication/screens/forum/forum_screen.dart';
import 'package:fyp/src/features/authentication/screens/forum/widget/expandable_text.dart';
import 'package:fyp/src/features/forum_post/models/forum_model.dart';
import 'package:fyp/src/repository/forum_repository/forum_repository.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:fyp/src/features/authentication/screens/forum/forum_post_screen.dart';

class PostWidget extends StatefulWidget {
  final ForumPostModel post;

  PostWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  late int likeNum;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    likeNum = widget.post.LikeNum ?? 0;
  }

  void _toggleLike() async {
    await ForumPostRepository.instance.toggleLike(widget.post.PostID!, isLiked, likeNum);
    setState(() {
      if (isLiked) {
        likeNum -= 1;
      } else {
        likeNum += 1;
      }
      isLiked = !isLiked;
    });
  }

  // Define the timeAgo method
  String timeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 8) {
      return DateFormat('MM/dd/yyyy').format(dateTime);
    } else if (difference.inDays >= 1) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'just now';
    }
  }

  IconData _getCategoryIcon(String category) {
    for (CategoryItem item in categories) {
      if (item.title.toLowerCase() == category.toLowerCase()) {
        return item.icon;
      }
    }
    return Iconsax.message_question; // Default icon if no match found
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Get.to(() => ForumPostScreen(post: widget.post));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  color: tGreyColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: Icon(
                            _getCategoryIcon(widget.post.Category),
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.post.Category,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              'Posted ${timeAgo(widget.post.PostDateTime)}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '#${widget.post.PostID}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.post.PostTitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    ExpandableText(widget.post.PostContent),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: tOrangeColor,
                      ),
                      onPressed: _toggleLike,
                    ),
                    Text('$likeNum', style: TextStyle(color: tOrangeColor)),
                    IconButton(
                      icon: Icon(Icons.comment, color: tOrangeColor),
                      onPressed: () {
                        Get.to(() => ForumPostScreen(post: widget.post));
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
