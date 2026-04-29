// lib/features/schedule/presentation/providers/schedule_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arak_app/features/parent_home/presentation/providers/parent_home_provider.dart';
import 'package:arak_app/features/parent_home/domain/entities/student_entity.dart';
import '../../domain/entities/day_schedule.dart';
import '../../domain/repositories/schedule_repository.dart';
import '../../data/providers/schedule_data_providers.dart';

class ScheduleState {
  final int currentViewIndex;
  final int bottomNavIndex;
  final List<DaySchedule> schedule;
  final bool isLoading;
  final String? error;

  ScheduleState({
    this.currentViewIndex = 0,
    this.bottomNavIndex = 0,
    this.schedule = const [],
    this.isLoading = false,
    this.error,
  });

  ScheduleState copyWith({
    int? currentViewIndex,
    int? bottomNavIndex,
    List<DaySchedule>? schedule,
    bool? isLoading,
    String? error,
  }) {
    return ScheduleState(
      currentViewIndex: currentViewIndex ?? this.currentViewIndex,
      bottomNavIndex: bottomNavIndex ?? this.bottomNavIndex,
      schedule: schedule ?? this.schedule,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class ScheduleNotifier extends StateNotifier<ScheduleState> {
  final ScheduleRepository _repository;
  final Ref _ref;

  ScheduleNotifier(this._repository, this._ref) : super(ScheduleState());

  List<DaySchedule> get displaySchedule => state.schedule;

  Future<void> loadParentSchedule() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // ✅ استنى لو الـ student لسه null
      StudentEntity? student = _ref.read(selectedStudentProvider);

      if (student == null) {
        final homeData = await _ref.read(parentHomeProvider.future);
        final index = _ref.read(selectedStudentIndexProvider);
        if (homeData.students.isEmpty) {
          state = state.copyWith(isLoading: false, schedule: []);
          return;
        }
        student = homeData.students[index];
      }

      print('📅 Loading schedule for classNumber: ${student.classNumber}');

      final result = await _repository.getDisplaySchedule(
        state.currentViewIndex,
        classId: student.classNumber,
      );
      state = state.copyWith(schedule: result, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> toggleView(int index) async {
    state = state.copyWith(currentViewIndex: index);
    await loadParentSchedule();
  }

  void setBottomNavIndex(int index) {
    state = state.copyWith(bottomNavIndex: index);
  }
}

final scheduleNotifierProvider =
    StateNotifierProvider<ScheduleNotifier, ScheduleState>((ref) {
  final notifier = ScheduleNotifier(ref.watch(scheduleRepositoryProvider), ref);

  // ✅ لما الـ student يتغير (مثلاً المستخدم اختار طالب تاني)، reload أوتوماتيك
  ref.listen(selectedStudentProvider, (previous, next) {
    if (next != null && next.classNumber != previous?.classNumber) {
      notifier.loadParentSchedule();
    }
  });

  return notifier;
});
