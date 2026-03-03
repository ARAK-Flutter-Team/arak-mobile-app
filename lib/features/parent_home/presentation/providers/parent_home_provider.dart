import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/injection_container.dart';
import '../../domain/entities/parent_home_entity.dart';
import '../../domain/entities/student_entity.dart';
import '../../domain/usecases/get_parent_home_data_usecase.dart';
import '../../domain/usecases/get_parent_recent_activities_usecase.dart';
import '../../../../shared/models/activity_model.dart';
import '../../../../core/usecase/no_params.dart';

// ── 1. كل بيانات الـ parent (اسمه + الـ students + performance)
final parentHomeProvider = FutureProvider<ParentHomeEntity>((ref) async {
  final usecase = sl<GetParentHomeDataUseCase>();
  final result = await usecase(const NoParams());
  return result.fold(
    (failure) => throw Exception(failure.message),
    (data) => data,
  );
});

// ── 2. الـ selected student (للـ pagination بين الأبناء)
final selectedStudentIndexProvider = StateProvider<int>((ref) => 0);

// ── derived provider — الـ student الحالي بناءً على الـ index
final selectedStudentProvider = Provider<StudentEntity?>((ref) {
  final homeAsync = ref.watch(parentHomeProvider);
  final index = ref.watch(selectedStudentIndexProvider);
  return homeAsync.whenData((data) => data.students[index]).value;
});

// ── 3. الـ recent activities منفصلة

final parentRecentActivitiesProvider =
    FutureProvider<List<ActivityModel>>((ref) async {
  // ✅
  final usecase = sl<GetParentRecentActivitiesUseCase>();
  final result = await usecase(const NoParams());
  return result.fold(
    (failure) => throw Exception(failure.message),
    (activities) => activities,
  );
});
