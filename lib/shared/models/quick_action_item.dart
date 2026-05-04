import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class QuickActionItem extends Equatable {
  final String title;
  final String? iconPath;
  final IconData? iconData;
  final String? route;
  final bool keepOriginalIconColor;
  final Object? extra;

  const QuickActionItem({
    required this.title,
    this.iconPath,
    this.iconData,
    this.route,
    this.keepOriginalIconColor = false,
    this.extra,
  });

  @override
  List<Object?> get props => [title, iconPath, iconData, route];
}
