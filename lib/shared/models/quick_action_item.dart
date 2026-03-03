import 'package:equatable/equatable.dart';

class QuickActionItem extends Equatable {
  final String title;
  final String iconPath;
  final String? route;
  final bool keepOriginalIconColor;

  const QuickActionItem({
    required this.title,
    required this.iconPath,
    this.route,
    this.keepOriginalIconColor = false,
  });

  @override
  List<Object?> get props => [title, iconPath, route];
}
