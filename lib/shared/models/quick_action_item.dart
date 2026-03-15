import 'package:equatable/equatable.dart';

class QuickActionItem extends Equatable {
  final String title;
  final String iconPath;
  final String? route;
  final bool keepOriginalIconColor;
  final Object? extra;

  const QuickActionItem({
    required this.title,
    required this.iconPath,
    this.route,
    this.keepOriginalIconColor = false,
    this.extra,
  });

  @override
  List<Object?> get props => [title, iconPath, route];
}
