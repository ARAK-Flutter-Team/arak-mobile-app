/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../l10n/app_localizations.dart';
import '../../features/auth/presentation/providers/auth_providers.dart';
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
    final tr = AppLocalizations.of(context)!;

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
        final isMessages = item.route == '/chat';

        return ActionCard(
          title: item.title,
          iconPath: item.iconPath,
          showDot: isTasks && hasNewTasks,
          showNewLabel: isMessages && hasNewMessages,
          onTap: () async {
            if (isTasks) {
              await context.push('/teacher/tasks');
              await ref.read(notificationProvider.notifier).markTasksAsSeen();
            }
            else if (item.route == '/teacher-schedule') {
              final authState = ref.read(authProvider);
              if (authState.user == null) {
                context.push('/login');
                return;
              }
              final teacherId = authState.user!.id;
              context.go('/teacher-schedule', extra: teacherId);
            }
            else if (item.route == '/teacher/attendance') {
              const classId = "1";
              context.push('/teacher/attendance/$classId');
            }
            else if (isMessages) {
              await ref.read(notificationProvider.notifier).markMessagesAsSeen();
              final authState = ref.read(authProvider);
              final currentUserId = authState.user!.id.toString();
              context.push('/conversations', extra: currentUserId);
            }
            else if (item.route != null) {
              context.push(item.route!, extra: item.extra);
            }
          },
        );
      },
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/providers/auth_providers.dart';
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
        final isMessages = item.route == '/chat';

        return ActionCard(
          title: item.title,
          iconPath: item.iconPath,
          showDot: isTasks && hasNewTasks,
          showNewLabel: isMessages && hasNewMessages,
          onTap: () async {
            if (isTasks) {
              await context.push('/teacher/tasks');
              if (onTasksOpened != null) onTasksOpened();
            }
            else if (item.route == '/teacher-schedule') {
              final authState = ref.read(authProvider);
              if (authState.user == null) {
                context.push('/login');
                return;
              }
              final teacherId = authState.user!.id;
              context.go('/teacher-schedule', extra: teacherId);
            }
            else if (item.route == '/teacher/attendance') {
              const classId = "1";
              context.push('/teacher/attendance/$classId');
            }
            else if (isMessages) {
              final authState = ref.read(authProvider);
              final currentUserId = authState.user!.id.toString();
              context.push('/conversations', extra: currentUserId);
            }
            else if (item.route != null) {
              context.push(item.route!, extra: item.extra);
            }
          },
        );
      },
    );
  }
}