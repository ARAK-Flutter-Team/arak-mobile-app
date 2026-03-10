import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RecentActivityItem extends StatelessWidget {
  final String iconPath;
  final String text;
  final bool keepOriginalIconColor;
  final VoidCallback? onTap;

  const RecentActivityItem({
    super.key,
    required this.iconPath,
    required this.text,
    this.keepOriginalIconColor = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(10.r),
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h),
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath,
              width: 18.w,
              height: 18.w,
              colorFilter: keepOriginalIconColor
                  ? null
                  : ColorFilter.mode(
                theme.colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),

            SizedBox(width: 12.w),

            Expanded(
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}