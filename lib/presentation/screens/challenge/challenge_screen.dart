import 'package:flutter/material.dart';
import 'package:super_quest/domain/models/challenge_outcome.dart';
import 'package:super_quest/domain/models/code_block.dart';
import 'package:super_quest/domain/models/dungeon.dart';
import 'package:super_quest/domain/models/room.dart';
import 'package:super_quest/domain/models/submit_result.dart';
import 'package:super_quest/presentation/screens/challenge/widgets/action_bar.dart';
import 'package:super_quest/presentation/screens/challenge/widgets/block_toolbox.dart';
import 'package:super_quest/presentation/screens/challenge/widgets/challenge_header.dart';
import 'package:super_quest/presentation/screens/challenge/widgets/feedback_text.dart';
import 'package:super_quest/presentation/screens/challenge/widgets/instruction_card.dart';
import 'package:super_quest/presentation/screens/challenge/widgets/solution_arena.dart';
import 'package:super_quest/presentation/screens/result/challenge_result_dialog.dart';
import 'package:super_quest/presentation/screens/room_completed/room_completed.dart';
import 'package:super_quest/presentation/theme/app_colors.dart';
import 'package:super_quest/presentation/theme/app_spacing.dart';

class ChallengeScreen extends StatefulWidget {
  final Dungeon dungeon;
  final Room room;

  final SubmitResult? Function({
    required Room room,
    required Dungeon dungeon,
    required List<CodeBlock> userBlocks,
    required int hintsUsed,
  }) onSubmit;


  const ChallengeScreen({
    super.key,
    required this.dungeon,
    required this.room,
    required this.onSubmit,
  });

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  final List<CodeBlock> _solution = [];
  String? _feedback;
  String? _hintText;
  int _hintsUsed = 0;

  @override
  Widget build(BuildContext context) {
    final challenge = widget.room.currentChallenge;
    final expectedLength = challenge.expectedBlockOrder.length;
    final isComplete = _solution.length == expectedLength;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChallengeHeader(room: widget.room),

              const SizedBox(height: AppSpacing.md),
              InstructionCard(text: challenge.description),
              const SizedBox(height: AppSpacing.lg),

              SolutionArena(
                blocks: _solution,
                onRemove: _removeBlock,
              ),

              if (_hintText != null)
                Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.sm),
                  child: Text(
                    _hintText!,
                    style: const TextStyle(color: Colors.amber),
                  ),
                ),

              if (_feedback != null) FeedbackText(_feedback!),

              const SizedBox(height: AppSpacing.md),

              BlockToolbox(blocks: challenge.availableBlocks),

              const Spacer(),

              ActionBar(
                isComplete: isComplete,
                hasBlocks: _solution.isNotEmpty,
                onReset: _resetSolution,
                onSubmit: _submit,
                onHint: _useHint,
                canUseHint: _hintsUsed < challenge.maxHints,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===== LOGIC =====

  void _removeBlock(CodeBlock block) {
    setState(() {
      _solution.remove(block);
      _feedback = null;
    });
  }

  void _useHint() {
    final expected = widget.room.currentChallenge.expectedBlockOrder;
    final placed = _solution.length;

    if (_hintsUsed >= widget.room.currentChallenge.maxHints) {
      setState(() => _hintText = 'No hints left');
      return;
    }

    if (placed < expected.length) {
      setState(() {
        _hintsUsed++;
        _hintText = 'Next block should be: ${expected[placed]}';
      });
    }
  }

  void _resetSolution() {
    setState(() {
      _solution.clear();
      _feedback = null;
      _hintText = null;
    });
  }

  void _submit() {
    final outcome = widget.onSubmit(
      dungeon: widget.dungeon,
      room: widget.room,
      userBlocks: _solution,
      hintsUsed: _hintsUsed,
    );

    if (outcome == null) {
      setState(() {
        _feedback = 'Not quite right — try rearranging';
      });
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => ChallengeResultDialog(
        outcome: outcome,
        isRoomComplete: outcome.roomCompleted,
        onNext: () {
          Navigator.pop(context); // close dialog

          print('room is completed: ${outcome.roomCompleted}');
          if (outcome.roomCompleted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => RoomCompleteScreen(currentDungeon: widget.dungeon, room: widget.room, isDungeonCompleted: outcome.dungeonCompleted,),
              ),
            );
          } else {
            setState(() {
              _solution.clear();
              _feedback = null;
              _hintText = null;
              _hintsUsed = 0;
            });
          }
        },
        onReturn: () {
          Navigator.of(context).popUntil((r) => r.isFirst);
        },
      ),
    );
  }
}
