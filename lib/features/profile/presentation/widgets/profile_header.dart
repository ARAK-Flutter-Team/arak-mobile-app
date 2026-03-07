import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/entities/user.dart';
import 'profile_image.dart';

class ProfileHeader extends StatelessWidget {

  final User user;

  const ProfileHeader({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {

    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [

        const ProfileImage(),

         SizedBox(height: 10.h),

        Text(
          user.name,
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: colorScheme.onBackground,
          ),
        ),

         SizedBox(height: 4.h),

        Text(
          user.role.name,
          style: TextStyle(
            fontSize: 12.sp,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}