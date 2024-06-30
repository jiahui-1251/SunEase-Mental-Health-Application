import 'package:cloud_firestore/cloud_firestore.dart';

class DailyChallenge {
  final String ChallengeID;
  final String ChallengeTitle;
  final String ChallengeDescription;
  final String ChallengeBenefit;

  DailyChallenge({
    required this.ChallengeID,
    required this.ChallengeTitle,
    required this.ChallengeDescription,
    required this.ChallengeBenefit,
  });

  factory DailyChallenge.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return DailyChallenge(
      ChallengeID: snapshot.id,
      ChallengeTitle: data['ChallengeTitle'],
      ChallengeDescription: data['ChallengeDescription'],
      ChallengeBenefit: data['ChallengeBenefit'],
    );
  }
}