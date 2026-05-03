import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/schedule_item_model.dart';
import '../../domain/entities/schedule_filters.dart';
import 'schedule_remote_data_source.dart';

class ScheduleRemoteDataSourceImpl implements ScheduleRemoteDataSource {
  final Dio dio;

  ScheduleRemoteDataSourceImpl(this.dio);

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<int?> _getTeacherIdFromToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) return null;

    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;

      String payload = parts[1];
      while (payload.length % 4 != 0) {
        payload += '=';
      }

      final bytes = base64Decode(payload);
      final json = jsonDecode(utf8.decode(bytes));

      return json['teacherId'] ?? json['TeacherId'] as int?;
    } catch (e) {
      print('Failed to get teacherId from token: $e');
      return null;
    }
  }

  @override
  Future<List<ScheduleItemModel>> getSchedules(ScheduleFilters filters) async {
    try {
      final token = await _getToken();
      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      } else {
        print('No token found. User may not be logged in.');
      }

      final queryParams = filters.toQueryParams();
      
      // If teacherId is not in filters, try to get it from token (for Teachers viewing their own schedule)
      if (queryParams['teacherId'] == null) {
        final teacherIdFromToken = await _getTeacherIdFromToken();
        if (teacherIdFromToken != null) {
          queryParams['teacherId'] = teacherIdFromToken;
        }
      }

      print('GET /Schedules?$queryParams');

      final response = await dio.get(
        '/Schedules',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        List dataList = [];

        if (response.data is List) {
          dataList = response.data as List;
        } else if (response.data is Map && response.data['data'] is List) {
          dataList = response.data['data'] as List;
        } else if (response.data is Map && response.data['\$values'] is List) {
          dataList = response.data['\$values'] as List;
        } else {
          print('Unknown response format: ${response.data.runtimeType}');
          return [];
        }

        print('Parsing ${dataList.length} schedule items');
        return dataList
            .map((json) => ScheduleItemModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load schedules: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('Dio Error: ${e.message}');
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized: Please login again');
      }
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      print('Error: $e');
      throw Exception('Unexpected error: $e');
    }
  }
}