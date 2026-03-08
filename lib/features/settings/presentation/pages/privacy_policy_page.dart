import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/widgets/app_main_appbar.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [

          /// AppBar
          const AppMainAppBar(
            title: "Privacy Policy",
            showBackButton: true,
          ),

          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// Description
                  Text(
                    "Your privacy is important to us. This policy explains how we collect and use your information.",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      height: 1.5,
                      color:
                      theme.textTheme.bodyMedium?.color?.withOpacity(.7),
                    ),
                  ),

                  SizedBox(height: 25.h),

                  _buildSection(
                    context,
                    icon: Icons.person_outline,
                    title: "Information We Collect",
                    description:
                    "We may collect basic information such as your name, profile image and academic data to provide educational services.",
                  ),

                  _buildDivider(context),

                  _buildSection(
                    context,
                    icon: Icons.settings_outlined,
                    title: "How We Use Your Information",
                    description:
                    "The collected data is used to provide features like messaging, attendance alerts and personalized academic services.",
                  ),

                  _buildDivider(context),

                  _buildSection(
                    context,
                    icon: Icons.notifications_none,
                    title: "Notifications",
                    description:
                    "Users can control message and attendance notifications through the settings page.",
                  ),

                  _buildDivider(context),

                  _buildSection(
                    context,
                    icon: Icons.security_outlined,
                    title: "Data Security",
                    description:
                    "We take appropriate measures to ensure that user information remains protected and secure.",
                  ),

                  _buildDivider(context),

                  _buildSection(
                    context,
                    icon: Icons.update,
                    title: "Policy Updates",
                    description:
                    "This privacy policy may change occasionally and users will be notified through the application.",
                  ),

                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String description,
      }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// Icon Circle
          Container(
            width: 42.w,
            height: 42.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDark
                  ? theme.colorScheme.primary.withOpacity(.25)
                  : theme.colorScheme.primary.withOpacity(.12),
            ),
            child: Icon(
              icon,
              size: 20.sp,
              color: theme.colorScheme.primary,
            ),
          ),

          SizedBox(width: 14.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 6.h),

                Text(
                  description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    height: 1.5,
                    color:
                    theme.textTheme.bodyMedium?.color?.withOpacity(.75),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Divider(
        thickness: 1,
        color: isDark ? Colors.white10 : const Color(0xffE5E7EB),
      ),
    );
  }
}