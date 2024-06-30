import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp/src/features/authentication/screens/daily/models/daily_challenges_model.dart';
import 'package:fyp/src/features/authentication/screens/daily/models/user_challenges_model.dart';
import 'package:fyp/src/repository/challenges_repository/daily_challenges_repository.dart';
import 'package:fyp/src/repository/challenges_repository/user_challenges_repository.dart';
import 'package:get/get.dart';

class ChallengeController extends GetxController {
  final UserChallengeRepository _userChallengeRepo = Get.put(UserChallengeRepository());
  final DailyChallengeRepository _dailyChallengeRepo = Get.put(DailyChallengeRepository()); // Initialize here

  final Rx<UserChallenge?> userChallenge = Rx<UserChallenge?>(null);

  void loadUserChallenge(String userId) async {
    userChallenge.value = await _userChallengeRepo.getUserChallenge(userId);
  }

  void updateChallengeStatus(String userId, int index, bool status) async {
    UserChallenge? uc = userChallenge.value;
    if (uc != null) {
      uc.ChallengeStatus[index] = status;
      uc.NumCompletion = uc.ChallengeStatus.where((s) => s).length;
      await _userChallengeRepo.updateUserChallenge(uc);
      userChallenge.value = uc;
    }
  }

  Future<void> assignDailyChallengesToUser(String userId) async {
    List<DailyChallenge> dailyChallenges = await _dailyChallengeRepo.getDailyChallenges();
    dailyChallenges.shuffle();
    List<DailyChallenge> selectedChallenges = dailyChallenges.take(3).toList();

    List<String> challengeIds = selectedChallenges.map((challenge) => challenge.ChallengeID).toList();
    List<bool> challengeStatus = List<bool>.filled(3, false);

    UserChallenge newUserChallenge = UserChallenge(
      UserID: userId,
      ChallengeID: challengeIds,
      ChallengeStatus: challengeStatus,
      Date: Timestamp.now(),
      NumCompletion: 0,
    );

    await _userChallengeRepo.createUserChallenge(newUserChallenge);
    userChallenge.value = newUserChallenge;
  }
}
