import 'package:flutter/material.dart';

class ScheduleItemRow extends StatelessWidget {
  final dynamic item;

  const ScheduleItemRow({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final textColor =
        Theme.of(context).textTheme.bodyMedium?.color;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Text(
                item.title, // لو اسمها className غيريها هنا
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
          ),
          Text(
            "${item.startTime} - ${item.endTime}",
            style: TextStyle(
              fontSize: 14,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}