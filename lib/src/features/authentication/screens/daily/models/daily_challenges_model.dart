class DailyChallengeModel{
  final String ChallengeID;
  final String ChallengeTitle;
  final String ChallengeDescription;
  final String ChallengeBenefit;

  DailyChallengeModel({
    required this.ChallengeID,
    required this.ChallengeTitle,
    required this.ChallengeDescription,
    required this.ChallengeBenefit,
  });

  factory DailyChallengeModel.fromMap(Map<String, dynamic> data, String id) {
    return DailyChallengeModel(
      ChallengeID: id,
      ChallengeTitle: data['ChallengeTitle'],
      ChallengeDescription: data['ChallengeDescription'],
      ChallengeBenefit: data['ChallengeBenefit'],
    );
  }

}