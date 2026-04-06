/*import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/theme/app_colors.dart';

class SubjectDropdown extends StatelessWidget {
  final String? selectedSubject;
  final List<String> subjects;
  final ValueChanged<String> onChanged;
  final String? errorText;

  const SubjectDropdown({
    super.key,
    required this.selectedSubject,
    required this.subjects,
    required this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    if (subjects.isEmpty) return const SizedBox();

    final theme = Theme.of(context);
    final hasError = errorText != null;

    return DropdownButtonFormField<String>(
      value: selectedSubject,
      items: subjects
          .map(
            (subject) => DropdownMenuItem(
          value: subject,
          child: Text(subject),
        ),
      )
          .toList(),
      onChanged: (value) {
        if (value != null) onChanged(value);
      },
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.subject,
        errorText: errorText,

        filled: true,
        fillColor: theme.cardColor,

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.strokeColor,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.strokeColor,
            width: 1.5,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/theme/app_colors.dart';

class SubjectDropdown extends StatelessWidget {
  final String? selectedSubject;
  final List<String> subjects;
  final ValueChanged<String> onChanged;
  final String? errorText;

  const SubjectDropdown({
    super.key,
    required this.selectedSubject,
    required this.subjects,
    required this.onChanged,
    this.errorText,
  });

  /// 🔥 ترجمة اسم المادة
  String getSubjectLabel(BuildContext context, String subject) {
    switch (subject) {
      case "math":
        return AppLocalizations.of(context)!.math;
      case "science":
        return AppLocalizations.of(context)!.science;
      case "english":
        return AppLocalizations.of(context)!.english;
      default:
        return subject;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (subjects.isEmpty) return const SizedBox();

    final theme = Theme.of(context);

    return DropdownButtonFormField<String>(
      value: subjects.contains(selectedSubject) ? selectedSubject : null,
      items: subjects.map((subject) {
        return DropdownMenuItem(
          value: subject,
          child: Text(getSubjectLabel(context, subject)), // 🔥 هنا الترجمة
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) onChanged(value);
      },
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.subject,
        errorText: errorText,
        filled: true,
        fillColor: theme.cardColor,

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.strokeColor,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.strokeColor,
            width: 1.5,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
      ),
    );
  }
}