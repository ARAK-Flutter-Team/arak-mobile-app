import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../shared/theme/app_colors.dart';
import '../../../../../shared/widgets/recent_activity_item.dart';
import '../../providers/parent_home_provider.dart';

class ParentRecentActivitiesSection extends ConsumerWidget {
  const ParentRecentActivitiesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activitiesAsync = ref.watch(parentRecentActivitiesProvider);
    final theme = Theme.of(context);

    return activitiesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const SizedBox(),
      data: (activities) {
        if (activities.isEmpty) return const SizedBox();
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.strokeColor, width: 0.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Recent Activities",
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              ...activities.map(
                (activity) => Column(children: [
                  RecentActivityItem(
                    iconPath: activity.iconPath,
                    text: activity.title,
                    keepOriginalIconColor: activity.keepOriginalIconColor,
                    onTap: activity.route != null
                        ? () => context.push(activity.route!)
                        : null,
                  ),
                  if (activity != activities.last) const SizedBox(height: 8),
                ]),
              ),
            ],
          ),
        );
      },
    );
  }
}
