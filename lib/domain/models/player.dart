class Player {
  int level;
  int xp;

  Player({
    required this.level,
    required this.xp,
  });

  int get xpToNextLevel => _xpToNextLevel();

  double get levelProgress => xp / xpToNextLevel;

  factory Player.initial() {
    return Player(
      level: 1,
      xp: 0,
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
