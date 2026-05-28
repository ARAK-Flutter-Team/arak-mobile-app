import 'package:dio/dio.dart';
import '../models/notification_model.dart';
import 'notification_remote_datasource.dart';

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final Dio dio;

  NotificationRemoteDataSourceImpl(this.dio);

  @override
  Future<List<NotificationModel>> getNotifications(
      {int page = 1, int pageSize = 50}) async {
    final response = await dio.get(
      '/notifications',
      queryParameters: {'page': page, 'pageSize': pageSize},
    );

    if (response.statusCode == 200) {
      final dynamic raw = response.data;
      final List<dynamic> data =
          raw is List ? raw : (raw['data'] as List? ?? []);
      return data.map((e) => NotificationModel.fromJson(e)).toList();
    }
    throw Exception('Failed to load notifications: ${response.statusCode}');
  }

  @override
  Future<int> getUnreadCount() async {
    final response = await dio.get('/notifications/unread-count');

    if (response.statusCode == 200) {
      final dynamic data = response.data;
      if (data is int) return data;
      if (data is Map) {
        final value =
            data['count'] ?? data['unreadCount'] ?? data['total'] ?? 0;
        return (value as num).toInt();
      }
      return 0;
    }
    throw Exception('Failed to get unread count: ${response.statusCode}');
  }

  @override
  Future<void> markAllAsRead() async {
    final response = await dio.patch('/notifications/read-all');
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to mark all as read: ${response.statusCode}');
    }
  }

  @override
  Future<void> markAsRead(int id) async {
    final response = await dio.patch('/notifications/$id/read');
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception(
          'Failed to mark notification $id as read: ${response.statusCode}');
    }
  }
}
