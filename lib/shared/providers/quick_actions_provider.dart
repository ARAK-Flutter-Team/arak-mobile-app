/*import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/quick_action_item.dart';

final quickActionsProvider = StateProvider<List<QuickActionItem>>((ref) {
  return [
    QuickActionItem(title: 'tasks', iconPath: 'assets/icons/tasks.svg', route: '/teacher/tasks'),
    QuickActionItem(title: 'messages', iconPath: 'assets/icons/messages.svg', route: '/chat'),
    QuickActionItem(title: 'schedule', iconPath: 'assets/icons/schedule.svg', route: '/teacher-schedule'),
    QuickActionItem(title: 'attendance', iconPath: 'assets/icons/attendance.svg', route: '/teacher/attendance'),
  ];
});*/
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/quick_action_item.dart';

final quickActionsProvider = StateProvider<List<QuickActionItem>>((ref) {
  return [
    QuickActionItem(title: 'tasks', iconPath: 'assets/icons/tasks.svg', route: '/teacher/tasks'),
    QuickActionItem(title: 'messages', iconPath: 'assets/icons/messages.svg', route: '/chat'),
    QuickActionItem(title: 'schedule', iconPath: 'assets/icons/schedule.svg', route: '/teacher-schedule'),
    QuickActionItem(title: 'attendance', iconPath: 'assets/icons/attendance.svg', route: '/teacher/attendance'),
  ];
});