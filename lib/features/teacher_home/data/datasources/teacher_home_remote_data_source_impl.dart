import '../models/teacher_home_model.dart';
import 'teacher_home_remote_data_source.dart';

class TeacherHomeRemoteDataSourceImpl
    implements TeacherHomeRemoteDataSource {

  // final Dio dio;

  TeacherHomeRemoteDataSourceImpl(/* this.dio */);

  @override
  Future<TeacherHomeModel> getTeacherHomeData() async {

    // TODO: Replace with real API call when backend is ready
    // final response = await dio.get('/teacher/home');
    // return TeacherHomeModel.fromJson(response.data);

    throw UnimplementedError();
  }
}
/*
import 'package:dio/dio.dart';
import '../models/teacher_home_model.dart';
import 'teacher_home_remote_data_source.dart';

class TeacherHomeRemoteDataSourceImpl
    implements TeacherHomeRemoteDataSource {

  final Dio dio;

  TeacherHomeRemoteDataSourceImpl(this.dio);

  @override
  Future<TeacherHomeModel> getTeacherHomeData() async {

    final response = await dio.get('/api/teachers');

    final teacher = response.data[0]; // مؤقت

    return TeacherHomeModel(
      teacherName: teacher['name'],
      subjectName: teacher['subject'] ?? "",
      performance: 0.8,
      assignedClasses:
      List<String>.from(teacher['assignedClasses'] ?? []),
      hasNewTasks: false,
      hasNewMessages: false,
      todayClassesCount: 0,
      nextClass: null,
      recentActivities: [],
    );
  }
}*/