import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/app_dropdown.dart';
import '../../../../shared/widgets/app_main_appbar.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../providers/providers.dart';
import '../providers/teacher_tasks_notifier.dart';
import '../widgets/task_item_card.dart';
import '../widgets/add_task_button.dart';

class TeacherTasksScreen extends ConsumerStatefulWidget {
  const TeacherTasksScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<TeacherTasksScreen> createState() =>
      _TeacherTasksScreenState();
}

class _TeacherTasksScreenState extends ConsumerState<TeacherTasksScreen> {
  bool _initialLoadDone = false;

  @override
  void initState() {
    super.initState();
    print(' TEACHER TASKS SCREEN INITSTATE ');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print(' PostFrameCallback triggered');
      _loadInitialData();
    });
  }

  Future<void> _loadInitialData() async {
    print(' LOAD INITIAL DATA STARTED ');
    if (_initialLoadDone) {
      print(' Initial load already done, skipping');
      return;
    }
    _initialLoadDone = true;

    final teacherId = ref.read(currentTeacherIdProvider);
    print(' Teacher ID from provider: $teacherId');

    if (teacherId == 0) {
      print(' Teacher ID is 0, aborting');
      return;
    }

    try {
      print(' Calling teacherClassesProvider.future...');
      final classes = await ref.read(teacherClassesProvider.future);
      print(' Classes loaded: $classes');
      print(' Classes type: ${classes.runtimeType}');
      print(' Classes length: ${classes.length}');

      if (classes.isNotEmpty) {
        print(' First class string: "${classes.first}"');
        final firstClassId = int.tryParse(classes.first) ?? 0;
        print(' First class ID (int): $firstClassId');

        if (firstClassId != 0) {
          print(' Calling fetchTasks with teacherId: $teacherId, classId: $firstClassId');
          await ref.read(teacherTasksNotifierProvider.notifier).fetchTasks(
            teacherId: teacherId,
            classId: firstClassId,
          );
          print(' fetchTasks completed successfully');
        } else {
          print(' First class ID parsed to 0');
        }
      } else {
        print(' Classes list is EMPTY');
      }
    } catch (e) {
      print(' Error loading initial data: $e');
      print(' Stack trace: ${StackTrace.current}');
    }
    print(' LOAD INITIAL DATA ENDED ');
  }

  @override
  Widget build(BuildContext context) {
    print(' TEACHER TASKS SCREEN BUILD ');
    final teacherId = ref.watch(currentTeacherIdProvider);
    final classesAsync = ref.watch(teacherClassesProvider);
    final tasksState = ref.watch(teacherTasksNotifierProvider);
    final notifier = ref.read(teacherTasksNotifierProvider.notifier);
    final loc = AppLocalizations.of(context)!;

    print(' Build - teacherId: $teacherId');
    print(' Build - tasksState.isLoading: ${tasksState.isLoading}');
    print(' Build - tasksState.tasks.length: ${tasksState.tasks.length}');
    print(' Build - tasksState.selectedClass: ${tasksState.selectedClass}');
    print(' Build - tasksState.error: ${tasksState.error}');

    if (teacherId == 0) {
      print(' teacherId is 0, showing loading indicator');
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppMainAppBar(title: loc.tasks),
      body: Column(
        children: [
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  loc.selectClass,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: classesAsync.when(
                    loading: () {
                      print(' Classes loading...');
                      return const Center(child: CircularProgressIndicator());
                    },
                    error: (e, _) {
                      print(' Classes error: $e');
                      return Text(
                        'Error: $e',
                        style: const TextStyle(color: Colors.red),
                      );
                    },
                    data: (classes) {
                      print(' Classes data received: $classes');
                      if (classes.isEmpty) {
                        print(' Classes list is empty');
                        return Text(
                          loc.noClassesAvailable,
                          style: const TextStyle(color: Colors.red),
                        );
                      }

                      String selectedValue = tasksState.selectedClass.toString();
                      print(' Selected value from state: "$selectedValue"');

                      if (selectedValue == '0' || !classes.contains(selectedValue)) {
                        if (classes.isNotEmpty) {
                          selectedValue = classes.first;
                          print(' Changed selectedValue to first class: "$selectedValue"');
                        }
                      }

                      print(' Final selectedValue for dropdown: "$selectedValue"');

                      return AppDropdown(
                        selectedClass: selectedValue,
                        classes: classes,
                        width: double.infinity,
                        height: 50,
                        onChanged: (val) {
                          print(' Dropdown onChanged: "$val"');
                          if (val.isNotEmpty) {
                            final classId = int.tryParse(val) ?? 0;
                            print(' Parsed classId: $classId');
                            if (classId != 0) {
                              notifier.changeClass(
                                teacherId: teacherId,
                                newClassId: classId,
                              );
                            }
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Builder(
                builder: (_) {
                  print(' Builder - tasksState.isLoading: ${tasksState.isLoading}');

                  if (tasksState.isLoading) {
                    print(' Showing loading indicator');
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (tasksState.error != null) {
                    print(' Showing error: ${tasksState.error}');
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error_outline, size: 48, color: Colors.red.shade300),
                          const SizedBox(height: 12),
                          Text(
                            tasksState.error!,
                            style: const TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () async {
                              print(' Retry button pressed');
                              final currentClass = tasksState.selectedClass;
                              if (currentClass != 0 && teacherId != 0) {
                                await notifier.fetchTasks(
                                  teacherId: teacherId,
                                  classId: currentClass,
                                );
                              } else if (classesAsync.hasValue && classesAsync.value!.isNotEmpty) {
                                final firstClassId = int.tryParse(classesAsync.value!.first) ?? 0;
                                if (firstClassId != 0) {
                                  await notifier.fetchTasks(
                                    teacherId: teacherId,
                                    classId: firstClassId,
                                  );
                                }
                              }
                            },
                            child: Text(loc.tryAgain),
                          ),
                        ],
                      ),
                    );
                  }

                  if (tasksState.tasks.isEmpty) {
                    print(' No tasks found, showing empty state');
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.assignment_turned_in, size: 48, color: Colors.grey.shade400),
                          const SizedBox(height: 12),
                          Text(
                            loc.noTasksFound,
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    );
                  }

                  print(' Showing ${tasksState.tasks.length} tasks');
                  return RefreshIndicator(
                    onRefresh: () async {
                      print(' Refresh indicator triggered');
                      final currentClass = tasksState.selectedClass;
                      if (currentClass != 0 && teacherId != 0) {
                        await notifier.fetchTasks(
                          teacherId: teacherId,
                          classId: currentClass,
                        );
                      }
                    },
                    child: ListView.builder(
                      itemCount: tasksState.tasks.length,
                      itemBuilder: (_, i) {
                        print(' Building task item ${i + 1}: ${tasksState.tasks[i].title}');
                        return TaskItemCard(task: tasksState.tasks[i]);
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: AddTaskButton(
          onPressed: () async {
            print(' FAB ONPRESSED TRIGGERED ');
            print(' Current teacherId: $teacherId');
            print(' Current selectedClass: ${tasksState.selectedClass}');
            print(' Navigating to /teacher/add-task...');

            try {
              final result = await context.push('/teacher/add-task');
              print(' Navigation returned with result: $result');

              if (result == true) {
                print(' Result is true, refreshing tasks');
                final currentClass = tasksState.selectedClass;
                if (currentClass != 0 && teacherId != 0) {
                  await notifier.fetchTasks(
                    teacherId: teacherId,
                    classId: currentClass,
                  );
                  print(' Tasks refreshed after adding');
                }
              } else {
                print(' Result is false or null, not refreshing');
              }
            } catch (e) {
              print(' Error during navigation: $e');
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}