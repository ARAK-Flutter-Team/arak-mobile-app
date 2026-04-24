/*import '../models/schedule_item_model.dart';

abstract class ScheduleRemoteDataSource {
  Future<List<ScheduleItemModel>> getTeacherSchedule(int teacherId);
}*/
import 'package:arak_app/core/network/api_service.dart'; // تأكدي من المسار
import '../models/schedule_item_model.dart';

abstract class ScheduleRemoteDataSource {
  Future<List<ScheduleItemModel>> getTeacherSchedule(int teacherId);
}

class ScheduleRemoteDataSourceImpl implements ScheduleRemoteDataSource {
  final ApiService apiService;

  ScheduleRemoteDataSourceImpl(this.apiService);

  @override
  Future<List<ScheduleItemModel>> getTeacherSchedule(int teacherId) async {
    // استخدام الـ Endpoint والـ Query Parameters الصحيحة
    final response = await apiService.dio.get(
      '/api/Schedules',
      queryParameters: {'teacherId': teacherId},
    );

    // تحويل الاستجابة إلى List
    if (response.statusCode == 200) {
      return (response.data as List)
          .map((json) => ScheduleItemModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load schedules');
    }
  }
}