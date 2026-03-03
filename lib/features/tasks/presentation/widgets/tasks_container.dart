
import 'package:arak_app/features/tasks/presentation/widgets/task_item_card.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/entities/task.dart';

class TasksContainer extends StatelessWidget {
  final List<Task> tasks;

  const TasksContainer({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        return TaskItemCard(task: tasks[index]);
      },
    );
  }
}