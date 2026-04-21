import 'package:flutter/material.dart';
import '../../../../../shared/theme/app_colors.dart';
import '../../../domain/entities/attendance_record.dart';
import '../../../../../l10n/app_localizations.dart';

class AttendanceStatusBadge extends StatelessWidget {
  final AttendanceStatus status;

  const AttendanceStatusBadge({
    super.key,
    required this.status,
  });

  ///  تحديد اللون
  Color getStatusColor() {
    switch (status) {
      case AttendanceStatus.present:
        return AppColors.green;
      case AttendanceStatus.late:
        return AppColors.orange;
      case AttendanceStatus.absent:
        return AppColors.red;
    }
  }

  ///  ترجمة الحالة
  String getStatusText(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    switch (status) {
      case AttendanceStatus.present:
        return loc.present;
      case AttendanceStatus.late:
        return loc.late;
      case AttendanceStatus.absent:
        return loc.absent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 91,
      height: 38,
      padding: const EdgeInsets.symmetric(
        vertical: 6,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: getStatusColor(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        getStatusText(context), //  بدل status.name
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}