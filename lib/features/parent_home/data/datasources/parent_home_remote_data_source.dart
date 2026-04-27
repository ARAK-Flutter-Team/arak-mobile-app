import 'package:dio/dio.dart';
import '../../../../shared/models/activity_model.dart';
import '../models/parent_home_model.dart';
import '../models/student_model.dart';

abstract class ParentHomeRemoteDataSource {
  Future<ParentHomeModel> getParentHomeData();
  Future<List<ActivityModel>> getRecentActivities();
}

class ParentHomeRemoteDataSourceImpl implements ParentHomeRemoteDataSource {
  final Dio dio;
  ParentHomeRemoteDataSourceImpl(this.dio);

  @override
  Future<ParentHomeModel> getParentHomeData() async {
    final response = await dio.get('/api/Parents/me');
    return ParentHomeModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<List<ActivityModel>> getRecentActivities() async {
    final response = await dio.get('/api/Parents/me/activities');
    final List data = response.data as List? ?? [];
    return data
        .map((a) => ActivityModel(
              id: a['id']?.toString() ?? '',
              title: a['title'] ?? '',
              iconPath: 'assets/icons/tasks.svg',
              keepOriginalIconColor: false,
              route: null,
            ))
        .toList();
  }
}
