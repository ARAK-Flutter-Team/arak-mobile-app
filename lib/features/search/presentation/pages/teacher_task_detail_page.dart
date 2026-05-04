import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/widgets/app_main_appbar.dart';

class TeacherTaskDetailPage extends ConsumerWidget {
  final String taskId;

  const TeacherTaskDetailPage({super.key, required this.taskId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Ideally we would have a provider to fetch a single task by ID.
    // For now, we'll try to find it in the teacher's tasks or show a simple placeholder
    // since the user asked for a "minimal" page.
    
    return Scaffold(
      appBar: AppMainAppBar(
        title: "Task Details",
        showBackButton: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.assignment, size: 64, color: Theme.of(context).primaryColor),
            const SizedBox(height: 16),
            Text(
              "Task ID: $taskId",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text("Additional task details will be displayed here."),
          ],
        ),
      ),
    );
  }
}
