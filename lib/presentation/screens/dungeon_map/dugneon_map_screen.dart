import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_quest/presentation/screens/dungeon_map/widgets/dugneon_map_view.dart';

import '../../controllers/game_controller.dart';
import 'widgets/progress_header.dart';

class DungeonMapScreen extends StatelessWidget {
  const DungeonMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<GameController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(controller.dungeon.name),
        actions: const [
          Icon(Icons.settings),
        ],
      ),
      body: Column(
        children: [
          ProgressHeader(controller: controller),
          Expanded(
            child: DungeonMapView(dungeon: controller.dungeon),
          ),
        ],
      ),
    );
  }
}
