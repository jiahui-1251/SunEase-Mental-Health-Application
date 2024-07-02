import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp/src/features/authentication/screens/daily/models/user_mood_model.dart';

class MoodRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _collection = FirebaseFirestore.instance.collection('UserMood');

  Future<UserMood?> getUserMood(String UserID) async {
    final snapshot = await _collection.where('UserID', isEqualTo: UserID).get();
    if (snapshot.docs.isNotEmpty) {
      return UserMood.fromJson(snapshot.docs.first.data() as Map<String, dynamic>);
    }
    return null;
  }

  Future<void> createUserMood(UserMood UserMood) async {
    await _collection.add(UserMood.toJson());
  }

  Future<void> updateUserMood(UserMood UserMood) async {
    final snapshot = await _collection.where('UserID', isEqualTo: UserMood.UserID).get();
    if (snapshot.docs.isNotEmpty) {
      await _collection.doc(snapshot.docs.first.id).update(UserMood.toJson());
    }
  }
}
