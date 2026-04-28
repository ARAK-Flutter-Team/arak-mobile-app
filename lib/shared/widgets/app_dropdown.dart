import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../../core/utils/logger_utils.dart';

class AppDropdown extends StatelessWidget {
  final String selectedClass;
  final List<String> classes;
  final ValueChanged<String> onChanged;
  final String? errorText;
  final double? width;
  final double? height;

  const AppDropdown({
    super.key,
    required this.selectedClass,
    required this.classes,
    required this.onChanged,
    this.errorText,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    AppLogger.logInfo(' AppDropdown BUILD START ');
    AppLogger.logInfo('AppDropdown - selectedClass: "$selectedClass"');
    AppLogger.logInfo('AppDropdown - selectedClass type: ${selectedClass.runtimeType}');
    AppLogger.logInfo('AppDropdown - classes: $classes');
    AppLogger.logInfo('AppDropdown - classes length: ${classes.length}');

    if (classes.isEmpty) {
      AppLogger.logWarning('AppDropdown - classes is EMPTY, returning SizedBox');
      return const SizedBox();
    }

    // التحقق من null
    if (selectedClass == null) {
      AppLogger.logError('selectedClass is NULL!');
      final safeValue = classes.first;
      AppLogger.logInfo('Using first class as fallback: "$safeValue"');

      return _buildDropdown(safeValue, context);
    }

    // حساب القيمة الصالحة
    String validValue = selectedClass;
    AppLogger.logInfo('Initial validValue: "$validValue"');

    if (validValue.isEmpty || validValue == 'null' || !classes.contains(validValue)) {
      validValue = classes.first;
      AppLogger.logWarning('validValue changed to first class: "$validValue"');
    } else {
      AppLogger.logSuccess('validValue is valid: "$validValue"');
    }

    return _buildDropdown(validValue, context);
  }

  Widget _buildDropdown(String value, BuildContext context) {
    final hasError = errorText != null;
    AppLogger.logInfo('Building Dropdown with value: "$value"');

    return SizedBox(
      width: width ?? 120,
      height: height ?? 50,
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        value: value,
        items: classes.map((className) {
          return DropdownMenuItem<String>(
            value: className,
            child: Text(className),
          );
        }).toList(),
        onChanged: (newValue) {
          AppLogger.logInfo('Dropdown onChanged: "$newValue"');
          if (newValue != null && newValue.isNotEmpty) {
            onChanged(newValue);
          }
        },
        decoration: InputDecoration(
          errorText: errorText,
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: hasError ? Colors.red : AppColors.strokeColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
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