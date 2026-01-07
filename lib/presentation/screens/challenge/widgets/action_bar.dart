import 'package:flutter/material.dart';
import 'package:super_quest/presentation/widgets/buttons/primary_action_button.dart';

class ActionBar extends StatelessWidget {
  final bool isComplete;
  final bool hasBlocks;
  final VoidCallback onReset;
  final VoidCallback onSubmit;
  final VoidCallback onHint;
  final bool canUseHint;


  const ActionBar({
    super.key,
    required this.isComplete,
    required this.hasBlocks,
    required this.onReset,
    required this.onSubmit, required this.onHint, required this.canUseHint,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PrimaryActionButton(
            label: 'Hint',
            onPressed: canUseHint ? onHint : null, 
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: PrimaryActionButton(
            label: 'Reset',
            onPressed: onReset 
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: PrimaryActionButton(
            label: 'SUBMIT',
            onPressed: onSubmit 
          ),
        ),
      ],
    );
  }
}
