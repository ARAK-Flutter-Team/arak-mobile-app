/*import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/theme/app_colors.dart';
import '../../domain/entities/teacher_home_entity.dart';
import '../providers/teacher_home_provider.dart';

class TeacherHeader extends ConsumerWidget {
  final bool showSearch;
  final bool showTrueSign;

  const TeacherHeader({
    super.key,
    this.showSearch = true,
    this.showTrueSign = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ✅ ناخد بيانات المعلم من الـ FutureProvider
    final teacherHomeAsync = ref.watch(teacherHomeProvider);

    return teacherHomeAsync.when(
      data: (teacherData) {
        return _buildHeader(context, teacherData);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text('Error: $err')),
    );
  }

  Widget _buildHeader(BuildContext context, TeacherHomeEntity teacherData) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.stroke(context), // ديناميكي حسب الثيم
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(12.r),
        color: theme.cardColor, // ديناميكي حسب الثيم
      ),
      child: Row(
        children: [
          // 1️⃣ صورة المعلم
          CircleAvatar(
            radius: 30.r,
            backgroundImage: const AssetImage(
              'assets/images/download.jpg',
            ),
          ),
          SizedBox(width: 12.w),

          // 2️⃣ الاسم والمادة
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      teacherData.teacherName,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    if (showTrueSign)
                      SvgPicture.asset(
                        'assets/icons/true sign.svg',
                        width: 14.w,
                        height: 14.h,
                        color: theme.iconTheme.color, // يدعم الدارك مود
                      ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  teacherData.subjectName,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: theme.textTheme.bodySmall?.color,
                  ),
                ),
              ],
            ),
          ),

          // 3️⃣ زر البحث
          if (showSearch)
            GestureDetector(
              onTap: () {
                GoRouter.of(context).push('/search');
              },
              child: Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary(context), // ديناميكي حسب الثيم
                ),
                child: SvgPicture.asset(
                  'assets/icons/search.svg',
                  width: 35.w,
                  height: 35.h,
                  color: Colors.white, // اللون ثابت لأيقونة البحث
                ),
              ),
            ),
        ],
      ),
    );
  }
}*/