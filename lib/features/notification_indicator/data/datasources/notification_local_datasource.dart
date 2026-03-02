import 'package:shared_preferences/shared_preferences.dart';

class NotificationLocalDataSource {
  static const _taskKey = 'last_seen_task_id';
  static const _messageKey = 'last_seen_message_id';

  Future<int> getLastSeenTaskId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_taskKey) ?? 0;
  }

  Future<int> getLastSeenMessageId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_messageKey) ?? 0;
  }

  Future<void> saveLastSeenTaskId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_taskKey, id);
  }

  Future<void> saveLastSeenMessageId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_messageKey, id);
  }
}