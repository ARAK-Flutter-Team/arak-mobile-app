class ActivityModel {
  final String id;
  final String iconPath;
  final String title;
  final String? route; // optional navigation
  final bool keepOriginalIconColor;

  const ActivityModel({
    required this.id,
    required this.iconPath,
    required this.title,
    this.route,
    this.keepOriginalIconColor = false,
  });
}