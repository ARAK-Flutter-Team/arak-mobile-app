/*import '../entities/schedule_item.dart';

abstract class ScheduleRepository {
  Future<List<ScheduleItem>> getTeacherSchedule(int teacherId);
}*/
import '../entities/schedule_filters.dart';
import '../entities/schedule_item.dart';

abstract class ScheduleRepository {
  Future<List<ScheduleItem>> getSchedules(ScheduleFilters filters);
}