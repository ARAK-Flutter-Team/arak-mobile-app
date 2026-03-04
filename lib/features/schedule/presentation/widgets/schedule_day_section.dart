import 'package:flutter/material.dart';
import '../../../../shared/theme/app_colors.dart';
import 'schedule_item_row.dart';

class ScheduleDaySection extends StatelessWidget {
  final String day;
  final List<dynamic> items;

  const ScheduleDaySection({
    super.key,
    required this.day,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final textColor =
        Theme.of(context).textTheme.bodyMedium?.color;

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.strokeColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            day,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 12),

          ...items.map(
                (item) => ScheduleItemRow(item: item),
          ),
        ],
      ),
    );
  }
}