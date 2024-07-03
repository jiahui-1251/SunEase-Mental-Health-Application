import 'package:flutter/material.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/features/authentication/screens/widgets/page_title_widget.dart';
import 'package:get/get.dart';
import 'package:fyp/src/features/authentication/screens/daily/controllers/mood_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class AddMoodScreen extends StatelessWidget {
  final DateTime date;
  final MoodController moodController = Get.find<MoodController>();
  final RxString selectedMood = ''.obs;

  AddMoodScreen({required this.date, super.key}) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    moodController.createMoodDocumentIfNotExists(userId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PageTitleWidget(title: "Add Mood", backgroundColor: tOrangeColor, backIcon: LineAwesomeIcons.angle_left_solid),
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
                    MoodButton(
                      imagePath: tHappyFace,
                      mood: 'happy',
                      onSelected: (mood) => selectedMood.value = mood,
                      isSelected: selectedMood.value == 'happy',
                    ),
                    MoodButton(
                      imagePath: tMadFace,
                      mood: 'mad',
                      onSelected: (mood) => selectedMood.value = mood,
                      isSelected: selectedMood.value == 'mad',
                    ),
                    MoodButton(
                      imagePath: tSadFace,
                      mood: 'sad',
                      onSelected: (mood) => selectedMood.value = mood,
                      isSelected: selectedMood.value == 'sad',
                    ),
                    MoodButton(
                      imagePath: tNormalFace,
                      mood: 'normal',
                      onSelected: (mood) => selectedMood.value = mood,
                      isSelected: selectedMood.value == 'normal',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (selectedMood.value.isNotEmpty) {
                        final userId = FirebaseAuth.instance.currentUser!.uid;
                        await moodController.addOrUpdateMood(userId, date, selectedMood.value);
                        Get.back();
                      } else {
                        Get.snackbar('Error', 'Please select a mood');
                      }
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
  final String mood;
  final Function(String) onSelected;
  final bool isSelected;

  const MoodButton({
    required this.imagePath,
    required this.mood,
    required this.onSelected,
    required this.isSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelected(mood),
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.grey[300] : tWhiteColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Image.asset(imagePath),
        ),
      ),
    );
  }
}
