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
      /*leading: CircleAvatar(
        radius: 22,
        backgroundColor: Colors.grey.shade200,
        backgroundImage: record.studentImageUrl != null &&
            record.studentImageUrl!.isNotEmpty
            ? NetworkImage(record.studentImageUrl!)
            : null,
        child: (record.studentImageUrl == null ||
            record.studentImageUrl!.isEmpty)
            ? const Icon(Icons.person, color: Colors.grey)
            : null,
      ),*/
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: Colors.grey.shade200,
        backgroundImage: (record.studentImageUrl != null &&
            record.studentImageUrl!.isNotEmpty)
            ? NetworkImage(record.studentImageUrl!)
            : const AssetImage('assets/images/default_avatar.png') as ImageProvider,
        child: (record.studentImageUrl == null ||
            record.studentImageUrl!.isEmpty)
            ? const Icon(Icons.person, color: Colors.grey)
            : null,
      ),
      title: Text(record.studentName),
      trailing: AttendanceStatusBadge(
        status: record.status,
      ),
      onTap: onTap,
    );
  }
}