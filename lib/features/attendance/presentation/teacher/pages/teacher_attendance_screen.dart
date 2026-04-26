import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../../shared/widgets/app_main_appbar.dart';
import '../../../../../shared/widgets/app_snackbar.dart';
import '../../../../../shared/widgets/app_dropdown.dart';
import '../../../../../shared/widgets/app_dropdown_session.dart';
import '../../../domain/entities/attendance_record.dart';
import '../providers/teacher_attendance_provider.dart';
import '../providers/class_provider.dart';
import '../widgets/attendance_list.dart';
import '../widgets/attendance_percentage_header.dart';
import '../widgets/attendance_save_button.dart';

class TeacherAttendanceScreen extends ConsumerStatefulWidget {
  final String classId;

  const TeacherAttendanceScreen({
    super.key,
    required this.classId,
  });

  @override
  ConsumerState<TeacherAttendanceScreen> createState() =>
      _TeacherAttendanceScreenState();
}

class _TeacherAttendanceScreenState
    extends ConsumerState<TeacherAttendanceScreen> {

  late String selectedClass;
  AttendanceSession selectedSession = AttendanceSession.morning;

  List<ClassEntity> classes = [];
  bool isLoadingClasses = true;

  @override
  void initState() {
    super.initState();
    _loadClasses();
  }

  Future<void> _loadClasses() async {
    try {
      final getClassesUseCase = ref.read(getClassesUseCaseProvider);
      final fetchedClasses = await getClassesUseCase();

      if (mounted) {
        setState(() {
          classes = fetchedClasses;
          isLoadingClasses = false;

          if (classes.isNotEmpty) {
            if (classes.any((c) => c.id.toString() == widget.classId)) {
              selectedClass = widget.classId;
            } else {
              selectedClass = classes.first.id.toString();
            }
          }
        });

        if (classes.isNotEmpty && mounted) {
          _loadAttendance();
        }
      }
    } catch (e) {
      print(" Error loading classes: $e");
      if (mounted) {
        setState(() {
          isLoadingClasses = false;
        });
      }
    }
  }

  void _loadAttendance() {
    ref
        .read(teacherAttendanceNotifierProvider.notifier)
        .load(selectedClass, selectedSession);
  }

  String getClassName(ClassEntity classObj) {
    return classObj.name;
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(teacherAttendanceNotifierProvider);
    final notifier = ref.read(teacherAttendanceNotifierProvider.notifier);
    final loc = AppLocalizations.of(context)!;

    if (isLoadingClasses) {
      return Scaffold(
        appBar: AppMainAppBar(
          title: loc.attendance,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (classes.isEmpty) {
      return Scaffold(
        appBar: AppMainAppBar(
          title: loc.attendance,
        ),
        body: Center(
          child: Text(
            loc.noClassesFound,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      );
    }

    final currentClass = classes.firstWhere(
          (c) => c.id.toString() == selectedClass,
      orElse: () => classes.first,
    );

    final classMap = {
      for (var c in classes) c.name: c.id.toString()
    };

    return Scaffold(
      appBar: AppMainAppBar(
        title: loc.attendance,
      ),
      body: Stack(
        children: [
          if (state.isLoading)
            const Center(child: CircularProgressIndicator())
          else
            Column(
              children: [
                const SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: AppDropdown(
                          selectedClass: currentClass.name,
                          classes: classMap.keys.toList(),
                          onChanged: (value) async {
                            final selectedId = classMap[value];
                            if (selectedId != null) {
                              setState(() {
                                selectedClass = selectedId;
                              });
                              await notifier.load(selectedClass, selectedSession);
                            }
                          },
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 150,
                        child: AppDropdownSession(
                          selectedSession: selectedSession,
                          onChanged: (session) async {
                            setState(() {
                              selectedSession = session!;
                            });
                            await notifier.load(selectedClass, selectedSession);
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AttendancePercentageHeader(
                    percentage: state.attendancePercentage,
                  ),
                ),

                const SizedBox(height: 16),

                Expanded(
                  child: AttendanceList(
                    records: state.records,
                    onToggle: (studentId) => notifier.toggleStatus(studentId),
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),

          Positioned(
            bottom: 16,
            left: 20,
            right: 20,
            child: AttendanceSaveButton(
              onPressed: () async {
                final success = await notifier.save();
                if (mounted) {
                  AppSnackBar.show(
                    context,
                    message: success
                        ? loc.attendanceSavedSuccessfully
                        : loc.failedToSaveAttendance,
                    type: success ? AppSnackBarType.success : AppSnackBarType.error,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}