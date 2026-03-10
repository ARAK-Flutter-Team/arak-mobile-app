import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/student_provider.dart';
import '../../domain/entities/student.dart';

class DetailsPage extends ConsumerWidget {
  final String studentName; // الاسم الفريد للطالب

  const DetailsPage({super.key, required this.studentName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // نجيب بيانات الطلاب من provider
    final studentAsync = ref.watch(studentListProvider);

    return studentAsync.when(
      data: (studentList) {
        // بما إن مفيش ID، نستخدم الاسم الفريد
        final student = studentList.firstWhere((s) => s.name == studentName);

        final theme = Theme.of(context);

        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: AppBar(
            title: Text(student.name),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0.w),
              child: Column(
                children: [
                  _buildHeaderCard(theme, student),
                  SizedBox(height: 20.h),
                  _buildTimeRow(theme, student),
                  SizedBox(height: 20.h),
                  _buildAttendanceCircle(theme, student),
                ],
              ),
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }

  Widget _buildHeaderCard(ThemeData theme, Student student) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: theme.brightness == Brightness.dark
                ? Colors.black.withOpacity(0.2)
                : Colors.black12,
            blurRadius: 5,
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
          ),
          SizedBox(height: 5.h),
          Text(
            student.grade,
            style: TextStyle(
              fontSize: 16.sp,
              color: theme.textTheme.bodyMedium?.color,
            ),
          ),
          Divider(height: 30.h, color: theme.dividerColor),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(student.date,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: theme.textTheme.bodyMedium?.color,
                  )),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: _getStatusColor(student.status).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  student.status,
                  style: TextStyle(
                    color: _getStatusColor(student.status),
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeRow(ThemeData theme, Student student) {
    return Row(
      children: [
        Expanded(
          child: _timeBox(
            icon: Icons.login,
            label: "Check In",
            time: student.checkIn,
            color: Colors.green,
            theme: theme,
          ),
        ),
        SizedBox(width: 15.w),
        Expanded(
          child: _timeBox(
            icon: Icons.logout,
            label: "Check Out",
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
            ? color.withOpacity(0.1)
            : color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24.sp),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(
                      color: theme.textTheme.bodySmall?.color,
                      fontSize: 12.sp)),
              Text(
                time,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceCircle(ThemeData theme, Student student) {
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
                height: 80.h,
                child: CircularProgressIndicator(
                  value: student.attendanceRate / 100,
                  strokeWidth: 8,
                  backgroundColor: theme.brightness == Brightness.dark
                      ? Colors.grey[800]
                      : Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
                ),
              ),
              Text(
                "${student.attendanceRate}%",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),
            ],
          ),
          SizedBox(width: 20.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Attendance Rate",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: theme.textTheme.bodyLarge?.color,
                  )),
              SizedBox(height: 5.h),
              Text("Overall performance this month",
                  style: TextStyle(
                      color: theme.textTheme.bodySmall?.color,
                      fontSize: 12.sp)),
            ],
          )
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Present":
        return Colors.green;
      case "Absent":
        return Colors.red;
      case "Late":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
