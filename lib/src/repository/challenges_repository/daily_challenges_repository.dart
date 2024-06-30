import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp/src/features/authentication/screens/daily/models/daily_challenges_model.dart';
import 'package:get/get.dart';

class DailyChallengeRepository extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<DailyChallenge>> getDailyChallenges() async {
    final snapshot = await _firestore.collection('DailyChallenges').get();
    return snapshot.docs.map((doc) => DailyChallenge.fromSnapshot(doc)).toList();
  }
}
