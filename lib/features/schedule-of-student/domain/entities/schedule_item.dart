import 'package:flutter/material.dart';

class ScheduleItem {
  final Widget iconContent;
  final Color iconBackgroundColor;
  final String time;
  final String title;

  ScheduleItem({
    required this.iconContent,
    required this.iconBackgroundColor,
    required this.time,
    required this.title,
  });
}
