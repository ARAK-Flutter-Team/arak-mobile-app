import 'package:flutter/material.dart';
import '../../../domain/entities/attendance_record.dart';
import 'attendance_status_badge.dart';

class AttendanceListItem extends StatelessWidget {
  final AttendanceRecord record;
  final VoidCallback onTap;

  const AttendanceListItem({
    super.key,
    required this.record,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: Colors.grey.shade200,
        child: Text(
          record.studentName.isNotEmpty ? record.studentName[0] : '?',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      title: Text(record.studentName),
      trailing: AttendanceStatusBadge(status: record.status),
      onTap: onTap,
    );
  }
}