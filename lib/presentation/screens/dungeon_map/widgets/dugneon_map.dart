import 'package:flutter/material.dart';
import 'package:super_quest/domain/models/dungeon.dart';
import 'package:super_quest/domain/models/room.dart';
import 'package:super_quest/presentation/screens/dungeon_map/widgets/map_layout.dart';
import 'package:super_quest/presentation/screens/dungeon_map/widgets/room_card.dart';

class DungeonMap extends StatelessWidget {
  final Dungeon currentDungeon;
  final Room currentRoom;
  final Function selectRoom;

  const DungeonMap({super.key, required this.currentDungeon, required this.currentRoom, required this.selectRoom});

  @override
  Widget build(BuildContext context) {
    final rooms = currentDungeon.rooms;

    return SingleChildScrollView(
      child: SizedBox(
        height: MapLayout.mapHeight(rooms.length),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: rooms.asMap().entries.map((entry) {
                final index = entry.key;
                final room = entry.value;

                final position = MapLayout.roomPosition(
                  index: index,
                  mapWidth: constraints.maxWidth,
                );

                return Positioned(
                  left: position.dx,
                  top: position.dy,
                  child: RoomNode(
                    room: room,
                    isCurrent: room == currentRoom,
                    onTap: () {
                      selectRoom(room);
                    },
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
