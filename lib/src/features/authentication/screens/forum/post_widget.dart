import 'package:flutter/material.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/constants/sizes.dart';

class PostWidget extends StatelessWidget {
  PostWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const SizedBox(height: tFormHeight - 20);
    return Column(
      children: [
        IntrinsicHeight(
          child: Container(
            width: size.width * 0.9,
            decoration: BoxDecoration(
              color: tGreyColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.black,
                        child: Icon(Icons.category, color: Colors.white),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Category Name',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            'Posted 2 hours ago',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '#12341afs',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Post Title',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                            ),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'This is the content of the post which contains a long string with style of bodyLarge.',
                    style: Theme.of(context).textTheme.bodyLarge,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.favorite_border, color: tOrangeColor),
                onPressed: () {
                  // Handle the like button press
                },
              ),
              IconButton(
                icon: Icon(Icons.comment, color: tOrangeColor),
                onPressed: () {
                  // Handle the comment button press
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

