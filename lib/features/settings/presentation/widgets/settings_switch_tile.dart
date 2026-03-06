import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsSwitchTile extends StatelessWidget {
  final String title;
  final bool value;
  final Function(bool) onChanged;

  const SettingsSwitchTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding:  EdgeInsets.symmetric(
        vertical: 12.h,
        horizontal: 4.w,
      ),
      child: Row(
        children: [

          /// النص
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontFamily: 'Teachers',
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          /// السويتش
          Switch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}