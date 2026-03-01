/*import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/teacher_home_entity.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/teacher_header.dart';
import '../widgets/performance_gauge.dart';
import '../widgets/custom_card.dart';

class TeacherHomeHeaderSection extends StatelessWidget {
  final TeacherHomeEntity data;

  const TeacherHomeHeaderSection({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor = Theme.of(context).cardColor;

    return Column(
      children: [

        /// ✅ نفس الـ AppBar القديم
        CustomAppBar(
          title: "Welcome ${data.teacherName} !",
          showBackButton: false,
        ),

        /// باقي الهيدر Scrollable محتاج Padding
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [

              /// Teacher Header (الصورة + الاسم + المادة)
              TeacherHeader(
                teacherName: data.teacherName,
                subjectName: data.subjectName,
              ),

              SizedBox(height: 10.h),

              /// Performance Gauge داخل Card
              CustomCard(
                backgroundColor: cardColor,
                child: PerformanceGauge(
                  percentage: data.performance ?? 0,
                ),
              ),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ],
    );
  }
}*/