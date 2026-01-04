import 'package:super_quest/domain/models/player_stats.dart';

class Player {
  final String id;
  int level;
  int xp;
  PlayerStats stats;

  Player({
    required this.id,
    this.level = 1,
    this.xp = 0,
    required this.stats,
  });
}
