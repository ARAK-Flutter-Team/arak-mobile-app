import '../../domain/entities/day_schedule.dart';
import '../../domain/repositories/schedule_repository.dart';
import '../datasources/schedule_local_data_source.dart';
import '../enums/schedule_view_type.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleLocalDataSource _localDataSource;

  ScheduleRepositoryImpl(this._localDataSource);

  @override
  List<DaySchedule> getDisplaySchedule(int viewTypeIndex) {
    // 0 = Daily, 1 = Weekly (تحويل بسيط)
    if (viewTypeIndex == 1) {
      return _localDataSource.getFullWeekSchedule();
    } else {
      String today = _localDataSource.getCurrentDayName();
      try {
        return [
          _localDataSource
              .getFullWeekSchedule()
              .firstWhere((day) => day.dayName == today)
        ];
      } catch (e) {
        return [_localDataSource.getFullWeekSchedule().first];
      }
    }
  }
}
