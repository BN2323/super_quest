import 'package:flutter/material.dart';
import 'package:super_quest/presentation/controllers/game_controller.dart';
import 'package:super_quest/presentation/screens/dungeon_map/widgets/map_layout.dart';
import 'package:super_quest/presentation/screens/dungeon_map/widgets/room_card.dart';
import 'package:super_quest/presentation/theme/app_spacing.dart';

class DungeonMap extends StatelessWidget {
  final GameController controller;

  const DungeonMap({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final rooms = controller.dungeon.rooms;

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
                    isCurrent: room == controller.currentRoom,
                    onTap: () {
                      controller.selectRoom(room);
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
