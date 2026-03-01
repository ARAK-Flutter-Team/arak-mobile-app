import 'package:arak_app/features/teacher_home/presentation/providers/role_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/models/activity_model.dart';
import '../../domain/repositories/activity_repository.dart';
import '../../data/repositories/mock_activity_repository.dart';

final activityRepositoryProvider =
Provider<ActivityRepository>((ref) {
  return MockActivityRepository();
});

final recentActivitiesProvider =
FutureProvider<List<ActivityModel>>((ref) async {
  final role = ref.watch(userRoleProvider);
  final repo = ref.watch(activityRepositoryProvider);

  return repo.getRecentActivities(role.name);
});