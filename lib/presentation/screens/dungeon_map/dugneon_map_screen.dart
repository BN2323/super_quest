import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_quest/presentation/controllers/game_controller.dart';
import 'package:super_quest/presentation/screens/dungeon_map/dugneon_map_view.dart';

class DugneonMapScreen extends StatelessWidget {
  const DugneonMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<GameController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(controller.dungeon.name),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'reset') {
                controller.resetDungeon();
              }
            },
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: 'reset',
                child: Text('Restart Dungeon'),  
              )
            ],
          )
        ],
      ),

      body: DungeonMapView(dungeon: controller.dungeon),
    );
  }
}