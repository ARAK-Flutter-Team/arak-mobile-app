import '../../domain/entities/search_result.dart';

class SearchResultModel extends SearchResult {

  const SearchResultModel({
    required super.id,
    required super.title,
    super.subtitle,
    required super.type,
    required super.route,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) {

    return SearchResultModel(

      id: json['id'] as String,

      title: json['title'] as String,

      subtitle: json['subtitle'] as String?,

      type: _mapType(json['type']),

      route: json['route'] as String,

    );

  }

  static SearchType _mapType(String type) {

    switch (type) {

      case "student":
        return SearchType.student;

      case "task":
        return SearchType.task;

      case "message":
        return SearchType.message;

      case "schedule":
        return SearchType.schedule;

      default:
        return SearchType.student;

    }

  }
}