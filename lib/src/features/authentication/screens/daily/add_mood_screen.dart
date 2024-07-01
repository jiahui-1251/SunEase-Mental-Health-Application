import 'package:flutter/material.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/features/authentication/screens/widgets/page_title_widget.dart';

class AddMoodScreen extends StatelessWidget {
  const AddMoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PageTitleWidget(title: "Add Mood", backgroundColor: tOrangeColor),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
                child: Text(
                  "What is your mood today?",
                  style: Theme.of(context).textTheme.titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MoodButton(imagePath: tHappyFace),
                    MoodButton(imagePath: tMadFace),
                    MoodButton(imagePath: tSadFace),
                    MoodButton(imagePath: tNormalFace),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle add mood action here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tBlackColor,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                    child: Text(
                      'Add Mood',
                      style: Theme.of(context).textTheme.bodyLarge!.apply(color: Colors.white),
                    ),
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

class MoodButton extends StatelessWidget {
  final String imagePath;

  const MoodButton({required this.imagePath, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Handle mood button tap action here
      },
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: tWhiteColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Image.asset(imagePath),
        ),
      ),
    );
  }
}
