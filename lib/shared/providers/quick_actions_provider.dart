import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/quick_action_item.dart';

final quickActionsProvider = StateProvider<List<QuickActionItem>>((ref) {
  return [
    QuickActionItem(title: 'Tasks', iconPath: 'assets/icons/tasks.svg', route: '/teacher/tasks'),
    QuickActionItem(title: 'Messages', iconPath: 'assets/icons/messages.svg', route: '/messages'),
    QuickActionItem(title: 'Schedule', iconPath: 'assets/icons/schedule.svg', route: '/teacher-schedule'),
    QuickActionItem(title: 'Attendance', iconPath: 'assets/icons/attendance.svg', route: '/teacher/attendance'),
  ];
});