/*import 'package:flutter/material.dart';
import '../../../../shared/theme/app_colors.dart';

class TaskTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String hint;
  final int maxLines;

  const TaskTextField({
    super.key,
    required this.title,
    required this.controller,
    required this.hint,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: theme.cardColor,

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppColors.strokeColor,
                width: 1.2,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppColors.strokeColor,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}*/
import 'package:flutter/material.dart';
import '../../../../shared/theme/app_colors.dart';

class TaskTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String hint;
  final int maxLines;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  const TaskTextField({
    super.key,
    required this.title,
    required this.controller,
    required this.hint,
    this.maxLines = 1,
    this.errorText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasError = errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            errorText: errorText,
            filled: true,
            fillColor: theme.cardColor,

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: hasError
                    ? Colors.red
                    : AppColors.strokeColor,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: hasError
                    ? Colors.red
                    : AppColors.strokeColor,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}