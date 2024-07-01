import 'package:cloud_firestore/cloud_firestore.dart';

class UserMood {
  String UserID;
  List<DateTime> Date;
  List<String> Mood;

  UserMood({
    required this.UserID,
    required this.Date,
    required this.Mood,
  });

  factory UserMood.fromJson(Map<String, dynamic> json) {
    return UserMood(
      UserID: json['UserID'],
      Date: (json['Date'] as List).map((e) => (e as Timestamp).toDate()).toList(),
      Mood: List<String>.from(json['Mood']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UserID': UserID,
      'Date': Date.map((e) => Timestamp.fromDate(e)).toList(),
      'Mood': Mood,
    };
  }
}
