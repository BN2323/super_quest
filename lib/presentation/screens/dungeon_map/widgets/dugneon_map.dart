import 'package:flutter/material.dart';
import 'package:super_quest/presentation/controllers/game_controller.dart';
import 'package:super_quest/presentation/screens/dungeon_map/widgets/room_card.dart';
import 'package:super_quest/presentation/theme/app_spacing.dart';

class DungeonMap extends StatelessWidget {
  final GameController controller;

  const DungeonMap({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
      child: Column(
        children: controller.dungeon.rooms.map((room) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
            child: RoomNode(
              room: room,
              isCurrent: room == controller.currentRoom,
              onTap: () {
                controller.selectRoom(room);
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
