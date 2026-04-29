import 'package:flutter/material.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';

class TaskStatusBadge extends StatelessWidget {
  final bool isDone;

  const TaskStatusBadge({
    super.key,
    required this.isDone,
  });

  Color getColor() {
    return isDone ? AppColors.green : AppColors.orange;
  }

  String getText(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return isDone ? loc.done : loc.pending;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 38,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: getColor(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        getText(context),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}