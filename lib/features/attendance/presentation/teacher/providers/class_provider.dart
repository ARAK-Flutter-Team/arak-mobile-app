import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/network/dio_provider.dart';

// DataSource
class ClassRemoteDataSourceImpl implements ClassRemoteDataSource {
  final Dio dio;
  ClassRemoteDataSourceImpl(this.dio);

  @override
  Future<List<Map<String, dynamic>>> getClasses() async {
    final response = await dio.get("/Classes");
    if (response.statusCode == 200 && response.data is List) {
      return List<Map<String, dynamic>>.from(response.data);
    }
    return [];
  }
}

abstract class ClassRemoteDataSource {
  Future<List<Map<String, dynamic>>> getClasses();
}

// Repository
class ClassRepositoryImpl implements ClassRepository {
  final ClassRemoteDataSource remote;
  ClassRepositoryImpl(this.remote);

  @override
  Future<List<ClassEntity>> getClasses() async {
    final data = await remote.getClasses();
    return data.map((c) => ClassEntity(
      id: c['id'].toString(),
      name: c['name'] ?? '',
      grade: c['grade'] ?? '',
    )).toList();
  }
}

abstract class ClassRepository {
  Future<List<ClassEntity>> getClasses();
}

// Entity
class ClassEntity {
  final String id;
  final String name;
  final String grade;
  ClassEntity({required this.id, required this.name, required this.grade});
}

// UseCase
class GetClassesUseCase {
  final ClassRepository repository;
  GetClassesUseCase(this.repository);
  Future<List<ClassEntity>> call() => repository.getClasses();
}

// Providers
final classRemoteDataSourceProvider = Provider<ClassRemoteDataSource>(
      (ref) => ClassRemoteDataSourceImpl(ref.read(dioProvider)),
);

final classRepositoryProvider = Provider<ClassRepository>(
      (ref) => ClassRepositoryImpl(ref.read(classRemoteDataSourceProvider)),
);

final getClassesUseCaseProvider = Provider<GetClassesUseCase>(
      (ref) => GetClassesUseCase(ref.read(classRepositoryProvider)),
);