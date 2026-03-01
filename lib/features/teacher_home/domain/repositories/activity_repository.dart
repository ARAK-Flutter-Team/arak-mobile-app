import '../../../../shared/models/activity_model.dart';

abstract class ActivityRepository {
  Future<List<ActivityModel>> getRecentActivities(String role);
}