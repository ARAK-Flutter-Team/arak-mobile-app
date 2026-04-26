import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/schedule_filters.dart';

final scheduleFiltersProvider = StateProvider<ScheduleFilters>((ref) {
  return const ScheduleFilters();
});

final scheduleFilterControllerProvider = Provider((ref) {
  return ScheduleFilterController(ref);
});

class ScheduleFilterController {
  final Ref _ref;
  ScheduleFilterController(this._ref);

  void setFilters(ScheduleFilters newFilters) {
    _ref.read(scheduleFiltersProvider.notifier).state = newFilters;
  }

  void updateFilter({
    int? classId,
  }) {
    final current = _ref.read(scheduleFiltersProvider);
    _ref.read(scheduleFiltersProvider.notifier).state = current.copyWith(
      classId: classId,
    );
  }

  void clearFilters() {
    _ref.read(scheduleFiltersProvider.notifier).state = const ScheduleFilters();
  }
}