import 'package:flutter/material.dart';
import '../models/schedule_item_model.dart';
import '../../domain/entities/day_schedule.dart';

class ScheduleLocalDataSource {
  final List<DaySchedule> _fullWeekSchedule = <DaySchedule>[
    DaySchedule(dayName: 'Sunday', items: <ScheduleItemModel>[
      _createItem('09:00', 'Drawing', Icons.brush, Colors.purple),
      _createItem('10:00', 'English', Icons.menu_book, Colors.blue),
      // ... (كمل باقي الأيام بنفس النظام)
      _createItem('11:00', 'Lunch Break', Icons.lunch_dining, Colors.orange),
      _createItem('12:00', 'Math', Icons.calculate, Colors.teal),
    ]),
    DaySchedule(dayName: 'Monday', items: <ScheduleItemModel>[
      _createItem('09:00', 'English', Icons.menu_book, Colors.blue),
      // ...
    ]),
    // ... (كمل باقي الأيام الثلاثاء والأربعاء والخميس)
  ];

  List<DaySchedule> getFullWeekSchedule() => _fullWeekSchedule;

  static ScheduleItemModel _createItem(
      String time, String title, IconData icon, Color color) {
    return ScheduleItemModel(
      time: time,
      title: title,
      iconBackgroundColor: color,
      iconContent: Icon(icon, color: Colors.white, size: 22),
    );
  }

  String getCurrentDayName() {
    // ... (نفس كود معرفة اليوم اللي كتبناه قبل كده)
    var now = DateTime.now();
    var days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    return days[now.weekday - 1];
  }
}
