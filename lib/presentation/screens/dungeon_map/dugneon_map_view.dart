import 'package:flutter/material.dart';
import 'package:super_quest/domain/models/dungeon.dart';
import 'package:super_quest/presentation/screens/dungeon_map/widgets/room_card.dart';
import 'package:super_quest/presentation/theme/app_spacing.dart';

class DungeonMapView extends StatelessWidget {
  final Dungeon dungeon;

  const DungeonMapView({
    super.key,
    required this.dungeon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: ListView.separated(
        itemCount: dungeon.rooms.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
        itemBuilder: (context, index) {
          final room = dungeon.rooms[index];
          return RoomCard(room: room);
        },
      ),
    );
  }
}