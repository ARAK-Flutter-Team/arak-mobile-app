import 'package:flutter/material.dart';
import '../../../domain/entities/attendance_record.dart';
import 'attendance_list_item.dart';

class AttendanceList extends StatelessWidget {
  final List<AttendanceRecord> records;
  final Function(String studentId) onToggle;

  const AttendanceList({
    super.key,
    required this.records,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: records.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (_, index) {
        final record = records[index];

        return AttendanceListItem(
          record: record,
          onTap: () => onToggle(record.studentId),
        );
      },
    );
  }
}