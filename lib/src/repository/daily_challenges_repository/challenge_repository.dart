// repository/challenge_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp/src/features/authentication/screens/daily/models/daily_challenges_model.dart';
import 'package:fyp/src/features/authentication/screens/daily/models/user_challenges_model.dart';

class ChallengeRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<DailyChallengeModel>> getDailyChallenges() async {
    QuerySnapshot querySnapshot = await _firestore.collection('DailyChallenges').get();
    return querySnapshot.docs.map((doc) => DailyChallengeModel.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
  }

  Future<UserChallengesModel?> getUserChallenge(String userId) async {
    DocumentSnapshot docSnapshot = await _firestore.collection('UserChallenges').doc(userId).get();
    if (docSnapshot.exists) {
      return UserChallengesModel.fromMap(docSnapshot.data() as Map<String, dynamic>, docSnapshot.id);
    }
    return null;
  }

  Future<void> createUserChallenge(UserChallengesModel userChallenge) async {
    await _firestore.collection('UserChallenges').doc(userChallenge.UserID).set(userChallenge.toMap());
  }

  Future<void> updateUserChallenge(UserChallengesModel userChallenge) async {
    await _firestore.collection('UserChallenges').doc(userChallenge.UserID).update(userChallenge.toMap());
  }
}
