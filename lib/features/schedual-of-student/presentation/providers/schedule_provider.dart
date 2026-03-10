import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/day_schedule.dart';
import '../../domain/repositories/schedule_repository.dart';
import '../../data/providers/schedule_data_providers.dart';

// State Class
class ScheduleState {
  final int currentViewIndex; // 0: Daily, 1: Weekly
  final int bottomNavIndex;

  ScheduleState({
    this.currentViewIndex = 0,
    this.bottomNavIndex = 0,
  });

  ScheduleState copyWith({
    int? currentViewIndex,
    int? bottomNavIndex,
  }) {
    return ScheduleState(
      currentViewIndex: currentViewIndex ?? this.currentViewIndex,
      bottomNavIndex: bottomNavIndex ?? this.bottomNavIndex,
    );
  }
}

// Notifier Class
class ScheduleNotifier extends StateNotifier<ScheduleState> {
  final ScheduleRepository _repository;

  ScheduleNotifier(this._repository) : super(ScheduleState());

  List<DaySchedule> get displaySchedule {
    return _repository.getDisplaySchedule(state.currentViewIndex);
  }

  void toggleView(int index) {
    state = state.copyWith(currentViewIndex: index);
  }

  void setBottomNavIndex(int index) {
    state = state.copyWith(bottomNavIndex: index);
  }
}

// Provider Declaration
final scheduleNotifierProvider =
    StateNotifierProvider<ScheduleNotifier, ScheduleState>((ref) {
  return ScheduleNotifier(ref.watch(scheduleRepositoryProvider));
});
