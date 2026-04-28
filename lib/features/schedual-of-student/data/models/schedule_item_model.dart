// lib/features/schedule/data/models/schedule_item_model.dart

import 'package:flutter/material.dart';
import '../../domain/entities/schedule_item.dart';

class ScheduleItemModel extends ScheduleItem {
  final String dayName; // ✅ للـ grouping في الـ repository

  ScheduleItemModel({
    required super.iconContent,
    required super.iconBackgroundColor,
    required super.time,
    required super.title,
    required this.dayName,
  });

  factory ScheduleItemModel.fromJson(Map<String, dynamic> json) {
    final subjectName = _getSubjectName(json);
    final startTime = _formatTime(json['startTime']);
    final endTime = _formatTime(json['endTime']);
    final dayName = _getDayName(json['dayOfWeek'] ?? 0);

    return ScheduleItemModel(
      title: subjectName,
      time: '$startTime - $endTime',
      dayName: dayName,
      iconBackgroundColor: _colorForSubject(subjectName),
      iconContent:
          Icon(_iconForSubject(subjectName), color: Colors.white, size: 22),
    );
  }

  static String _getDayName(int dayOfWeek) {
    const days = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ];
    return days[dayOfWeek % 7];
  }

  static String _getSubjectName(Map<String, dynamic> json) {
    if (json['subject'] != null && json['subject']['name'] != null) {
      return json['subject']['name'];
    }
    if (json['subjectName'] != null &&
        json['subjectName'].toString().isNotEmpty) {
      return json['subjectName'];
    }
    return 'Lesson';
  }

  static String _formatTime(dynamic time) {
    if (time == null) return '--:--';
    String t = time.toString();
    if (t.contains('.')) t = t.split('.').first;
    final parts = t.split(':');
    if (parts.length >= 2) {
      return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
    }
    return '--:--';
  }

  static IconData _iconForSubject(String name) {
    final l = name.toLowerCase();
    if (l.contains('math')) return Icons.calculate;
    if (l.contains('science') || l.contains('bio')) return Icons.science;
    if (l.contains('english')) return Icons.menu_book;
    if (l.contains('arabic')) return Icons.translate;
    if (l.contains('art') || l.contains('draw')) return Icons.brush;
    if (l.contains('sport') || l.contains('pe')) return Icons.sports;
    if (l.contains('history') || l.contains('geo')) return Icons.public;
    if (l.contains('lunch') || l.contains('break')) return Icons.lunch_dining;
    return Icons.school;
  }

  static Color _colorForSubject(String name) {
    final l = name.toLowerCase();
    if (l.contains('math')) return Colors.teal;
    if (l.contains('science') || l.contains('bio')) return Colors.green;
    if (l.contains('english')) return Colors.blue;
    if (l.contains('arabic')) return Colors.purple;
    if (l.contains('art') || l.contains('draw')) return Colors.deepPurple;
    if (l.contains('sport') || l.contains('pe')) return Colors.orange;
    if (l.contains('history') || l.contains('geo')) return Colors.brown;
    if (l.contains('lunch') || l.contains('break')) return Colors.amber;
    return Colors.blueGrey;
  }
}
