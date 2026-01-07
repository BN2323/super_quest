import 'package:flutter/material.dart';
import 'package:super_quest/presentation/widgets/buttons/primary_action_button.dart';

class ActionBar extends StatelessWidget {
  final bool isComplete;
  final bool hasBlocks;
  final VoidCallback onReset;
  final VoidCallback onSubmit;

  const ActionBar({
    super.key,
    required this.isComplete,
    required this.hasBlocks,
    required this.onReset,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
