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
    try {
      final response = await dio.get('/api/Parents/me');
      return ParentHomeModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      // مؤقتاً لحد ما الـ API يجهز
      return ParentHomeModel(
        parentName: 'John Parent',
        performancePercentage: 78,
        students: [
          StudentModel(
            id: '5',
            name: 'Ahmed',
            grade: 3,
            classNumber: 1,
            profileImage: null,
            parentUsername: 'parent1@arak.com',
            isVerified: true,
          ),
          StudentModel(
            id: '6',
            name: 'Ibrahem Saed',
            grade: 7,
            classNumber: 1,
            profileImage: null,
            parentUsername: 'parent1@arak.com',
            isVerified: true,
          ),
        ],
      );
    }
  }

  @override
  Future<List<ActivityModel>> getRecentActivities() async {
    try {
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
    } catch (e) {
      return []; // فاضية مؤقتاً
    }
  }
}
