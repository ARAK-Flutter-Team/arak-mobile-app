import 'package:flutter/material.dart';
import '../../../../shared/theme/app_colors.dart';

class EvaluationFilters extends StatefulWidget {
  final Function(int classId, int subjectId, String type) onApply;

  const EvaluationFilters({super.key, required this.onApply});

  @override
  State<EvaluationFilters> createState() => _EvaluationFiltersState();
}

class _EvaluationFiltersState extends State<EvaluationFilters> {
  int? classId;
  int? subjectId;
  String? type;

  final types = ["Month1", "Month2", "Final"];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Column(
        children: [
          /// Row 1
          Row(
            children: [
              Expanded(
                child: _buildDropdown<int>(
                  context,
                  hint: "Class",
                  value: classId,
                  items: const [
                    DropdownMenuItem(value: 1, child: Text("Class 1")),
                    DropdownMenuItem(value: 2, child: Text("Class 2")),
                  ],
                  onChanged: (val) => setState(() => classId = val),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildDropdown<int>(
                  context,
                  hint: "Subject",
                  value: subjectId,
                  items: const [
                    DropdownMenuItem(value: 1, child: Text("Math")),
                    DropdownMenuItem(value: 2, child: Text("Science")),
                  ],
                  onChanged: (val) => setState(() => subjectId = val),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// Row 2
          Row(
            children: [
              Expanded(
                child: _buildDropdown<String>(
                  context,
                  hint: "Assessment",
                  value: type,
                  items: types
                      .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ))
                      .toList(),
                  onChanged: (val) => setState(() => type = val),
                ),
              ),

              const SizedBox(width: 10),

              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: _canSubmit()
                      ? () {
                    widget.onApply(
                      classId!,
                      subjectId!,
                      type!,
                    );
                  }
                      : null,
                  child: const Text("Load"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  InputDecoration _decoration(BuildContext context, String hint) {
    final borderColor = AppColors.strokeColor;

    return InputDecoration(
      hintText: hint,

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: borderColor.withOpacity(0.5)),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: borderColor, width: 1.5),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.red),
      ),

      contentPadding:
      const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    );
  }

  Widget _buildDropdown<T>(
      BuildContext context, {
        required String hint,
        required T? value,
        required List<DropdownMenuItem<T>> items,
        required Function(T?) onChanged,
      }) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: onChanged,
      decoration: _decoration(context, hint),
      icon: const Icon(Icons.keyboard_arrow_down_rounded),
      borderRadius: BorderRadius.circular(12),
    );
  }

  bool _canSubmit() {
    return classId != null && subjectId != null && type != null;
  }
}