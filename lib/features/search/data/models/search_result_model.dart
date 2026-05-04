import 'package:arak_app/features/search/domain/entities/search_result.dart';

class SearchResultModel extends SearchResult {
  const SearchResultModel({
    required super.id,
    required super.title,
    super.subtitle,
    required super.type,
    required super.route,
    super.extra,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) {
    return SearchResultModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      subtitle: json['subtitle'],
      type: _mapType(json['type']),
      route: json['route'] ?? '',
      extra: json['extra'],
    );
  }

  static SearchType _mapType(dynamic type) {
    if (type is SearchType) return type;
    switch (type.toString()) {
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