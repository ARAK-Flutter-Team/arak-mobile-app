import '../entities/day_schedule.dart';

abstract class ScheduleRepository {
  List<DaySchedule> getDisplaySchedule(int viewTypeIndex); // هنبعت رقم بدل Enum
}
