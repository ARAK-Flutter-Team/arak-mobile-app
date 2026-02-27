import 'package:flutter/material.dart';
import 'app_input_decoration.dart';

class AccountTypeDropdown extends StatelessWidget {
  final String? value;
  final List<String> items;
  final String? errorText;
  final ValueChanged<String?> onChanged;

  const AccountTypeDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: AppInputDecoration.build(
        label: "Account Type",
        errorText: errorText,
      ),
      items: items
          .map(
            (type) => DropdownMenuItem(
          value: type,
          child: Text(type),
        ),
      )
          .toList(),
      onChanged: onChanged,
    );
  }
}