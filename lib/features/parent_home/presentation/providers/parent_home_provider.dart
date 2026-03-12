import 'package:arak_app/features/parent_home/data/datasources/parent_home_remote_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arak_app/features/parent_home/data/repositories/parent_home_repository_impl.dart';
import 'package:arak_app/features/parent_home/domain/entities/parent_home_entity.dart';
import 'package:arak_app/features/parent_home/domain/entities/student_entity.dart';
import 'package:arak_app/features/parent_home/domain/usecases/get_parent_home_data_usecase.dart';
import 'package:arak_app/features/parent_home/domain/usecases/get_parent_recent_activities_usecase.dart';
import 'package:arak_app/shared/models/activity_model.dart';
import 'package:arak_app/core/usecase/no_params.dart';

final _dataSourceProvider = Provider<ParentHomeRemoteDataSource>(
  (_) => ParentHomeRemoteDataSourceImpl(),
);

final _repositoryProvider = Provider<ParentHomeRepositoryImpl>(
  (ref) => ParentHomeRepositoryImpl(ref.watch(_dataSourceProvider)),
);

final _useCaseProvider = Provider<GetParentHomeDataUseCase>(
  (ref) => GetParentHomeDataUseCase(ref.watch(_repositoryProvider)),
);

final _activitiesUseCaseProvider = Provider<GetParentRecentActivitiesUseCase>(
  (ref) => GetParentRecentActivitiesUseCase(ref.watch(_repositoryProvider)),
);

final parentHomeProvider = FutureProvider<ParentHomeEntity>((ref) async {
  final usecase = ref.watch(_useCaseProvider);
  final result = await usecase(const NoParams());
  return result.fold(
    (failure) => throw Exception(failure.message),
    (data) => data,
  );
});

final selectedStudentIndexProvider = StateProvider<int>((ref) => 0);

final selectedStudentProvider = Provider<StudentEntity?>((ref) {
  final homeAsync = ref.watch(parentHomeProvider);
  final index = ref.watch(selectedStudentIndexProvider);
  return homeAsync.whenData((data) => data.students[index]).value;
});

final parentRecentActivitiesProvider =
    FutureProvider<List<ActivityModel>>((ref) async {
  final usecase = ref.watch(_activitiesUseCaseProvider);
  final result = await usecase(const NoParams());
  return result.fold(
    (failure) => throw Exception(failure.message),
    (activities) => activities,
  );
});

// في نهاية الملف بعد باقي الـ providers
final parentNameProvider = Provider<String>((ref) {
  final homeAsync = ref.watch(parentHomeProvider);
  return homeAsync.whenData((d) => d.parentName).value ?? '';
});
