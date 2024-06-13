import 'package:flutter/material.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/features/authentication/screens/meditation/meditation_audio_widget.dart';
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

              MeditationAudioWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

