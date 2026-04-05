import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/theme/app_colors.dart';

class DeadlinePicker extends StatelessWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final String? errorText;

  const DeadlinePicker({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasError = errorText != null;

    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
        );

        if (picked != null) {
          onDateSelected(picked);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context)!.deadline,
          errorText: errorText,

          filled: true,
          fillColor: theme.cardColor,

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
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
        child: Text(
          selectedDate == null
              ? AppLocalizations.of(context)!.selectDate
              : DateFormat('yyyy-MM-dd').format(selectedDate!),
        ),
      ),
    );
  }
}