import 'package:cloud_firestore/cloud_firestore.dart';

class UserChallengesModel {
  final String UserID;
  final List<String> ChallengeID;
  final List<bool> ChallengeStatus;
  DateTime Date;
  int NumCompletion;

  UserChallengesModel({
    required this.UserID,
    required this.ChallengeID,
    required this.ChallengeStatus,
    required this.Date,
    required this.NumCompletion,
  });

  // Map<String, dynamic> toJson() {
  //   return {
  //     'UserID': UserID,
  //     'ChallengeID': ChallengeID,
  //     'ChallengeStatus': ChallengeStatus,
  //     'Date': Date,
  //     'numCompletion': NumCompletion,
  //   };
  // }

  Map<String, dynamic> toMap() {
    return {
      'UserID': UserID,
      'ChallengeID': ChallengeID,
      'ChallengeStatus': ChallengeStatus,
      'Date': Date,
      'numCompletion': NumCompletion,
    };
  }

  factory UserChallengesModel.fromMap(Map<String, dynamic> data, String UserID) {
    return UserChallengesModel(
      UserID: UserID,
      ChallengeID: List<String>.from(data['ChallengeID']),
      ChallengeStatus: List<bool>.from(data['ChallengeStatus']),
      Date: (data['Date'] as Timestamp).toDate(),
      NumCompletion: data['NumCompletion'],
    );
  }

  // factory UserChallenge.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
  //   final data = snapshot.data()!;
  //   return UserChallenge(
  //     UserID: data['UserID'],
  //     ChallengeID: List<String>.from(data['ChallengeID']),
  //     ChallengeStatus: List<bool>.from(data['ChallengeStatus']),
  //     Date: data['Date'],
  //     NumCompletion: data['NumCompletion'],
  //   );
  // }
}