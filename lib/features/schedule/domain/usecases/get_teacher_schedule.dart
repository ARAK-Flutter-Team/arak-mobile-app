/*import '../entities/schedule_item.dart';
import '../repositories/schedule_repository.dart';

class GetTeacherSchedule {
  final ScheduleRepository repository;

  GetTeacherSchedule(this.repository);

  Future<List<ScheduleItem>> call(int  teacherId) {
    return repository.getTeacherSchedule(teacherId);
  }
}*/
import '../entities/schedule_filters.dart';
import '../entities/schedule_item.dart';
import '../repositories/schedule_repository.dart';

class GetTeacherSchedule {
  final ScheduleRepository repository;

  GetTeacherSchedule(this.repository);

  Future<List<ScheduleItem>> call(int teacherId) {
    return repository.getSchedules(ScheduleFilters(teacherId: teacherId));
  }
}