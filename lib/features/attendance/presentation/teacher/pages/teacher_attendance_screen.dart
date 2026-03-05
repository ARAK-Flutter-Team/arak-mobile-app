/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../shared/widgets/app_main_appbar.dart';
import '../../../../../shared/widgets/app_snackbar.dart';
import '../../../../../shared/widgets/app_dropdown.dart';
import '../../../../../shared/widgets/app_dropdown_session.dart';
import '../../../domain/entities/attendance_record.dart';
import '../providers/teacher_attendance_provider.dart';
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

  final List<String> classes = [
    "Class 1",
    "Class 2",
    "Class 3",
  ];

  @override
  void initState() {
    super.initState();

    selectedClass = classes.contains(widget.classId)
        ? widget.classId
        : classes.first;

    Future.microtask(() {
      ref
          .read(teacherAttendanceNotifierProvider.notifier)
          .load(selectedClass, selectedSession);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(teacherAttendanceNotifierProvider);
    final notifier = ref.read(teacherAttendanceNotifierProvider.notifier);

    return Scaffold(
      appBar: const AppMainAppBar(
        title: "Attendance",
      ),
      body:  Stack(
          children: [

            /// المحتوى
            state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
              children: [

                const SizedBox(height: 16),

                /// Row للدروب داون
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [

                      SizedBox(
                        width: 150,
                        child: AppDropdown(
                          selectedClass: selectedClass,
                          classes: classes,
                          onChanged: (value) async {
                            setState(() {
                              selectedClass = value;
                            });

                            await notifier.load(
                              selectedClass,
                              selectedSession,
                            );
                          },
                        ),
                      ),

                      const SizedBox(width: 12),

                      SizedBox(
                        width: 150,
                        child: AppDropdownSession(
                          selectedSession: selectedSession,
                          onChanged: (session) async {
                            setState(() {
                              selectedSession = session!;
                            });

                            await notifier.load(
                              selectedClass,
                              selectedSession,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                /// نسبة الحضور
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AttendancePercentageHeader(
                    percentage: state.attendancePercentage,
                  ),
                ),

                const SizedBox(height: 16),

                /// قائمة الطلاب
                Expanded(
                  child: AttendanceList(
                    records: state.records,
                    onToggle: notifier.toggleStatus,
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

                  if (context.mounted) {
                    AppSnackBar.show(
                      context,
                      message: success
                          ? "Attendance saved successfully"
                          : "Failed to save attendance",
                      type: success
                          ? AppSnackBarType.success
                          : AppSnackBarType.error,
                    );
                  }
                },
              ),
            ),
          ],
        ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../shared/widgets/app_main_appbar.dart';
import '../../../../../shared/widgets/app_snackbar.dart';
import '../../../../../shared/widgets/app_dropdown.dart';
import '../../../../../shared/widgets/app_dropdown_session.dart';
import '../../../domain/entities/attendance_record.dart';
import '../providers/teacher_attendance_provider.dart';
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

  final List<String> classes = [
    "Class 1",
    "Class 2",
    "Class 3",
  ];

  @override
  void initState() {
    super.initState();

    selectedClass = classes.contains(widget.classId)
        ? widget.classId
        : classes.first;

    Future.microtask(() {
      ref
          .read(teacherAttendanceNotifierProvider.notifier)
          .load(selectedClass, selectedSession);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(teacherAttendanceNotifierProvider);
    final notifier = ref.read(teacherAttendanceNotifierProvider.notifier);

    return Scaffold(
      appBar: const AppMainAppBar(
        title: "Attendance",
      ),
      body: Stack(
        children: [

          /// المحتوى
          state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
            children: [

              const SizedBox(height: 16),

              /// Row للدروب داون
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [

                    /// Dropdown الكلاس (أقصى اليسار)
                    SizedBox(
                      width: 150,
                      child: AppDropdown(
                        selectedClass: selectedClass,
                        classes: classes,
                        onChanged: (value) async {
                          setState(() {
                            selectedClass = value;
                          });

                          await notifier.load(
                            selectedClass,
                            selectedSession,
                          );
                        },
                      ),
                    ),

                    /// المسافة الذكية
                    const Spacer(),

                    /// Dropdown السيشن (أقصى اليمين)
                    SizedBox(
                      width: 150,
                      child: AppDropdownSession(
                        selectedSession: selectedSession,
                        onChanged: (session) async {
                          setState(() {
                            selectedSession = session!;
                          });

                          await notifier.load(
                            selectedClass,
                            selectedSession,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// نسبة الحضور
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: AttendancePercentageHeader(
                  percentage: state.attendancePercentage,
                ),
              ),

              const SizedBox(height: 16),

              /// قائمة الطلاب
              Expanded(
                child: AttendanceList(
                  records: state.records,
                  onToggle: notifier.toggleStatus,
                ),
              ),

              const SizedBox(height: 80),
            ],
          ),

          /// زر الحفظ
          Positioned(
            bottom: 16,
            left: 20,
            right: 20,
            child: AttendanceSaveButton(
              onPressed: () async {
                final success = await notifier.save();

                if (context.mounted) {
                  AppSnackBar.show(
                    context,
                    message: success
                        ? "Attendance saved successfully"
                        : "Failed to save attendance",
                    type: success
                        ? AppSnackBarType.success
                        : AppSnackBarType.error,
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