import 'player_stats.dart';

class Player {
  int level;
  int xp;
  final PlayerStats stats;

  Player({
    required this.level,
    required this.xp,
    required this.stats,
  });

  factory Player.initial() {
    return Player(
      level: 1,
      xp: 0,
      stats: PlayerStats(),
    );
  }

  // ===== PROGRESSION =====
  void addXp(int amount) {
    xp += amount;

    while (xp >= _xpToNextLevel()) {
      xp -= _xpToNextLevel();
      level++;
    }
  }

  int _xpToNextLevel() {
    return level * 100;
  }
}
