import 'package:fyp/src/features/authentication/screens/daily/models/daily_challenges_model.dart';
import 'package:fyp/src/features/authentication/screens/daily/models/user_challenges_model.dart';
import 'package:fyp/src/repository/daily_challenges_repository/challenge_repository.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DailyChallengeController extends GetxController {
  final ChallengeRepository _challengeRepo = Get.put(ChallengeRepository());
  Rx<UserChallengesModel?> userChallenge = Rx<UserChallengesModel?>(null);
  RxList<DailyChallengeModel> dailyChallenges = RxList<DailyChallengeModel>();

  @override
  void onInit() {
    super.onInit();
    loadUserChallenges();
  }

  Future<void> loadUserChallenges() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    userChallenge.value = await _challengeRepo.getUserChallenge(userId);

    if (userChallenge.value == null) {
      List<DailyChallengeModel> allChallenges = await _challengeRepo.getDailyChallenges();
      allChallenges.shuffle();
      List<String> selectedChallengeIds = allChallenges.take(3).map((challenge) => challenge.ChallengeID).toList();
      List<bool> selectedChallengeStatus = [false, false, false];

      userChallenge.value = UserChallengesModel(
        UserID: userId,
        ChallengeID: selectedChallengeIds,
        ChallengeStatus: selectedChallengeStatus,
        Date: DateTime.now(),
        NumCompletion: 0,
      );

      await _challengeRepo.createUserChallenge(userChallenge.value!);
    }

    await _loadDailyChallenges();
  }

  Future<void> _loadDailyChallenges() async {
    List<DailyChallengeModel> allChallenges = await _challengeRepo.getDailyChallenges();
    dailyChallenges.value = allChallenges
        .where((challenge) => userChallenge.value!.ChallengeID.contains(challenge.ChallengeID))
        .toList();
  }

  Future<void> updateChallengeStatus(int index, bool status) async {
    userChallenge.value!.ChallengeStatus[index] = status;
    userChallenge.value!.NumCompletion = userChallenge.value!.ChallengeStatus.where((status) => status).length;
    await _challengeRepo.updateUserChallenge(userChallenge.value!);
    await _loadDailyChallenges();
  }

  Future<void> refreshChallenges() async {
    if (userChallenge.value!.NumCompletion < 3) {
      List<DailyChallengeModel> allChallenges = await _challengeRepo.getDailyChallenges();
      allChallenges.shuffle();
      List<String> selectedChallengeIds = allChallenges.take(3).map((challenge) => challenge.ChallengeID).toList();
      List<bool> selectedChallengeStatus = [false, false, false];

      userChallenge.value = UserChallengesModel(
        UserID: FirebaseAuth.instance.currentUser!.uid,
        ChallengeID: selectedChallengeIds,
        ChallengeStatus: selectedChallengeStatus,
        Date: DateTime.now(),
        NumCompletion: 0,
      );

      await _challengeRepo.createUserChallenge(userChallenge.value!);
      await _loadDailyChallenges();
    }
  }
}
