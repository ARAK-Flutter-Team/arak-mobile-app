import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:arak_app/features/auth/presentation/providers/auth_providers.dart';
import '../models/quick_action_item.dart';
import 'action_card.dart';

class QuickActionsGrid extends ConsumerWidget {
  final bool hasNewTasks;
  final bool hasNewMessages;
  final VoidCallback onTasksOpened;
  final List<QuickActionItem> items;

  const QuickActionsGrid({
    super.key,
    required this.hasNewTasks,
    required this.hasNewMessages,
    required this.onTasksOpened,
    required this.items,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 2.6,
      ),
      itemBuilder: (context, index) {
        final item = items[index];

        final isTasks = item.route == '/teacher/tasks' || item.route == '/parent-home/tasks';
        final isMessages = item.route == '/conversations' || item.route == '/chat';

        return ActionCard(
          title: item.title,
          iconPath: item.iconPath,
          iconData: item.iconData,
          showDot: isTasks && hasNewTasks,
          showNewLabel: isMessages && hasNewMessages,
          onTap: () {
            if (isTasks && onTasksOpened != null) {
              onTasksOpened();
              return;
            }

            if (item.route == '/conversations') {
              final user = ref.read(authProvider).user;
              context.push(item.route!, extra: user?.id ?? '');
            } else if (item.route != null) {
              context.push(item.route!, extra: item.extra);
            }
          },
        );
      },
    );
  }
}