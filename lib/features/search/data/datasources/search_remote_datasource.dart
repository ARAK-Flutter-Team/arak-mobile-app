import '../models/search_result_model.dart';
import '../../domain/entities/search_result.dart';

abstract class SearchRemoteDataSource {
  Future<List<SearchResultModel>> search(String query);
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {

  @override
  Future<List<SearchResultModel>> search(String query) async {

    /// لاحقًا هنا هيكون API
    await Future.delayed(const Duration(milliseconds: 500));

    return [

      SearchResultModel(
        id: "1",
        title: "Ahmed Ali",
        subtitle: "Grade 3",
        type: SearchType.student,
        route: "/student/1",
      ),

      SearchResultModel(
        id: "2",
        title: "Math Homework",
        type: SearchType.task,
        route: "/task/2",
      ),

    ];
  }
}