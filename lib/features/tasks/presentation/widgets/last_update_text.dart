import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../providers/teacher_tasks_notifier.dart';

class LastUpdateText extends ConsumerWidget {
  const LastUpdateText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lastUpdated =
        ref.watch(teacherTasksNotifierProvider).lastUpdated;

    if (lastUpdated == null) {
      return const SizedBox.shrink();
    }

    final formattedTime =
    DateFormat('hh:mm a').format(lastUpdated);

    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Last update: $formattedTime',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}