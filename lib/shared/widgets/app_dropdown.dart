/*import 'package:flutter/material.dart';
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
          width: 120,
          height: 50,
          child: DropdownButtonFormField<String>(
            isExpanded: true,
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
                borderRadius: BorderRadius.circular(5),
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

    return SizedBox(
      width: 120,
      height: 50,
      child: DropdownButtonFormField<String>(
        isExpanded: true,
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
              color: hasError ? Colors.red : AppColors.strokeColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: hasError ? Colors.red : AppColors.strokeColor,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}