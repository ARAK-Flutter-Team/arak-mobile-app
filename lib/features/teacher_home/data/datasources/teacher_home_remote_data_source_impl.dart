import 'package:arak_app/features/teacher_home/data/datasources/teacher_home_remote_data_source.dart';

import '../models/teacher_home_model.dart';

class TeacherHomeRemoteDataSourceImpl
    implements TeacherHomeRemoteDataSource {

  // final Dio dio;

  TeacherHomeRemoteDataSourceImpl(/* this.dio */);

  @override
  Future<TeacherHomeModel> getTeacherHomeData() async {
    // TODO: replace with real API call when backend is ready

    throw UnimplementedError();
  }
}