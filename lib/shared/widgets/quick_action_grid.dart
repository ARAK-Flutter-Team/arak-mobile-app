/*import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/quick_action_item.dart';
import 'action_card.dart';

class QuickActionsGrid extends StatelessWidget {
  final List<QuickActionItem> items;
  final bool hasNewTasks;
  final bool hasNewMessages;
  final VoidCallback onTasksOpened;

  const QuickActionsGrid({
    super.key,
    required this.items,
    required this.hasNewTasks,
    required this.hasNewMessages,
    required this.onTasksOpened,
  });

  @override
  Widget build(BuildContext context) {
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

        final isTasks = item.route == '/teacher/tasks';
        final isMessages = item.route == '/messages';

        return ActionCard(
          title: item.title,
          iconPath: item.iconPath,
          showDot: isTasks && hasNewTasks,
          showNewLabel: isMessages && hasNewMessages,
          onTap: () {
            context.push(item.route);

            if (isTasks) {
              onTasksOpened();
            }
          },
        );
      },
    );
  }
}*/
// lib/features/home/widgets/quick_actions_grid.dart
/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/providers/auth_notifier.dart';
import '../../features/notification_indicator/presentation/providers/notification_indicator_notifier.dart';
import '../providers/quick_actions_provider.dart';
import 'action_card.dart';

class QuickActionsGrid extends ConsumerWidget {
  final bool hasNewTasks;
  final bool hasNewMessages;
  final VoidCallback onTasksOpened;
  final List<QuickActionItem> items;

  const QuickActionsGrid(
      {super.key,
      required this.hasNewTasks,
      required this.hasNewMessages,
      required this.onTasksOpened,
      required this.items});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(quickActionsProvider);

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

        final isTasks = item.route == '/teacher/tasks';
        final isMessages = item.route == '/messages';

        return ActionCard(
          title: item.title,
          iconPath: item.iconPath,
          showDot: isTasks && hasNewTasks,
          showNewLabel: isMessages && hasNewMessages,
          onTap: () async {
            if (isTasks) {
              await context.push('/teacher/tasks');

<<<<<<< HEAD
              await ref
                  .read(notificationProvider.notifier)
                  .markTasksAsSeen();
            }

            else if (item.route == '/teacher-schedule') {
              final authState = ref.watch(authProvider);

              if (authState.user == null) {
                context.push('/login');
                return;
              }

              final teacherId = authState.user!.id;

              context.go(
                '/teacher-schedule',
                extra: teacherId,
              );
            }

            else {
              context.push(item.route);
=======
              await ref.read(notificationProvider.notifier).markTasksAsSeen();
            } else {
              context.push(item.route ?? '');
>>>>>>> 7734e542e199f01f7e702f68b4187187710e6508
            }
          },
         /* onTap: () async {
            if (isTasks) {
              await context.push('/teacher/tasks');

              await ref
                  .read(notificationProvider.notifier)
                  .markTasksAsSeen();
            } else {
              context.push(item.route);
            }
          },*/
        );
      },
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/providers/auth_notifier.dart';
import '../../features/notification_indicator/presentation/providers/notification_indicator_notifier.dart';
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

        final isTasks = item.route == '/teacher/tasks';
        final isMessages = item.route == '/messages';

        return ActionCard(
          title: item.title,
          iconPath: item.iconPath,
          showDot: isTasks && hasNewTasks,
          showNewLabel: isMessages && hasNewMessages,
          onTap: () async {
            if (isTasks) {
              await context.push('/teacher/tasks');
              await ref
                  .read(notificationProvider.notifier)
                  .markTasksAsSeen();
            } else if (item.route == '/teacher-schedule') {
              final authState = ref.read(authProvider);

              if (authState.user == null) {
                context.push('/login');
                return;
              }

              final teacherId = authState.user!.id;

              context.go(
                '/teacher-schedule',
                extra: teacherId,
              );
            } else if (item.route != null) {
              context.push(item.route!);
            }
          },
        );
      },
    );
  }
}