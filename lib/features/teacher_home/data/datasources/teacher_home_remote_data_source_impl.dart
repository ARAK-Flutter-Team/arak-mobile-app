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