/*import 'package:flutter/material.dart';

import '../../../../shared/theme/app_colors.dart';

class AppDropdown extends StatelessWidget {
  final String selectedClass;
  final List<String> classes;
  final ValueChanged<String> onChanged;

  const AppDropdown({
    super.key,
    required this.selectedClass,
    required this.classes,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (classes.isEmpty) {
      return const SizedBox();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Select Class",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(
          width: 120,
          child: DropdownButtonFormField<String>(
            value: selectedClass.isEmpty
                ? classes.first
                : selectedClass,
            items: classes
                .map(
                  (className) => DropdownMenuItem(
                value: className,
                child: Text(className),
              ),
            )
                .toList(),
            onChanged: (value) {
              if (value != null) onChanged(value);
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),

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
          ),
        ),
      ],
    );
  }
}*/
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AppDropdown extends StatelessWidget {
  final String selectedClass;
  final List<String> classes;
  final ValueChanged<String> onChanged;
  final String? errorText;

  const AppDropdown({
    super.key,
    required this.selectedClass,
    required this.classes,
    required this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    if (classes.isEmpty) return const SizedBox();

    final hasError = errorText != null;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        SizedBox(
          width: 114,
          height: 50,
          child: DropdownButtonFormField<String>(
            value: selectedClass.isEmpty ? classes.first : selectedClass,
            items: classes
                .map(
                  (className) => DropdownMenuItem(
                value: className,
                child: Text(className),
              ),
            )
                .toList(),
            onChanged: (value) {
              if (value != null) onChanged(value);
            },
            decoration: InputDecoration(
              errorText: errorText,
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface,

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: hasError
                      ? Colors.red
                      : AppColors.strokeColor,
                ),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: hasError
                      ? Colors.red
                      : AppColors.strokeColor,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}