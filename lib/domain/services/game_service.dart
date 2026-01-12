import 'package:super_quest/domain/models/game_world.dart';
import '../models/challenge_outcome.dart';
import '../models/dungeon.dart';
import '../models/player.dart';
import '../models/room.dart';

import '../models/submit_result.dart';

class GameService {
  SubmitResult submitChallenge({
    required Dungeon dungeon,
    required Room room,
    required ChallengeOutcome outcome,
    required Player player,
  }) {
    player.addXp(outcome.xpGained);

    bool challengeAdvanced = false;
    bool roomCompleted = false;
    bool dungeonCompleted = false;

    if (!room.isLastChallenge) {
      room.advanceChallenge();
      challengeAdvanced = true;
    } else {
      room.complete();
      roomCompleted = true;

      _unlockNextRoom(dungeon, room);

      if (dungeon.rooms.every((r) => r.isCompleted)) {
        dungeon.complete();
        dungeonCompleted = true;
      }
    }

    return SubmitResult(
      outcome: outcome,
      challengeAdvanced: challengeAdvanced,
      roomCompleted: roomCompleted,
      dungeonCompleted: dungeonCompleted,
    );
  }

  void unlockNextDungeon(GameWorld world, Dungeon dungeon) {
    final index = world.dungeons.indexOf(dungeon);
    if (index == -1 || index + 1 >= world.dungeons.length) return;

    final nextDungeon = world.dungeons[index + 1];
    if (nextDungeon.isLocked) {
      nextDungeon.unlock();
      if (nextDungeon.rooms.isNotEmpty) {
        nextDungeon.rooms.first.unlock();
      }
    }
  }

  void _unlockNextRoom(Dungeon dungeon, Room currentRoom) {
    final rooms = [...dungeon.rooms]..sort((a, b) => a.order.compareTo(b.order));
    final index = rooms.indexWhere((r) => r.id == currentRoom.id);
    if (index == -1 || index + 1 >= rooms.length) return;

    final nextRoom = rooms[index + 1];
    if (nextRoom.isLocked) nextRoom.unlock();
  }
}

