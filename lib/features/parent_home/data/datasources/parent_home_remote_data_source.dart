import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../models/parent_home_model.dart';

abstract class ParentHomeRemoteDataSource {
  Future<ParentHomeModel> getParentHomeData();
}

class ParentHomeRemoteDataSourceImpl implements ParentHomeRemoteDataSource {
  final Dio dio;
  ParentHomeRemoteDataSourceImpl(this.dio);

  @override
  Future<ParentHomeModel> getParentHomeData() async {
    final response = await dio.get('/Parents/me');
    final data = response.data as Map<String, dynamic>;

    // Use Isolate.run for heavy parsing to keep UI responsive
    return await compute((json) => ParentHomeModel.fromJson(json), data);
  }
}
