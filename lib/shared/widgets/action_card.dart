/*import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActionCard extends StatelessWidget {
  final String title;
  final String iconPath;
  final bool showDot;
  final bool showNewLabel;
  final VoidCallback onTap;

  const ActionCard({
    super.key,
    required this.title,
    required this.iconPath,
    required this.onTap,
    this.showDot = false,
    this.showNewLabel = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14.r),
        onTap: onTap,
        child: Container(
          height: 60.h,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(14.r),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.shadow.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (iconPath.isNotEmpty)
                      SvgPicture.asset(
                        iconPath,
                        width: 20.w,
                        height: 20.w,
                        colorFilter: ColorFilter.mode(
                          theme.colorScheme.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                    SizedBox(width: 8.w),
                    Text(
                      title,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              if (showDot)
                Positioned(
                  top: -4,
                  right: -4,
                  child: Container(
                    width: 8.w,
                    height: 8.w,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.error,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              if (showNewLabel)
                Positioned(
                  top: 5,
                  right: -6,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      "NEW",
                      style: TextStyle(
                        fontSize: 8.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}*/
// lib/shared/widgets/action_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActionCard extends StatelessWidget {
  final String title;
  final String iconPath;
  final bool showDot;
  final bool showNewLabel;
  final VoidCallback onTap;

  const ActionCard({
    super.key,
    required this.title,
    required this.iconPath,
    this.showDot = false,
    this.showNewLabel = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
        ),
        child: Stack(
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    iconPath,
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      theme.colorScheme.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            if (showDot)
              Positioned(
                top: 8,
                right: isRtl ? null : 8,
                left: isRtl ? 8 : null,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            if (showNewLabel)
              Positioned(
                top: 4,
                right: isRtl ? null : 4,
                left: isRtl ? 4 : null,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'NEW',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}