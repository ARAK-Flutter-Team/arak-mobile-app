import 'package:dio/dio.dart';
import '../models/search_result_model.dart';
import '../../domain/entities/search_result.dart';

abstract class SearchRemoteDataSource {
  Future<List<SearchResultModel>> search(String query);
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final Dio dio;

  SearchRemoteDataSourceImpl(this.dio);

  @override
  Future<List<SearchResultModel>> search(String query) async {
    if (query.trim().isEmpty) return [];

    try {
      print('DEBUG: Teacher Search - Query: $query');

      // 1. Search Students by Name
      final studentUrl = '/students/SearchStudentsByName/$query';
      print('DEBUG: Calling Student Search API: $studentUrl');
      final studentResponse = await dio.get(studentUrl);
      print('DEBUG: Student Search Status: ${studentResponse.statusCode}');
      print('DEBUG: Student Search Response: ${studentResponse.data}');

      // 2. Search Tasks by query
      final taskUrl = '/tasks';
      print('DEBUG: Calling Task Search API: $taskUrl?q=$query');
      final taskResponse = await dio.get(
        taskUrl,
        queryParameters: {'q': query},
      );
      print('DEBUG: Task Search Status: ${taskResponse.statusCode}');
      print('DEBUG: Task Search Response: ${taskResponse.data}');

      final List<SearchResultModel> results = [];

      // Process Students
      final dynamic studentData = studentResponse.data;
      if (studentData is List) {
        for (var s in studentData) {
          final id = s['id'] ?? s['Id'];
          final name = s['name'] ?? s['Name'] ?? '';
          results.add(SearchResultModel(
            id: id.toString(),
            title: name,
            subtitle: "Student",
            type: SearchType.student,
            route: "/student/$id",
          ));
        }
      }

      // Process Tasks
      final dynamic taskData = taskResponse.data;
      if (taskData is List) {
        for (var t in taskData) {
          final id = t['id'] ?? t['Id'];
          final title = t['title'] ?? t['Title'] ?? '';
          results.add(SearchResultModel(
            id: id.toString(),
            title: title,
            subtitle: "Task",
            type: SearchType.task,
            route: "/task/$id",
          ));
        }
      }

      return results;
    } catch (e) {
      print('DEBUG: Teacher Search Error: $e');
      return [];
    }
  }
}