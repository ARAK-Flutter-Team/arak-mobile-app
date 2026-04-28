// lib/features/schedule/data/repositories/schedule_repository_impl.dart

import '../../domain/entities/day_schedule.dart';
import '../../domain/repositories/schedule_repository.dart';
import '../datasources/schedule_remote_data_source.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleRemoteDataSource _remote;

  ScheduleRepositoryImpl(this._remote);

  @override
  Future<List<DaySchedule>> getDisplaySchedule(
    int viewTypeIndex, {
    int? classId,
    int? teacherId,
  }) async {
    final items = await _remote.getSchedules(
      classId: classId,
      teacherId: teacherId,
    );

    // جمّع items حسب اليوم
    final Map<String, List> grouped = {};
    for (final item in items) {
      grouped.putIfAbsent(item.dayName, () => []).add(item);
    }

    const dayOrder = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ];

    final allDays = dayOrder
        .where((d) => grouped.containsKey(d))
        .map((d) => DaySchedule(dayName: d, items: grouped[d]!.cast()))
        .toList();

    if (viewTypeIndex == 1) return allDays; // Weekly — كل الأيام

    // Daily — اليوم الحالي بس
    final today = _remote.getCurrentDayName();
    final todayList = allDays.where((d) => d.dayName == today).toList();
    return todayList.isEmpty
        ? (allDays.isEmpty ? [] : [allDays.first])
        : todayList;
  }
}
