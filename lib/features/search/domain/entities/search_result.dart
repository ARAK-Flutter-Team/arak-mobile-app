enum SearchType {
  student,
  task,
  message,
  schedule,
}

class SearchResult {
  final String id;
  final String title;
  final String? subtitle;
  final SearchType type;
  final String route;

  const SearchResult({
    required this.id,
    required this.title,
    this.subtitle,
    required this.type,
    required this.route,
  });
}