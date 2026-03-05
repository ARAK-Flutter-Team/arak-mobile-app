import 'package:flutter/material.dart';

class AttendancePercentageHeader extends StatelessWidget {
  final double percentage;

  const AttendancePercentageHeader({
    super.key,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.only(left: 8, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Text(
            "Overall Attendance",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurface
            ),
          ),
          Text(
            "${percentage.toStringAsFixed(0)}%",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),


        ],
      ),
    );
  }
}