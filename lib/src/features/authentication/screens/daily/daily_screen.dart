import 'package:flutter/material.dart';
import 'package:fyp/src/features/authentication/screens/daily/add_mood_screen.dart';
import 'package:fyp/src/features/authentication/screens/daily/controllers/daily_challenge_controller.dart';
import 'package:fyp/src/features/authentication/screens/daily/controllers/mood_controller.dart';
import 'package:fyp/src/features/authentication/screens/daily/widget/timestamp_extension.dart';
import 'package:get/get.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/features/authentication/screens/widgets/page_title_widget.dart';
import 'package:fyp/src/features/authentication/screens/daily/widget/challenge_tile_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class DailyScreen extends StatefulWidget {
  const DailyScreen({super.key});

  @override
  _DailyScreenState createState() => _DailyScreenState();
}

class _DailyScreenState extends State<DailyScreen> {
  final int _initialPage = 10000; // Large number for middle point
  final PageController _pageController = PageController(initialPage: 10000);
  int _currentPage = 10000;
  final MoodController moodController = Get.put(MoodController()); // Initialize MoodController

  @override
  void initState() {
    super.initState();
    // Load user mood data when the screen is initialized
    final userId = FirebaseAuth.instance.currentUser!.uid;
    moodController.loadUserMood(userId);
  }

  DateTime getDateForPage(int page) {
    final today = DateTime.now();
    return today.add(Duration(days: 7 * (page - _initialPage)));
  }

  List<DateTime> getDaysOfWeek(DateTime date) {
    final startOfWeek = date.subtract(Duration(days: date.weekday - 1));
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }

  String getMonthYearString(DateTime date) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return "${months[date.month - 1]} ${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    final dailyChallengeController = Get.put(DailyChallengeController());

    return SafeArea(
      child: Scaffold(
        appBar: PageTitleWidget(title: tDaily,backgroundColor: tOrangeColor, backIcon: LineAwesomeIcons.smile),
        body: Obx(() {
          if (dailyChallengeController.userChallenge.value == null ||
              dailyChallengeController.dailyChallenges.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                        child: Text(
                          "Daily Challenges",
                          style: Theme.of(context).textTheme.titleSmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: tFormHeight - 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: [
                            Expanded(
                              // Progress Bar
                              child: Container(
                                height: 20.0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: LinearProgressIndicator(
                                    value: dailyChallengeController.userChallenge.value!.NumCompletion / 3,
                                    color: tYellowColor,
                                    backgroundColor: tGreyColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),

                            // Refresh or completed button
                            dailyChallengeController.userChallenge.value!.NumCompletion == 3
                                ? ElevatedButton(
                                    onPressed: null,
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(15),
                                      backgroundColor: tGreenColor,
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    ),
                                  )
                                : ElevatedButton(
                                    onPressed: () async {
                                      await dailyChallengeController.refreshChallenges();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(15),
                                      backgroundColor: tOrangeColor,
                                    ),
                                    child: Icon(
                                      Icons.refresh_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                          ],
                        ),
                      ),

                      const SizedBox(height: tFormHeight - 10),

                      // Challenge Widget
                      ...dailyChallengeController.dailyChallenges.map((challenge) {
                        int index = dailyChallengeController.userChallenge.value!.ChallengeID
                            .indexOf(challenge.ChallengeID);
                        if (index == -1) {
                          return SizedBox.shrink();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(bottom: tFormHeight - 15),
                          child: ChallengeTile(
                            title: challenge.ChallengeTitle,
                            description: challenge.ChallengeDescription,
                            benefitDescription: challenge.ChallengeBenefit,
                            isChecked: dailyChallengeController.userChallenge.value!.ChallengeStatus[index],
                            onChanged: (bool? value) {
                              dailyChallengeController.updateChallengeStatus(index, value!);
                            },
                          ),
                        );
                      }).toList(),

                      const SizedBox(height: tFormHeight),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          "Mood Tracker",
                          style: Theme.of(context).textTheme.titleSmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          getMonthYearString(getDateForPage(_currentPage)),
                          style: Theme.of(context).textTheme.bodyLarge,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      const SizedBox(height: 10),

                      SizedBox(
                        height: 60,
                        child: PageView.builder(
                          controller: _pageController,
                          onPageChanged: (int page) {
                            setState(() {
                              _currentPage = page;
                            });
                          },
                          itemBuilder: (context, pageIndex) {
                            final date = getDateForPage(pageIndex);
                            final daysOfWeek = getDaysOfWeek(date);
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: daysOfWeek.map((date) {
                                return Expanded(
                                  child: InkWell(
                                    onTap: () async {
                                      final userId = FirebaseAuth.instance.currentUser!.uid;
                                      await Get.to(() => AddMoodScreen(date: date)); // Navigate to add_mood_screen.dart
                                      await moodController.loadUserMood(userId); // Reload user moods after adding mood
                                    },
                                    child: Obx(() {
                                      // Only wrap the widgets that depend on observable variables in Obx
                                      final userId = FirebaseAuth.instance.currentUser!.uid;
                                      final mood = moodController.moods
                                          .where((m) => m.UserID == userId)
                                          .expand((m) => m.Date
                                              .asMap()
                                              .entries
                                              .where((e) => e.value.isSameDate(date))
                                              .map((e) => m.Mood[e.key]))
                                          .firstOrNull;

                                      final color = mood != null
                                          ? moodController.getMoodColor(mood)
                                          : const Color.fromARGB(255, 220, 218, 218);

                                      return Column(
                                        children: [
                                          Text(
                                            ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"][date.weekday - 1],
                                            style: Theme.of(context).textTheme.bodyMedium,
                                          ),
                                          const SizedBox(height: 3),
                                          Container(
                                            width: 35,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              color: color,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: Text(
                                                "${date.day}",
                                                style: Theme.of(context).textTheme.bodyMedium,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: tFormHeight),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
