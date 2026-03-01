/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/quick_action_item.dart';
import 'action_card.dart';

class QuickActionsGrid extends ConsumerWidget {
  final List<QuickActionItem> items;

  const QuickActionsGrid({
    super.key,
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

        return ActionCard(
          title: item.title,
          iconPath: item.iconPath,
          showDot: item.showDot,
          showNewLabel: item.showNewLabel,
          onTap: () => context.push(item.route),
        );
      },
    );
  }
}*/
import 'package:flutter/material.dart';
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

        final isTasks = item.route == '/tasks';
        final isMessages = item.route == '/messages';

        return ActionCard(
          title: item.title,
          iconPath: item.iconPath,
          showDot: isTasks
              ? hasNewTasks
              : isMessages
              ? hasNewMessages
              : false,
          showNewLabel: isTasks
              ? hasNewTasks
              : isMessages
              ? hasNewMessages
              : false,
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
}