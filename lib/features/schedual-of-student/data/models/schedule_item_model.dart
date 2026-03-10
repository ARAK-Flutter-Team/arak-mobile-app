import 'package:flutter/material.dart';
import '../../domain/entities/schedule_item.dart';

class ScheduleItemModel extends ScheduleItem {
  ScheduleItemModel({
    required super.iconContent,
    required super.iconBackgroundColor,
    required super.time,
    required super.title,
  });
}
