# Clean API Integration Guide (Frontend to Backend)

This document provides a comprehensive, step-by-step analysis and guide for cleanly integrating your backend APIs with your existing Flutter frontend, utilizing Clean Architecture, Dio, and Riverpod.

## 1. System Analysis
**Current Architecture:** Clean Architecture (Domain, Data, Presentation layers).
**State Management:** Riverpod (`flutter_riverpod`).
**Networking:** Dio (`dio`) with a centralized provider (`DioProvider` already configured in `lib/core/network/dio_provider.dart`).
**Current State:** Features (like `Evaluation` and others) currently rely on mocked data (`Future.delayed`) inside their respective `RemoteDataSourceImpl` files.

**The Goal:** Transition from mocked data to real network requests seamlessly without breaking the clean architecture boundaries.

## 2. Step-by-Step Integration Plan

### Step 1: Centralize API Endpoints
Do not hardcode URLs in your Data Sources. Use `lib/core/network/endpoints.dart` to keep them organized and easily modifiable.

**`lib/core/network/endpoints.dart`**
```dart
class Endpoints {
  // Base URL is already handled in DioProvider. Just add the API paths here:
  static const String login = '/api/auth/login';
  static const String studentEvaluation = '/api/students/evaluation';
  static const String searchStudents = '/api/students/search';
}
```

### Step 2: Inject Dio into your Remote Data Sources
To make real network calls, your `RemoteDataSourceImpl` needs an instance of `Dio`.

**`lib/features/evaluation/data/datasources/evaluation_remote_data_source.dart`**
```dart
import 'package:dio/dio.dart';
import '../../../../core/network/endpoints.dart';
import '../models/student_model.dart';
import '../../../../core/error/exceptions.dart'; // Define your custom exceptions here

abstract class EvaluationRemoteDataSource {
  Future<StudentModel> getStudentEvaluation(String studentId);
}

class EvaluationRemoteDataSourceImpl implements EvaluationRemoteDataSource {
  final Dio dio;

  // Require Dio in the constructor for dependency injection
  EvaluationRemoteDataSourceImpl({required this.dio});

  @override
  Future<StudentModel> getStudentEvaluation(String studentId) async {
    try {
      // 1. Make the API Call
      final response = await dio.get(
        Endpoints.studentEvaluation,
        queryParameters: {'studentId': studentId},
      );

      // 2. Parse JSON from response.data
      if (response.statusCode == 200) {
        return StudentModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      // 3. Handle Dio-specific errors
      throw ServerException(message: e.message ?? 'Network error occurred');
    }
  }
}
```

### Step 3: Complete JSON Parsing in Models
Your models must handle complex JSON structures (like nested lists). Make sure `fromJson` maps the incoming server data correctly.

**`lib/features/evaluation/data/models/student_model.dart`**
```dart
import '../../domain/entities/student_entity.dart';

class StudentModel extends Student {
  const StudentModel({
    required super.name,
    required super.grade,
    required super.subjects,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      name: json['name'] ?? 'Unknown',
      grade: json['grade'] ?? 'Unknown',
      // Map the nested list of subjects safely
      subjects: (json['subjects'] as List<dynamic>?)
          ?.map((e) => SubjectModel.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
    );
  }
}

// Note: You must also create a SubjectModel that extends Subject and has a fromJson factory.
```

### Step 4: Handle Exceptions in the Repository Layer
The repository's job is to catch exceptions thrown by the Data Source and convert them into `Failure` objects for the domain/presentation layer.

**`lib/features/evaluation/data/repositories/evaluation_repository_impl.dart`**
```dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/student_entity.dart';
import '../../domain/repositories/evaluation_repository.dart';
import '../datasources/evaluation_remote_data_source.dart';

class EvaluationRepositoryImpl implements EvaluationRepository {
  final EvaluationRemoteDataSource remoteDataSource;

  EvaluationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Student>> getStudentEvaluation(String studentId) async {
    try {
      // Fetch from API
      final studentModel = await remoteDataSource.getStudentEvaluation(studentId);
      // Return right side of Either (Success)
      return Right(studentModel); 
    } catch (e) {
      // Catch exceptions from DataSource and return Left (Failure)
      return Left(ServerFailure(e.toString()));
    }
  }
}
```

### Step 5: Setup Riverpod Providers & Dependency Injection
Connect the `Dio` instance to your DataSource, and your DataSource to your Repository using Riverpod.

**`lib/features/evaluation/presentation/providers/evaluation_provider.dart`**
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_provider.dart';
import '../../data/datasources/evaluation_remote_data_source.dart';
import '../../data/repositories/evaluation_repository_impl.dart';
import '../../domain/repositories/evaluation_repository.dart';

// 1. Provide the Remote Data Source (Injecting Dio)
final evaluationRemoteDataSourceProvider = Provider<EvaluationRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider); // Watch the Dio instance from your core setup
  return EvaluationRemoteDataSourceImpl(dio: dio);
});

// 2. Provide the Repository (Injecting Remote Data Source)
final evaluationRepositoryProvider = Provider<EvaluationRepository>((ref) {
  final remoteDataSource = ref.watch(evaluationRemoteDataSourceProvider);
  return EvaluationRepositoryImpl(remoteDataSource: remoteDataSource);
});

// 3. Setup your StateNotifier / FutureProvider using the Usecase/Repository for the UI layer
```

## 3. Best Practices for This Project
1. **Authorization Token**: Your `DioProvider` already adds `Authorization: Bearer <token>` automatically in the Interceptor. You don't need to manually attach the token to every request in your `RemoteDataSource`.
2. **Data Mapping with Generators**: You have `json_annotation`, `json_serializable`, and `freezed` in your `pubspec.yaml`. It is highly recommended to use them to auto-generate the `fromJson` and `toJson` methods to prevent manual mapping errors.
3. **Global Error Handling**: Standardize backend error responses. If your backend returns `{ "error": "Invalid student ID" }`, read this in `DioProvider`'s `onError` or inside the `RemoteDataSource` catch block via `e.response?.data['error']`.
