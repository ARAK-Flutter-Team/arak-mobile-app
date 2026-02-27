import 'package:flutter/material.dart';
import 'app_input_decoration.dart';

class AuthTextField extends StatelessWidget {
  final String label;
  final String? errorText;
  final bool obscureText;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final Widget? suffixIcon;

  const AuthTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.onChanged,
    this.errorText,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      obscuringCharacter: '*',
      decoration: AppInputDecoration.build(
        label: label,
        errorText: errorText,
        suffixIcon: suffixIcon,
      ),
      onChanged: onChanged, // هذا يبقى نفسو
    );
  }
}