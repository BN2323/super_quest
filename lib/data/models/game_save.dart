import 'package:super_quest/data/models/dungeon_progress.dart';

class GameSave {
  final int level;
  final int xp;
  final List<DungeonProgress> dungeons;

  GameSave({
    required this.level,
    required this.xp,
    required this.dungeons,
  });

  Map<String, dynamic> toJson() => {
    'level': level,
    'xp': xp,
    'dungeons': dungeons.map((d) => d.toJson()).toList(),
  };

  factory GameSave.fromJson(Map<String, dynamic> json) {
    return GameSave(
      level: json['level'],
      xp: json['xp'],
      dungeons: (json['dungeons'] as List)
          .map((d) => DungeonProgress.fromJson(d))
          .toList(),
    );
  }
}
