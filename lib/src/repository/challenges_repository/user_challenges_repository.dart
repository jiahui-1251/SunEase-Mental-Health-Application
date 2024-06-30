import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp/src/features/authentication/screens/daily/models/daily_challenges_model.dart';
import 'package:fyp/src/features/authentication/screens/daily/models/user_challenges_model.dart';
import 'package:get/get.dart';
import 'package:fyp/src/features/authentication/models/user_model.dart';

class UserChallengeRepository extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUserChallenge(UserChallenge userChallenge) async {
    await _firestore.collection('UserChallenges').add(userChallenge.toJson());
  }

  Future<UserChallenge> getUserChallenge(String UserID) async {
    final snapshot = await _firestore.collection('UserChallenges')
      .where('UserID', isEqualTo: UserID)
      .get();
    return snapshot.docs.map((doc) => UserChallenge.fromSnapshot(doc)).single;
  }

  Future<void> updateUserChallenge(UserChallenge UserChallenges) async {
    final snapshot = await _firestore.collection('UserChallenges')
      .where('UserID', isEqualTo: UserChallenges.UserID)
      .get();
    final docId = snapshot.docs.single.id;
    await _firestore.collection('UserChallenges').doc(docId).update(UserChallenges.toJson());
  }
}