import 'package:cloud_firestore/cloud_firestore.dart';

class UserChallenge {
  final String UserID;
  final List<String> ChallengeID;
  final List<bool> ChallengeStatus;
  final Timestamp Date;
  final int NumCompletion;

  UserChallenge({
    required this.UserID,
    required this.ChallengeID,
    required this.ChallengeStatus,
    required this.Date,
    required this.NumCompletion,
  });

  Map<String, dynamic> toJson() {
    return {
      'UserID': UserID,
      'ChallengeID': ChallengeID,
      'ChallengeStatus': ChallengeStatus,
      'Date': Date,
      'numCompletion': NumCompletion,
    };
  }

  factory UserChallenge.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return UserChallenge(
      UserID: data['UserID'],
      ChallengeID: List<String>.from(data['ChallengeID']),
      ChallengeStatus: List<bool>.from(data['ChallengeStatus']),
      Date: data['Date'],
      NumCompletion: data['NumCompletion'],
    );
  }
}