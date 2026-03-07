import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final ValueChanged<String>? onEdit; // اضيفي هنا

  const InfoTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon),
             SizedBox(width: 8.w),
            Text(label),
          ],
        ),
        Row(
          children: [
            Text(value),
            if (onEdit != null)
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () async {
                  final controller = TextEditingController(text: value);
                  final newValue = await showDialog<String>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Edit $label"),
                      content: TextField(
                        controller: controller,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(hintText: value),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, null),
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, controller.text),
                          child: const Text("Save"),
                        ),
                      ],
                    ),
                  );
                  if (newValue != null && newValue.isNotEmpty) {
                    onEdit!(newValue); // نحدث القيمة
                  }
                },
              ),
          ],
        ),
      ],
    );
  }
}