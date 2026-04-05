/*import 'package:flutter/material.dart';
import '../../features/attendance/domain/entities/attendance_record.dart';
import '../theme/app_colors.dart';

class AppDropdownSession extends StatelessWidget {
  final AttendanceSession selectedSession;
  final ValueChanged<AttendanceSession> onChanged;

  const AppDropdownSession({
    super.key,
    required this.selectedSession,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 50,
      child: DropdownButtonFormField<AttendanceSession>(
        isExpanded: true,
        value: selectedSession,
        items: AttendanceSession.values.map((session) {
          return DropdownMenuItem(
            value: session,
            child: Text(
              session == AttendanceSession.morning
                  ? "Morning"
                  : "Afternoon",
            ),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            onChanged(value);
          }
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: AppColors.strokeColor,
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: AppColors.strokeColor,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import '../../features/attendance/domain/entities/attendance_record.dart';
import '../theme/app_colors.dart';
import '../../l10n/app_localizations.dart';

class AppDropdownSession extends StatelessWidget {
  final AttendanceSession selectedSession;
  final ValueChanged<AttendanceSession> onChanged;

  const AppDropdownSession({
    super.key,
    required this.selectedSession,
    required this.onChanged,
  });

  /// ✅ ترجمة السيشن
  String getSessionName(BuildContext context, AttendanceSession session) {
    final loc = AppLocalizations.of(context)!;

    switch (session) {
      case AttendanceSession.morning:
        return loc.morning;

    /// لو عندك evening
      case AttendanceSession.afternoon:
        return loc.evening;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 50,
      child: DropdownButtonFormField<AttendanceSession>(
        isExpanded: true,
        value: selectedSession,
        items: AttendanceSession.values.map((session) {
          return DropdownMenuItem(
            value: session,
            child: Text(
              getSessionName(context, session), // ✅ مترجم
            ),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            onChanged(value);
          }
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: AppColors.strokeColor,
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: AppColors.strokeColor,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}