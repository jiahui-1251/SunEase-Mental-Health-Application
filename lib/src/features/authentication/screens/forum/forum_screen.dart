import 'package:flutter/material.dart';
import 'package:fyp/src/common_widgets/custom_shapes/container/primary_header_container.dart';
import 'package:fyp/src/features/authentication/controllers/authentication_controllers.dart';
import 'package:fyp/src/features/authentication/screens/forum/create_post_screen.dart';
import 'package:fyp/src/features/authentication/screens/login/login_screen.dart';
import 'package:get/get.dart';
import 'package:fyp/src/features/authentication/screens/forum/widget/post_widget.dart';
import 'package:fyp/src/features/forum_post/models/forum_model.dart';
import 'package:fyp/src/features/forum_post/controllers/post_controller.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/features/authentication/screens/widgets/page_title_widget.dart';
import 'package:fyp/src/features/authentication/screens/widgets/vertical_image_text.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

// Define a class to hold icon and title data
class CategoryItem {
  final IconData icon;
  final String title;

  CategoryItem({required this.icon, required this.title});
}

// Create a list of CategoryItem instances
final List<CategoryItem> categories = [
  CategoryItem(icon: Iconsax.book, title: 'Academic'),
  CategoryItem(icon: Iconsax.house, title: 'Family'),
  CategoryItem(icon: Iconsax.heart, title: 'Relationship'),
  CategoryItem(icon: Iconsax.map, title: 'Self-Exploration'),
  CategoryItem(icon: Iconsax.message_question, title: 'Others'),
];

class ForumScreen extends StatefulWidget {
  const ForumScreen({super.key});

  @override
  _ForumScreenState createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  String? selectedCategory;

  @override
  void dispose() {
    selectedCategory = null; // Reset the selected category when disposing the widget
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PostController postController = Get.find<PostController>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              setState(() {
                selectedCategory = null; // Reset the selected category when back button is pressed
              });
              Get.back();
            },
            icon: Icon(LineAwesomeIcons.angle_left_solid),
          ),
          title: Text(
            tForum,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          backgroundColor: tOrangeColor,
          actions: [
            IconButton(
              icon: const Icon(LineAwesomeIcons.sign_out_alt_solid),
              onPressed: () async {
                final signUpController = Get.find<SignUpController>();
                await signUpController.signOut();
                Get.offAll(() => const LoginScreen());
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TPrimaryHeaderContainer(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hi,",
                      style: Theme.of(context).textTheme.titleMedium!.apply(color: tWhiteColor),
                    ),
                    Text(
                      tForumSubTitle,
                      style: Theme.of(context).textTheme.bodyLarge!.apply(color: tWhiteColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        tCategory,
                        style: Theme.of(context).textTheme.titleSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      height: 80,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: categories.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          final category = categories[index];
                          return TVerticalImageText(
                            icon: category.icon,
                            title: category.title,
                            textColor: tBlackColor,
                            backgroundColor: tGreyColor,
                            onTap: () {
                              setState(() {
                                selectedCategory = category.title;
                              });
                            },
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        selectedCategory == null ? tTrendingPost : selectedCategory!,
                        style: Theme.of(context).textTheme.titleSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    FutureBuilder<List<ForumPostModel>>(
                      future: postController.getAllPosts(selectedCategory),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          // Print the error details in the console
                          print("Error: ${snapshot.error}");
                          return Center(child: Text("Error: ${snapshot.error}"));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Center(child: Text("No posts found."));
                        } else {
                          return Column(
                            children: snapshot.data!.map((post) => PostWidget(post: post)).toList(),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => CreatePostScreen());
          },
          backgroundColor: tOrangeColor,
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
