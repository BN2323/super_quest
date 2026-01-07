import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_quest/domain/models/code_block.dart';
import 'package:super_quest/domain/models/room.dart';
import 'package:super_quest/presentation/controllers/game_controller.dart';
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
  final Room room;

  const ChallengeScreen({super.key, required this.room});

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  final List<CodeBlock> _solution = [];
  String? _feedback;
  int _hintIndex = 0;
  String? _hintText;


  @override
  Widget build(BuildContext context) {
    final controller = context.watch<GameController>();
    final challenge = widget.room.currentChallenge;

    final expectedLength = challenge.expectedBlockOrder.length;
    final isComplete = _solution.length == expectedLength;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        )
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

              BlockToolbox(
                blocks: challenge.availableBlocks,
              ),

              const Spacer(),

              ActionBar(
                isComplete: isComplete,
                hasBlocks: _solution.isNotEmpty,
                onReset: _resetSolution,
                onSubmit: () => _submit(controller),
                onHint: () => _useHint(controller),
                canUseHint: controller.canUseHint,
              ),

            ],
          ),
        ),
      ),
    );
  }

  void _removeBlock(CodeBlock block) {
    setState(() {
      _solution.remove(block);
      _feedback = null;
    });
  }

  void _useHint(GameController controller) {
    if (!controller.canUseHint) {
      setState(() {
        _hintText = 'No hints left';
      });
      return;
    }

    final expected = widget.room.currentChallenge.expectedBlockOrder;
    final placed = _solution.length;

    if (placed >= expected.length) return;

    controller.useHint();

    setState(() {
      _hintText = 'Next block should be: ${expected[placed]}';
    });
  }



  void _resetSolution() {
    setState(() {
      _solution.clear();
      _feedback = null;
    });
  }

  void _submit(GameController controller) {
    final room = controller.currentRoom;

    final outcome = controller.submitSolution(
      userBlocks: _solution,
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
        isRoomComplete: room.isCompleted,
        onNext: () {
          Navigator.of(context).pop(); // close dialog

          if (room.isCompleted) {
            Navigator.of(context).pop(); // close ChallengeScreen

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => RoomCompleteScreen(room: room),
              ),
            );
          } else {
            // Stay on same ChallengeScreen → reset state
            setState(() {
              _solution.clear();
              _feedback = null;
              _hintText = null;
              _hintIndex = 0;
            });
            print('challenge: ${widget.room.currentChallengeIndex}');
          }
        },


        onReturn: () {
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
    );
  }

}
