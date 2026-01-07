import 'package:super_quest/domain/models/challenge.dart';
import 'package:super_quest/domain/models/challenge_outcome.dart';
import 'package:super_quest/domain/models/code_block.dart';

class ChallengeService {
  ChallengeOutcome? evaluate({
    required Challenge challenge,
    required List<CodeBlock> userBlocks,
    required int hintsUsed,
  }) {
    final userOrder = userBlocks.map((b) => b.id).toList();

    if (!_matchesSolution(userOrder, challenge.expectedBlockOrder)) {
      return null;
    }

    final stars = _starsFromHints(hintsUsed);
    final xp = _xpFromStars(stars);

    return ChallengeOutcome(
      challengeId: challenge.id,
      stars: stars,
      xpGained: xp,
      hintsUsed: hintsUsed,
    );
  }

  bool _matchesSolution(List<String> user, List<String> solution) {
    if (user.length != solution.length) return false;
    for (int i = 0; i < solution.length; i++) {
      if (user[i] != solution[i]) return false;
    }
    return true;
  }

  int _starsFromHints(int hintsUsed) {
    if (hintsUsed == 0) return 3;
    if (hintsUsed == 1) return 2;
    return 1;
  }

  int _xpFromStars(int stars) {
    switch (stars) {
      case 3: return 50;
      case 2: return 35;
      default: return 20;
    }
  }
}
