import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/notification_model.dart';
import 'notification_remote_datasource.dart';

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  // ✅ Uses the central ApiConstants so the IP is changed in one place only
  final String baseUrl = '${ApiConstants.baseUrl}/api';

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token'); // ← نفس الـ key اللي بتحفظ فيه الـ token
  }

  Future<Map<String, String>> _headers() async {
    final token = await _getToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  @override
  Future<List<NotificationModel>> getNotifications(
      {int page = 1, int pageSize = 50}) async {
    final headers = await _headers();
    final uri =
        Uri.parse('$baseUrl/notifications?page=$page&pageSize=$pageSize');
    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => NotificationModel.fromJson(e)).toList();
    }
    throw Exception('Failed to load notifications: ${response.statusCode}');
  }

  @override
  Future<int> getUnreadCount() async {
    final headers = await _headers();
    final uri = Uri.parse('$baseUrl/notifications/unread-count');
    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // ✅ Safe cast — handles int, long, or double from the JSON serializer
      return (data['count'] as num).toInt();
    }
    throw Exception('Failed to get unread count');
  }

  @override
  Future<void> markAllAsRead() async {
    final headers = await _headers();
    final uri = Uri.parse('$baseUrl/notifications/read-all');
    await http.patch(uri, headers: headers);
  }

  @override
  Future<void> markAsRead(int id) async {
    final headers = await _headers();
    final uri = Uri.parse('$baseUrl/notifications/$id/read');
    await http.patch(uri, headers: headers);
  }
}
