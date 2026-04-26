import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/schedule_item_model.dart';
import '../../domain/entities/schedule_filters.dart';
import 'schedule_remote_data_source.dart';

class ScheduleRemoteDataSourceImpl implements ScheduleRemoteDataSource {
  final Dio dio;

  ScheduleRemoteDataSourceImpl(this.dio);

  // دالة مساعدة لجلب التوكن من SharedPreferences
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  @override
  Future<List<ScheduleItemModel>> getSchedules(ScheduleFilters filters) async {
    try {
      //  جلب التوكن وإضافته للـ headers
      final token = await _getToken();
      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
        print(" Token added to request headers");
      } else {
        print("️ No token found! User may not be logged in.");
      }

      //  بناء الـ query parameters
      final queryParams = <String, dynamic>{};
      if (filters.classId != null) queryParams['classId'] = filters.classId;
      if (filters.teacherId != null) queryParams['teacherId'] = filters.teacherId;

      //  طباعة الـ request بشكل صحيح
      print(" GET /api/Schedules?classId=${filters.classId}&teacherId=${filters.teacherId}");

      //  إرسال الطلب
      final response = await dio.get(
        '/api/Schedules',
        queryParameters: queryParams,
      );

      //  معالجة الـ response
      if (response.statusCode == 200) {
        List dataList = [];

        if (response.data is List) {
          dataList = response.data as List;
        } else if (response.data is Map && response.data['data'] is List) {
          dataList = response.data['data'] as List;
        } else if (response.data is Map && response.data['\$values'] is List) {
          dataList = response.data['\$values'] as List;
        } else {
          print("️ Unknown response format: ${response.data.runtimeType}");
          return [];
        }

        print(" Parsing ${dataList.length} schedule items");
        return dataList
            .map((json) => ScheduleItemModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load schedules: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print(" Dio Error: ${e.message}");
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized: Please login again');
      }
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      print(" Error: $e");
      throw Exception('Unexpected error: $e');
    }
  }
}