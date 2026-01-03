import 'package:super_quest/domain/models/room.dart';

class Dungeon {
  final String id;
  final String name;
  final String theme; // e.g. "Logic Basics"

  final List<Room> rooms;

  Dungeon({
    required this.id,
    required this.name,
    required this.theme,
    required this.rooms,
  });
}
