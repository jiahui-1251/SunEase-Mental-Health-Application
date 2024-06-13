import 'package:flutter/material.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/features/authentication/screens/widgets/horizontal_image_text.dart';
import 'package:fyp/src/features/authentication/screens/widgets/page_title_widget.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

// Define a class to hold icon and title data
class MeditationCategory {
  final IconData icon;
  final String title;

  MeditationCategory({required this.icon, required this.title});
}

// Create a list of CategoryItem instances
final List<MeditationCategory> categories = [
  MeditationCategory(icon: Iconsax.timer, title: 'Focus'),
  MeditationCategory(icon: Iconsax.wind, title: 'Relax'),
];

class MeditationScreen extends StatelessWidget {
  const MeditationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: PageTitleWidget(title: tMeditation),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  tCategory,
                  style: Theme.of(context).textTheme.titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              const SizedBox(height: tFormHeight - 20),

              Container(
                padding: const EdgeInsets.only(left: 20),
                height: 100,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: categories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    final category = categories[index];
                    return THorizontalImageText(
                      icon: category.icon,
                      title: category.title,
                      textColor: tBlackColor,
                      backgroundColor: tOrangeColor,
                      onTap: () {
                        // Handle the tap event
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: tFormHeight - 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  "Trending",
                  style: Theme.of(context).textTheme.titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              const SizedBox(height: tFormHeight - 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: size.width * 0.9,
                  height: size.height * 0.3,
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: tGreyColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(tMeditationImage1), // Replace with your image asset
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.6),
                        BlendMode.dstATop,
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Allow the column to take the minimum height
                    children: [
                      // First Row
                      Flexible(
                        flex: 1,
                        fit: FlexFit.loose, // Allow the child to take only the necessary height
                        child: Align(
                          alignment: Alignment.topRight,
                          child: PopupMenuButton(
                            onSelected: (value) {
                              // Handle the remove action
                            },
                            itemBuilder: (BuildContext context) => [
                              const PopupMenuItem(
                                value: 'remove',
                                child: Text('Remove'),
                              ),
                            ],
                            child: Icon(
                              Icons.more_horiz,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),

                      // Second Row
                      Flexible(
                        flex: 2,
                        fit: FlexFit.loose, // Allow the child to take only the necessary height
                        child: Container(),
                      ),

                      // Third Row
                      Flexible(
                        flex: 2,
                        fit: FlexFit.loose, // Allow the child to take only the necessary height
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Stress Relief',
                                    style: Theme.of(context).textTheme.titleSmall,
                                  ),
                                  Text(
                                    '5 mins | beg.',
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () {
                                  // Handle play/pause action
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.black, width: 2),
                                      ),
                                      child: Icon(Icons.play_arrow, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
