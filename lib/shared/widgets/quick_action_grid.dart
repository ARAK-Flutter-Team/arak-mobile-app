/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/providers/auth_providers.dart';
import '../../features/messages/domain/entities/chat_user.dart';
import '../../features/messages/domain/enums/user_status.dart';
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
        final isMessages = item.route == '/chat';

        return ActionCard(
          title: item.title,
          iconPath: item.iconPath,
          showDot: isTasks && hasNewTasks,
          showNewLabel: isMessages && hasNewMessages,
          onTap: () async {
            /// ===== TASKS =====
            if (isTasks) {
              await context.push('/teacher/tasks');

              await ref.read(notificationProvider.notifier).markTasksAsSeen();
            }

            /// ===== SCHEDULE =====
            else if (item.route == '/teacher-schedule') {
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
            }

            /// ===== ATTENDANCE =====
            else if (item.route == '/teacher/attendance') {
              const classId = "1";
              context.push('/teacher/attendance/$classId');
            }

            /// ===== MESSAGES =====
            else if (isMessages) {
              /// إزالة NEW عند فتح الرسائل
              await ref
                  .read(notificationProvider.notifier)
                  .markMessagesAsSeen();

              final authState = ref.read(authProvider);
              final currentUser = authState.user!;

              final users = [
                ChatUser(
                  id: "2",
                  name: "Ahmed Ali",
                  role: "parent",
                  avatarUrl: "https://i.pravatar.cc/150?img=3",
                  status: UserStatus.online,
                ),
                ChatUser(
                  id: "3",
                  name: "Sara Mohamed",
                  role: "parent",
                  avatarUrl: "https://i.pravatar.cc/150?img=5",
                  status: UserStatus.offline,
                ),
              ];

              context.push(
                '/chat-users',
                extra: {
                  "currentUserId": currentUser.id.toString(),
                  "users": users,
                },
              );
            }

            /// ===== OTHER ROUTES =====
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

import '../../core/localization/app_localizations_extension.dart';
import '../../features/auth/presentation/providers/auth_providers.dart';
import '../../features/messages/domain/entities/chat_user.dart';
import '../../features/messages/domain/enums/user_status.dart';
import '../../features/notification_indicator/presentation/providers/notification_indicator_notifier.dart';

import '../../l10n/app_localizations.dart';
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
    final loc = AppLocalizations.of(context)!;

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
          title: loc.getString(item.title), // ✅ الترجمة شغالة هنا
          iconPath: item.iconPath,
          showDot: isTasks && hasNewTasks,
          showNewLabel: isMessages && hasNewMessages,
          onTap: () async {
            /// ===== TASKS =====
            if (isTasks) {
              await context.push('/teacher/tasks');
              await ref.read(notificationProvider.notifier).markTasksAsSeen();
            }

            /// ===== SCHEDULE =====
            else if (item.route == '/teacher-schedule') {
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
            }

            /// ===== ATTENDANCE =====
            else if (item.route == '/teacher/attendance') {
              const classId = "1";
              context.push('/teacher/attendance/$classId');
            }

            /// ===== MESSAGES =====
            else if (isMessages) {
              await ref
                  .read(notificationProvider.notifier)
                  .markMessagesAsSeen();

              final authState = ref.read(authProvider);
              final currentUser = authState.user!;

              final users = [
                ChatUser(
                  id: "2",
                  name: "Ahmed Mohammed",
                  role: "parent",
                  avatarUrl: "https://i.pravatar.cc/150?img=12",
                  status: UserStatus.online,
                ),
                ChatUser(
                  id: "3",
                  name: "Sara Mohamed",
                  role: "parent",
                  avatarUrl: "https://i.pravatar.cc/150?img=5",
                  status: UserStatus.offline,
                ),
              ];

              context.push(
                '/chat-users',
                extra: {
                  "currentUserId": currentUser.id.toString(),
                  "users": users,
                },
              );
            }

            /// ===== OTHER ROUTES =====
            else if (item.route != null) {
              context.push(item.route!, extra: item.extra);
            }
          },
        );
      },
    );
  }
}