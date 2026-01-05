import 'package:super_quest/domain/models/player_stats.dart';

class Player {
  int level;
  int xp;

  Player({
    required this.level,
    required this.xp,
  });

  factory Player.initial() {
    return Player(level: 1, xp: 0);
  }

  void addXp(int amount) {
    xp += amount;

    if (xp >= level * 100) {
      xp = 0;
      level++;
    }
  }
}
