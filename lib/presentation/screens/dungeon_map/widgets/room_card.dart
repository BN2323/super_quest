import 'package:flutter/material.dart';
import '../../../../domain/models/room.dart';
import '../../../theme/app_colors.dart';

class RoomNode extends StatefulWidget {
  final Room room;
  final bool isCurrent;
  final VoidCallback? onTap;

  const RoomNode({
    super.key,
    required this.room,
    required this.isCurrent,
    this.onTap,
  });

  @override
  State<RoomNode> createState() => _RoomNodeState();
}

class _RoomNodeState extends State<RoomNode>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _scale;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _scale = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );

    if (widget.isCurrent) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(RoomNode oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isCurrent && !_pulseController.isAnimating) {
      _pulseController.repeat(reverse: true);
    } else if (!widget.isCurrent && _pulseController.isAnimating) {
      _pulseController.stop();
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fillColor = _fillColor();
    final borderColor = _borderColor();
    final icon = _iconForState();

    return GestureDetector(
      onTapDown: (_) {
        if (widget.room.isUnlocked) {
          setState(() => _pressed = true);
        }
      },
      onTapUp: (_) {
        if (widget.room.isUnlocked || widget.room.isCompleted) {
          setState(() => _pressed = false);
          widget.onTap?.call();
        }
      },
      onTapCancel: () {
        if (_pressed) {
          setState(() => _pressed = false);
        }
      },
      child: AnimatedBuilder(
        animation: _pulseController,
        builder: (context, child) {
          double scale = 1.0;

          if (widget.isCurrent) {
            scale = _scale.value;
          }

          if (_pressed) {
            scale *= 0.92;
          }

          return Transform.scale(
            scale: scale,
            child: child,
          );
        },
        child: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: fillColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: borderColor,
              width: 3,
            ),
            boxShadow: widget.isCurrent
                ? [
                    BoxShadow(
                      color: fillColor.withValues(alpha: 0.5),
                      blurRadius: 18,
                      spreadRadius: 2,
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Icon(
              icon,
              color: Colors.white,
              size: 26,
            ),
          ),
        ),
      ),
    );
  }

  // ===== VISUAL LOGIC =====

  Color _fillColor() {
    switch (widget.room.status) {
      case RoomStatus.completed:
        return AppColors.success;
      case RoomStatus.unlocked:
        return AppColors.primary;
      case RoomStatus.locked:
        return AppColors.roomLocked;
    }
  }

  Color _borderColor() {
    switch (widget.room.status) {
      case RoomStatus.completed:
        return AppColors.successDark;
      case RoomStatus.unlocked:
        return AppColors.primaryDark;
      case RoomStatus.locked:
        return AppColors.roomLockedDark;
    }
  }

  IconData _iconForState() {
    switch (widget.room.status) {
      case RoomStatus.completed:
        return Icons.check;
      case RoomStatus.unlocked:
        return Icons.play_arrow;
      case RoomStatus.locked:
        return Icons.lock;
    }
  }
}
