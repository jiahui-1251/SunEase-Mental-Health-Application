// import 'package:flutter/material.dart';
// import 'package:fyp/src/constants/colors.dart';
// import 'package:fyp/src/constants/sizes.dart';
// import 'package:fyp/src/constants/text_strings.dart';
// import 'package:fyp/src/features/authentication/screens/widgets/page_title_widget.dart';
// import 'package:fyp/src/features/authentication/screens/daily/widget/challenge_tile_widget.dart';

// class DailyScreen extends StatefulWidget {
//   const DailyScreen({super.key});

//   @override
//   _DailyScreenState createState() => _DailyScreenState();
// }

// class _DailyScreenState extends State<DailyScreen> {
//   bool isChecked = false;

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return SafeArea(
//       child: Scaffold(
//         appBar: PageTitleWidget(title: tDaily),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 15),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(15.0),
//                       child: Text(
//                         "Daily Challenges",
//                         style: Theme.of(context).textTheme.titleSmall,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     const SizedBox(height: tFormHeight - 30),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             // Progress Bar
//                             child: Container(
//                               height: 20.0,
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(10.0),
//                                 child: LinearProgressIndicator(
//                                   value: 0.7,
//                                   color: tYellowColor,
//                                   backgroundColor: tGreyColor,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 10),
//                           ElevatedButton(
//                             onPressed: () {
//                               // Handle the button press
//                             },
//                             style: ElevatedButton.styleFrom(
//                               shape: const CircleBorder(),
//                               padding: const EdgeInsets.all(15),
//                               backgroundColor: tOrangeColor,
//                             ),
//                             child: Icon(
//                               Icons.refresh_outlined,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: tFormHeight - 10),

//                     // Daily Challenges Widget
//                     ChallengeTile(
//                       title: "Say You're Great",
//                       description: "Write down a list of things you like about yourself and stuff you excel at.",
//                       benefitDescription: "Focusing on your strengths makes you feel more complete and powerful, while focusing on your shortcomings leads to feelings of incompleteness and stress.",
//                       isChecked: isChecked,
//                       onChanged: (bool? value) {
//                         setState(() {
//                           isChecked = value!;
//                         });
//                       }
//                     ),

//                     const SizedBox(height: tFormHeight-15),

//                     ChallengeTile(
//                       title: "Say You're Great",
//                       description: "Write down a list of things you like about yourself and stuff you excel at.",
//                       benefitDescription: "Focusing on your strengths makes you feel more complete and powerful, while focusing on your shortcomings leads to feelings of incompleteness and stress.",
//                       isChecked: isChecked,
//                       onChanged: (bool? value) {
//                         setState(() {
//                           isChecked = value!;
//                         });
//                       }
//                     ),

//                     const SizedBox(height: tFormHeight-15),

//                     ChallengeTile(
//                       title: "Say You're Great",
//                       description: "Write down a list of things you like about yourself and stuff you excel at.",
//                       benefitDescription: "Focusing on your strengths makes you feel more complete and powerful, while focusing on your shortcomings leads to feelings of incompleteness and stress.",
//                       isChecked: isChecked,
//                       onChanged: (bool? value) {
//                         setState(() {
//                           isChecked = value!;
//                         });
//                       }
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:fyp/src/features/authentication/screens/daily/daily_challenge_controller.dart';
import 'package:get/get.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/features/authentication/screens/widgets/page_title_widget.dart';
import 'package:fyp/src/features/authentication/screens/daily/widget/challenge_tile_widget.dart';

class DailyScreen extends StatelessWidget {
  const DailyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final dailyChallengeController = Get.put(DailyChallengeController());

    return SafeArea(
      child: Scaffold(
        appBar: PageTitleWidget(title: tDaily),
        body: Obx(() {
          if (dailyChallengeController.userChallenge.value == null || dailyChallengeController.dailyChallenges.isEmpty) {
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
                        padding: const EdgeInsets.all(15.0),
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
                            ElevatedButton(
                              onPressed: () async {
                                await dailyChallengeController.loadUserChallenges();
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
                      ...dailyChallengeController.dailyChallenges.map((challenge) {
                        int index = dailyChallengeController.userChallenge.value!.ChallengeID.indexOf(challenge.ChallengeID);
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
