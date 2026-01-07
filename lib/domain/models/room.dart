import 'challenge.dart';

enum RoomStatus {
  locked,
  unlocked,
  completed,
}

class Room {
  final String id;
  final String name;
  final int order;
  final bool isBossRoom;

  RoomStatus status;
  final List<Challenge> challenges;
  int currentChallengeIndex;

  Room({
    required this.id,
    required this.name,
    required this.order,
    required this.isBossRoom,
    required this.status,
    required this.challenges,
    this.currentChallengeIndex = 0,
  });

  // ===== STATE GETTERS =====

  bool get isLocked => status == RoomStatus.locked;
  bool get isUnlocked => status == RoomStatus.unlocked;
  bool get isCompleted => status == RoomStatus.completed;

  // ===== CHALLENGE PROGRESSION =====

  Challenge get currentChallenge =>
      challenges[currentChallengeIndex];

  bool get isLastChallenge =>
      currentChallengeIndex >= challenges.length - 1;

  void advanceChallenge() {
    if (!isLastChallenge) {
      currentChallengeIndex++;
    }
  }

  void resetProgress() {
    currentChallengeIndex = 0;
  }

  // ===== ROOM PROGRESSION =====

  void unlock() {
    if (status == RoomStatus.locked) {
      status = RoomStatus.unlocked;
    }
  }

  void complete() {
    status = RoomStatus.completed;
    currentChallengeIndex = 0;
  }

  void reset() {
    if (status == RoomStatus.completed) {
      status = RoomStatus.unlocked;
    }
    resetProgress();
  }
}
