import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/providers/auth_notifier.dart';
import '../../features/messages/domain/entities/chat_user.dart';
import '../../features/messages/domain/entities/message.dart';
import '../../features/messages/domain/enums/message_status.dart';
import '../../features/messages/domain/enums/message_type.dart';
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
            }
            else if (item.route == '/teacher/attendance') {
              final classId = "1";

              context.push('/teacher/attendance/$classId');
            }
            else if (isMessages) {

              final authState = ref.read(authProvider);
              final currentUser = authState.user!;

              final users = [
                ChatUser(
                  id: "2",
                  name: "Ahmed Ali",
                  role: "parent",
                  avatarUrl: "https://i.pravatar.cc/150?img=3",
                  status: UserStatus.online, // <-- صح هنا
                ),
                ChatUser(
                  id: "3",
                  name: "Sara Mohamed",
                  role: "parent",
                  avatarUrl: "https://i.pravatar.cc/150?img=5",
                  status: UserStatus.offline, // <-- صح هنا
                ),
              ];

              final message = Message(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                senderId: currentUser.id.toString(),
                receiverId: users.first.id,
                text: "Hello!",
                fileUrl: null,
                type: MessageType.text,
                status: MessageStatus.sending, // لازم
                createdAt: DateTime.now(),
                deletedForEveryone: false,
              );

              context.push(
                '/chat-users',
                extra: {
                  "currentUserId": currentUser.id.toString(),
                  "users": users,
                },
              );
            }
            else if (item.route != null) {
              context.push(item.route!);
            }
          },
        );
      },
    );
  }
}