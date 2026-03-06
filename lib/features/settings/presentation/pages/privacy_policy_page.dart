import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/widgets/app_main_appbar.dart';


class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(

      /// AppBar
      appBar: const AppMainAppBar(
        title: "Privacy Policy",
        showBackButton: true,
      ),

      /// Body
      body: SingleChildScrollView(

        padding: EdgeInsets.all(16.w),

        child: Container(

          padding: EdgeInsets.all(16.w),

          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(12.r),

            border: Border.all(
              color: isDark
                  ? Colors.white12
                  : Colors.grey.shade300,
            ),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Title
              Text(
                "Privacy Policy",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.sp,
                ),
              ),

              SizedBox(height: 12.h),

              Text(
                "Last updated: March 2026",
                style: theme.textTheme.bodySmall,
              ),

              SizedBox(height: 20.h),

              /// Section 1
              Text(
                "1. Information We Collect",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: 8.h),

              Text(
                "Our application may collect basic information such as your name, profile image, and academic data to provide educational services and improve user experience.",
                style: theme.textTheme.bodyMedium,
              ),

              SizedBox(height: 16.h),

              /// Section 2
              Text(
                "2. How We Use Your Information",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: 8.h),

              Text(
                "The collected information is used to provide application features such as messaging, attendance alerts, and personalized academic services.",
                style: theme.textTheme.bodyMedium,
              ),

              SizedBox(height: 16.h),

              /// Section 3
              Text(
                "3. Notifications",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: 8.h),

              Text(
                "Users can enable or disable notifications for messages and attendance alerts through the settings page.",
                style: theme.textTheme.bodyMedium,
              ),

              SizedBox(height: 16.h),

              /// Section 4
              Text(
                "4. Data Security",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: 8.h),

              Text(
                "We take reasonable measures to protect user information and ensure that personal data is handled securely.",
                style: theme.textTheme.bodyMedium,
              ),

              SizedBox(height: 16.h),

              /// Section 5
              Text(
                "5. Changes to This Policy",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: 8.h),

              Text(
                "This privacy policy may be updated from time to time. Users will be notified of any major changes through the application.",
                style: theme.textTheme.bodyMedium,
              ),

            ],
          ),
        ),
      ),
    );
  }
}