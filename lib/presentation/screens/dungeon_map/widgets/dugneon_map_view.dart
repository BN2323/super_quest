import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_quest/presentation/controllers/game_controller.dart';
import 'package:super_quest/presentation/screens/dungeon_map/widgets/room_card.dart';
import '../../../../domain/models/dungeon.dart';
import 'map_layout.dart';

class DungeonMapView extends StatelessWidget {
  final Dungeon dungeon;

  const DungeonMapView({super.key, required this.dungeon});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final mapHeight = MapLayout.mapHeight(dungeon.rooms.length);

    return SingleChildScrollView(
      child: SizedBox(
        height: mapHeight,
        child: Stack(
          children: [
            for (int i = 0; i < dungeon.rooms.length; i++)
              _buildRoomNode(
                context,
                index: i,
                screenWidth: screenWidth,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoomNode(
    BuildContext context, {
    required int index,
    required double screenWidth,

  }) {
    final controller = context.watch<GameController>();
    final room = dungeon.rooms[index];
    final pos = MapLayout.roomPosition(
      index: index,
      mapWidth: screenWidth,
    );
    void testButton() {
      print("pressed");
    }
    return Positioned(
      left: pos.dx,
      top: pos.dy,
      child: RoomNode(
        room: room,
        isCurrent: room == controller.currentRoom,
        onTap: () {
          // navigation later
          testButton();
        },
      ),
    );
  }
}
