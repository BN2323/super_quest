import 'package:super_quest/domain/models/challenge_outcome.dart';

class SubmitResult {
  final ChallengeOutcome outcome;
  final bool challengeAdvanced;
  final bool roomCompleted;
  final bool dungeonCompleted;

  SubmitResult({
    required this.outcome,
    required this.challengeAdvanced,
    required this.roomCompleted,
    required this.dungeonCompleted,
  });
}
