// lib/features/schedule/data/datasources/schedule_remote_data_source.dart

import 'package:dio/dio.dart';
import '../models/schedule_item_model.dart';

class ScheduleRemoteDataSource {
  final Dio _dio;

  ScheduleRemoteDataSource(this._dio);

  Future<List<ScheduleItemModel>> getSchedules({
    int? classId,
    int? teacherId,
  }) async {
    final queryParams = <String, dynamic>{};
    if (classId != null) queryParams['classId'] = classId;
    if (teacherId != null) queryParams['teacherId'] = teacherId;

    final response = await _dio.get(
      '/api/Schedules',
      queryParameters: queryParams,
    );

    List dataList = [];
    if (response.data is List) {
      dataList = response.data as List;
    } else if (response.data is Map && response.data['\$values'] is List) {
      dataList = response.data['\$values'] as List;
    } else if (response.data is Map && response.data['data'] is List) {
      dataList = response.data['data'] as List;
    }

    return dataList
        .map((e) => ScheduleItemModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  String getCurrentDayName() {
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    return days[DateTime.now().weekday - 1];
  }
}
