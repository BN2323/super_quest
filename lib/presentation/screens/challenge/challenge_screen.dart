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

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<GameController>();
    final challenge = widget.room.challenge;

    final expectedLength = challenge.expectedBlockOrder.length;
    final isComplete = _solution.length == expectedLength;

    return Scaffold(
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

  void _resetSolution() {
    setState(() {
      _solution.clear();
      _feedback = null;
    });
  }

  void _submit(GameController controller) {
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
        onNext: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
        onReturn: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
      ),
    );
  }
}
