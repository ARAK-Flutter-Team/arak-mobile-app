import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/task_status_remote_data_source_impl.dart';
import '../../data/repositoryImpl/task_status_repository_impl.dart';
import '../controller/task_status_notifier.dart';
import '../state/task_status_state.dart';

final taskStatusProvider =
StateNotifierProvider<TaskStatusNotifier, TaskStatusState>((ref) {

  final remote = TaskStatusRemoteDataSourceImpl();

  final repository = TaskStatusRepositoryImpl(remote);

  return TaskStatusNotifier(repository);
});