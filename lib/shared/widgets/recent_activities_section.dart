import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../features/teacher_home/presentation/providers/recent_activities_provider.dart';
import '../theme/app_colors.dart';
import 'recent_activity_item.dart';

class RecentActivitiesSection extends ConsumerWidget {
  const RecentActivitiesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activitiesAsync = ref.watch(recentActivitiesProvider);
    final theme = Theme.of(context);

    return activitiesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => const SizedBox(),
      data: (activities) {
        if (activities.isEmpty) return const SizedBox();

        return Container(
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.strokeColor,
              width: 0.5.w,
            ),
            boxShadow: [
              if (theme.brightness == Brightness.light)
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6.r,
                  offset: const Offset(0, 2),
                ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Recent Activities",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
               SizedBox(height: 12.h),

              ...activities.map((activity) => Column(
                children: [
                  RecentActivityItem(
                    iconPath: activity.iconPath,
                    text: activity.title,
                    keepOriginalIconColor:
                    activity.keepOriginalIconColor,
                    onTap: activity.route != null
                        ? () => context.push(activity.route!)
                        : null,
                  ),
                  if (activity != activities.last)
                     SizedBox(height: 8.h),
                ],
              )),
            ],
          ),
        );
      },
    );
  }
}