import '../entities/search_result.dart';
import '../repositories/search_repository.dart';

class SearchEverything {
  final SearchRepository repository;

  SearchEverything(this.repository);

  Future<List<SearchResult>> call(String query) {
    return repository.search(query);
  }
}