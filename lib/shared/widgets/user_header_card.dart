import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../shared/domain/entities/student.dart';
import '../theme/app_colors.dart';

class UserHeaderCard extends StatelessWidget {
  final String name;
  final String? subtitle;
  final String? imageUrl;
  final bool showSearch;
  final bool showVerifiedIcon;
  final String? searchRoute;

  final List<Student>? students;
  final int? selectedStudentIndex;
  final ValueChanged<int>? onStudentSelected;

  const UserHeaderCard({
    super.key,
    required this.name,
    this.subtitle,
    this.imageUrl,
    this.showSearch = false,
    this.showVerifiedIcon = false,
    this.searchRoute,
    this.students,
    this.selectedStudentIndex,
    this.onStudentSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.strokeColor,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(12.r),
        color: theme.cardColor,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30.r,
            backgroundColor: theme.colorScheme.surfaceVariant,
            backgroundImage: imageUrl != null
                ? NetworkImage(imageUrl!)
                : const AssetImage('assets/images/download(1).jpg')
            as ImageProvider,
          ),

          SizedBox(width: 12.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: 6.w),
                    if (showVerifiedIcon)
                      SvgPicture.asset(
                        'assets/icons/true sign.svg',
                        width: 14.w,
                        height: 14.h,
                      ),
                  ],
                ),
                SizedBox(height: 4.h),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
              ],
            ),
          ),

          if (showSearch && searchRoute != null)
            GestureDetector(
              onTap: () {
                context.push(searchRoute!);
              },
              child: Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.colorScheme.primary.withOpacity(0.1),
                ),
                child: SvgPicture.asset(
                  'assets/icons/search.svg',
                  width: 22.w,
                  height: 22.h,
                  colorFilter: ColorFilter.mode(
                    theme.colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}