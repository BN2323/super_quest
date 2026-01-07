import 'dungeon.dart';

class GameWorld {
  final List<Dungeon> dungeons;

  GameWorld({required this.dungeons});

  Dungeon get firstDungeon => dungeons.first;
}
