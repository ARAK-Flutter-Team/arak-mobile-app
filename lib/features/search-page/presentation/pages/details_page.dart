import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/app_main_appbar.dart';
import '../providers/student_provider.dart';
import '../../domain/entities/student.dart';

class DetailsPage extends ConsumerWidget {
  final String studentName;

  const DetailsPage({super.key, required this.studentName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentAsync = ref.watch(studentListProvider);

    return studentAsync.when(
      data: (studentList) {
        final student = studentList.firstWhere((s) => s.name == studentName);
        final theme = Theme.of(context);

        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: AppMainAppBar(
            title: student.name,
            centerTitle: false,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0.w),
              child: Column(
                children: [
                  _buildHeaderCard(context, theme, student),
                  SizedBox(height: 20.h),
                  _buildTimeRow(context, theme, student),
                  SizedBox(height: 20.h),
                  _buildAttendanceCircle(context, theme, student),
                ],
              ),
            ),
          ),
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) => Scaffold(
        body: Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildHeaderCard(
      BuildContext context, ThemeData theme, Student student) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: theme.brightness == Brightness.dark
                ? Colors.black.withOpacity(0.25)
                : Colors.black12,
            blurRadius: 6,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            student.name,
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: theme.textTheme.bodyLarge?.color,
            ),
            overflow: TextOverflow.ellipsis, // ✅ fix 1
            maxLines: 1,
          ),
          SizedBox(height: 5.h),
          Text(
            student.grade,
            style: TextStyle(
              fontSize: 16.sp,
              color: theme.textTheme.bodyMedium?.color,
            ),
            overflow: TextOverflow.ellipsis, // ✅ fix 2
            maxLines: 1,
          ),
          Divider(height: 30.h, color: theme.dividerColor),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                // ✅ fix 3 — Expanded على التاريخ
                child: Text(
                  student.date,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              SizedBox(width: 8.w), // ✅ فاصلة بين التاريخ والـ Badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: _getStatusColor(student.status).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  _getLocalizedStatus(l10n, student.status),
                  style: TextStyle(
                    color: _getStatusColor(student.status),
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp, // ✅ خفضنا شوية علشان ميطلعش من الـ badge
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeRow(BuildContext context, ThemeData theme, Student student) {
    final l10n = AppLocalizations.of(context)!;

    return Row(
      children: [
        Expanded(
          child: _timeBox(
            icon: Icons.login,
            label: l10n.checkIn,
            time: student.checkIn,
            color: Colors.green,
            theme: theme,
          ),
        ),
        SizedBox(width: 15.w),
        Expanded(
          child: _timeBox(
            icon: Icons.logout,
            label: l10n.checkOut,
            time: student.checkOut,
            color: Colors.red,
            theme: theme,
          ),
        ),
      ],
    );
  }

  Widget _timeBox({
    required IconData icon,
    required String label,
    required String time,
    required Color color,
    required ThemeData theme,
  }) {
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark
            ? color.withOpacity(0.15)
            : color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24.sp),
          SizedBox(width: 10.w),
          Expanded(
            // ✅ fix 4 — أهم تعديل — Expanded على الـ Column
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: theme.textTheme.bodySmall?.color,
                    fontSize: 12.sp,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceCircle(
      BuildContext context, ThemeData theme, Student student) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 80.w,
                height: 80.w, // ✅ fix 5 — .w بدل .h للحفاظ على الاستدارة
                child: CircularProgressIndicator(
                  value: student.attendanceRate / 100,
                  strokeWidth: 8,
                  backgroundColor: theme.brightness == Brightness.dark
                      ? Colors.grey[800]
                      : Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    theme.colorScheme.primary,
                  ),
                ),
              ),
              Text(
                "${student.attendanceRate}%",
                style: TextStyle(
                  fontSize: 16
                      .sp, // ✅ fix 6 — من 20.sp لـ 16.sp علشان متطلعش من الدايرة
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),
            ],
          ),
          SizedBox(width: 20.w),
          Expanded(
            // ✅ fix 7 — Expanded على الـ Column
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.attendanceRate,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                SizedBox(height: 5.h),
                Text(
                  l10n.overallPerformance,
                  style: TextStyle(
                    color: theme.textTheme.bodySmall?.color,
                    fontSize: 12.sp,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getLocalizedStatus(AppLocalizations l10n, String status) {
    switch (status) {
      case 'Present':
        return l10n.present;
      case 'Absent':
        return l10n.absent;
      case 'Late':
        return l10n.late;
      default:
        return status;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Present':
        return Colors.green;
      case 'Absent':
        return Colors.red;
      case 'Late':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
