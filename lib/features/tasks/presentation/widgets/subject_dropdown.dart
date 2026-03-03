/*import 'package:flutter/material.dart';
import '../../../../shared/theme/app_colors.dart';

class SubjectDropdown extends StatelessWidget {
  final String? selectedSubject;
  final List<String> subjects;
  final ValueChanged<String> onChanged;

  const SubjectDropdown({
    super.key,
    required this.selectedSubject,
    required this.subjects,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (subjects.isEmpty) {
      return const SizedBox();
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;

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
        labelText: "Subject",

        // لون كلمة Subject
        labelStyle: TextStyle(
          color: isDark ? Colors.white : Colors.black,
        ),

        filled: true,
        fillColor: theme.cardColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.strokeColor,
            width: 1.2,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.strokeColor,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
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
        labelText: "Subject",
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
}