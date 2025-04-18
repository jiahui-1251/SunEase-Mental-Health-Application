import 'package:flutter/material.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/features/authentication/screens/daily/models/user_mood_model.dart';
import 'package:fyp/src/features/authentication/screens/daily/widget/timestamp_extension.dart';
import 'package:fyp/src/repository/daily_challenges_repository/mood_repository.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MoodController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final MoodRepository _moodRepository = MoodRepository();
  RxBool isLoading = false.obs;
  RxList<UserMood> moods = <UserMood>[].obs;

  Future<void> createMoodDocumentIfNotExists(String userID) async {
    final docRef = _firestore.collection('UserMood').doc(userID);

    final docSnapshot = await docRef.get();
    if (!docSnapshot.exists) {
      // Create a new UserMood document
      final newMood = UserMood(
        UserID: userID,
        Date: [],
        Mood: [],
      );
      await docRef.set(newMood.toJson());
    }
  }

  Future<void> loadUserMood(String userID) async {
    isLoading.value = true;
    try {
      final userMood = await _moodRepository.getUserMood(userID);
      if (userMood != null) {
        moods.assignAll([userMood]);
      } else {
        moods.clear();
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addOrUpdateMood(String userID, DateTime date, String mood) async {
    isLoading.value = true;
    try {
      final existingMood = moods.firstWhere(
        (m) => m.UserID == userID,
        orElse: () => UserMood(UserID: userID, Date: [], Mood: []),
      );

      final dateIndex = existingMood.Date.indexWhere((d) => d.toDate().isSameDate(date));
      if (dateIndex != -1) {
        existingMood.Mood[dateIndex] = mood;
      } else {
        existingMood.Date.add(Timestamp.fromDate(date));
        existingMood.Mood.add(mood);
      }

      if (existingMood.Date.isEmpty && existingMood.Mood.isEmpty) {
        await _moodRepository.createUserMood(existingMood);
      } else {
        await _moodRepository.updateUserMood(existingMood);
      }

      // Refresh user mood data
      loadUserMood(userID);
    } finally {
      isLoading.value = false;
    }
  }

  Color getMoodColor(String mood) {
    switch (mood) {
      case 'happy':
        return Colors.orange;
      case 'mad':
        return Colors.red;
      case 'sad':
        return tGreyColor;
      case 'normal':
        return Colors.yellow;
      default:
        return const Color.fromARGB(255, 220, 218, 218);
    }
  }
}
