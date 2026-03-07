import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../theme/app_colors.dart';

class AppPerformanceIndicator extends StatelessWidget {
  final double percentage; // من 0 لـ 100
  final String title;
  final String? footerText;
  final VoidCallback? onTap;

  const AppPerformanceIndicator({
    super.key,
    required this.percentage,
    required this.title,
    this.footerText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ✅ لون الـ progress حسب النسبة
    final progressColor =
    percentage < 50 ? AppColors.red : AppColors.strokeColor;

    // ✅ لون النسبة جوه الدايرة حسب الثيم
    final percentageTextColor =
        theme.textTheme.titleMedium?.color;
    final normalizedPercent =
        (percentage.clamp(0, 100)) / 100;

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ================= Title =================
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 12.h),

          // ================= Gauge =================
          CircularPercentIndicator(
            radius: 80.r,
            lineWidth: 15.w,
            percent: normalizedPercent,
            animation: true,
            animationDuration: 1000,
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: progressColor,
            /*backgroundColor:
            theme.colorScheme.outline.withOpacity(0.3),*/
            backgroundColor: theme.colorScheme.surfaceVariant,
            center: Text(
              "${percentage.toInt()}%",
              style: theme.textTheme.headlineMedium?.copyWith(
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
                color: percentageTextColor,
              ),
            ),
            arcType: ArcType.HALF,
            /*arcBackgroundColor:
            theme.colorScheme.outline.withOpacity(0.15),*/
            arcBackgroundColor: theme.colorScheme.surfaceVariant.withOpacity(0.7),
          ),

          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}