import '../models/teacher_home_model.dart';

abstract class TeacherHomeRemoteDataSource {
  Future<TeacherHomeModel> getTeacherHomeData();
}