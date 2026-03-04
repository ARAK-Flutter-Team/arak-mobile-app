import 'package:flutter/material.dart';
import '../../../../../shared/theme/app_colors.dart';
import '../../../domain/entities/attendance_record.dart';

class AttendanceStatusBadge extends StatelessWidget {
  final AttendanceStatus status;

  const AttendanceStatusBadge({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    late Color color;

    switch (status) {
      case AttendanceStatus.present:
        color = AppColors.green;
        break;

      case AttendanceStatus.late:
        color = AppColors.orange;
        break;

      case AttendanceStatus.absent:
        color = AppColors.red;
        break;
    }

    return Container(
      width: 91,
      height: 38,
      padding: const EdgeInsets.symmetric(
        vertical: 6,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status.name, // Present / Late / Absent
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}