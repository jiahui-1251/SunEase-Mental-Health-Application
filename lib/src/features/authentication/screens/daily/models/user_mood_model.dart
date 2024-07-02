import 'package:cloud_firestore/cloud_firestore.dart';

class UserMood {
  String UserID;
  List<Timestamp> Date;
  List<String> Mood;

  UserMood({
    required this.UserID,
    required this.Date,
    required this.Mood,
  });

  factory UserMood.fromJson(Map<String, dynamic> json) {
    return UserMood(
      UserID: json['UserID'],
      Date: (json['Date'] as List).map((e) => e as Timestamp).toList(),
      Mood: List<String>.from(json['Mood']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UserID': UserID,
      'Date': Date,
      'Mood': Mood,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'UserID': UserID,
      'Date': Date,
      'Mood': Mood,
    };
  }
}
