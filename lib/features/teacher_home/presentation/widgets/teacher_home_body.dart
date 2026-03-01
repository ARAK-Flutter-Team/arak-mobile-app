/*import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/teacher_home_entity.dart';
import 'teacher_home_header_section.dart';
import 'teacher_home_actions_section.dart';
import 'teacher_home_activity_section.dart';

class TeacherHomeBody extends StatelessWidget {
  final TeacherHomeEntity data;

  const TeacherHomeBody({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = Theme.of(context).scaffoldBackgroundColor;

    return SafeArea(
      child: Column(
        children: [

          /// 1️⃣ AppBar + Header + Performance
          TeacherHomeHeaderSection(data: data),

          /// 2️⃣ باقي الصفحة Scrollable
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 15.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// Quick Actions
                  TeacherHomeActionsSection(data: data),

                  SizedBox(height: 30.h),

                  /// Recent Activities
                  TeacherHomeActivitySection(data: data),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}*/