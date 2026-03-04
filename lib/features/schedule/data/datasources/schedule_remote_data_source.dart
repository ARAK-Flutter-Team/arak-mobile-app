import '../models/schedule_item_model.dart';

abstract class ScheduleRemoteDataSource {
  Future<List<ScheduleItemModel>> getTeacherSchedule(int teacherId);
}