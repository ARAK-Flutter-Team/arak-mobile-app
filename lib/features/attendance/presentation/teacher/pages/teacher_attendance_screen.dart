/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../shared/widgets/app_main_appbar.dart';
import '../../../../../shared/widgets/app_snackbar.dart';
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

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(teacherAttendanceNotifierProvider.notifier)
          .load(widget.classId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(teacherAttendanceNotifierProvider);
    final notifier =
    ref.read(teacherAttendanceNotifierProvider.notifier);

    return Scaffold(
      appBar: const AppMainAppBar(
        title: "Attendance",
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          const SizedBox(height: 16),

          AttendancePercentageHeader(
            percentage: state.attendancePercentage,
          ),

          const SizedBox(height: 24),

          Expanded(
            child: AttendanceList(
              records: state.records,
              onToggle: notifier.toggleStatus,
            ),
          ),

          AttendanceSaveButton(
            onPressed: () async {
              await notifier.save();

              if (context.mounted) {
                AppSnackBar.show(
                  context,
                  message: "Attendance saved successfully",
                  type: AppSnackBarType.success,
                );
              }
            },
          )
        ],
      ),
    );
  }
}*/
/*
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../shared/widgets/app_main_appbar.dart';
import '../../../../../shared/widgets/app_snackbar.dart';
import '../../../../../shared/widgets/app_dropdown.dart';
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
  // 🟢 State للكلاس المختار
  late String selectedClass= "";

  // 🟢 قائمة الكلاسات المتوفرة (ممكن تجي من الباك أو ثابتة مؤقت)
  final List<String> classes = [
    "Class 1",
    "Class 2",
    "Class 3",
  ];

  @override
  void initState() {
    super.initState();
    selectedClass = widget.classId;

    Future.microtask(() {
      ref
          .read(teacherAttendanceNotifierProvider.notifier)
          .load(selectedClass);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(teacherAttendanceNotifierProvider);
    final notifier =
    ref.read(teacherAttendanceNotifierProvider.notifier);

    return Scaffold(
      appBar: const AppMainAppBar(
        title: "Attendance",
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          const SizedBox(height: 16),

          // 🟢 Dropdown لاختيار الكلاس
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AppDropdown(
              selectedClass: selectedClass,
              classes: classes,
              onChanged: (value) async {
                setState(() {
                  selectedClass = value;
                });

                // 🔄 تحميل بيانات الكلاس الجديد
                await notifier.load(selectedClass);
              },
            ),
          ),

          const SizedBox(height: 16),

          // 🟢 نسبة الحضور
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AttendancePercentageHeader(
              percentage: state.attendancePercentage,
            ),
          ),

          const SizedBox(height: 24),

          // 🟢 قائمة الطلاب
          Expanded(
            child: AttendanceList(
              records: state.records,
              onToggle: notifier.toggleStatus,
            ),
          ),

          // 🟢 زر الحفظ
          AttendanceSaveButton(
            onPressed: () async {
              await notifier.save();

              if (context.mounted) {
                AppSnackBar.show(
                  context,
                  message: "Attendance saved successfully",
                  type: AppSnackBarType.success,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}*/
/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../shared/widgets/app_main_appbar.dart';
import '../../../../../shared/widgets/app_snackbar.dart';
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

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(teacherAttendanceNotifierProvider.notifier)
          .load(widget.classId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(teacherAttendanceNotifierProvider);
    final notifier =
    ref.read(teacherAttendanceNotifierProvider.notifier);

    return Scaffold(
      appBar: const AppMainAppBar(
        title: "Attendance",
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          const SizedBox(height: 16),

          AttendancePercentageHeader(
            percentage: state.attendancePercentage,
          ),

          const SizedBox(height: 24),

          Expanded(
            child: AttendanceList(
              records: state.records,
              onToggle: notifier.toggleStatus,
            ),
          ),

          AttendanceSaveButton(
            onPressed: () async {
              await notifier.save();

              if (context.mounted) {
                AppSnackBar.show(
                  context,
                  message: "Attendance saved successfully",
                  type: AppSnackBarType.success,
                );
              }
            },
          )
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

  // 🟢 State للكلاس المختار
  late String selectedClass;

  // 🟢 قائمة الكلاسات المتوفرة (ممكن تجي من الباك أو ثابتة مؤقت)
  final List<String> classes = [
    "Class 1",
    "Class 2",
    "Class 3",
  ];

  @override
  void initState() {
    super.initState();

    // ✅ تأكد إن selectedClass موجود في القائمة
    selectedClass = classes.contains(widget.classId)
        ? widget.classId
        : classes.first;

    Future.microtask(() {
      ref
          .read(teacherAttendanceNotifierProvider.notifier)
          .load(selectedClass);
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
      body: SafeArea(
        child: state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
          children: [
            const SizedBox(height: 16),

            // 🟢 Dropdown لاختيار الكلاس
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AppDropdown(
                selectedClass: selectedClass,
                classes: classes,
                onChanged: (value) async {
                  setState(() {
                    selectedClass = value;
                  });

                  // 🔄 تحميل بيانات الكلاس الجديد
                  await notifier.load(selectedClass);
                },
              ),
            ),

            const SizedBox(height: 16),

            // 🟢 نسبة الحضور
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AttendancePercentageHeader(
                percentage: state.attendancePercentage,
              ),
            ),

            const SizedBox(height: 16),

            // 🟢 قائمة الطلاب مع Expanded لتفادي overflow
            Expanded(
              child: AttendanceList(
                records: state.records,
                onToggle: notifier.toggleStatus,
              ),
            ),

            // 🟢 زر الحفظ
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 16),
              child: AttendanceSaveButton(
                onPressed: () async {
                  await notifier.save();

                  if (context.mounted) {
                    AppSnackBar.show(
                      context,
                      message: "Attendance saved successfully",
                      type: AppSnackBarType.success,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}