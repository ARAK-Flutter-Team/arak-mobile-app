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
      // خلفية متدرجة لطيفة تعطي طابعاً عصرياً للصفحة
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [
              const Color(0xFF121212), // لون داكن جداً
              const Color(0xFF1E1E2E), // لون مزرق داكن
            ]
                : [
              const Color(0xFFF5F7FA), // رمادي فاتح جداً
              const Color(0xFFC3CFE2), // لمسة زرقاء فاتحة
            ],
          ),
        ),
        child: Column(
          children: [
            // استخدام الـ AppBar المطلوب كما هو
            const AppMainAppBar(
              title: "Privacy Policy",
              showBackButton: true,
            ),

            // المحتوى القابل للتمرير
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Column(
                  children: [

                    // --- تصميم رأس البطاقة ---
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(24.w),
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(24.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // أيقونة كبيرة في الأعلى
                          Container(
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              // في الوضع الليلي نستخدم أبيض شفاف جداً بدلاً من اللون الأساسي الغامق
                              color: isDark
                                  ? Colors.white.withOpacity(0.1) // خلفية بيضاء باهتة في الدارك مود
                                  : theme.primaryColor.withOpacity(0.1), // اللون الأساسي في النورمال مود
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.policy_rounded,
                              size: 48.sp,
                              // نجعل لون الأيقونة أبيض في الوضع الليلي، ولون التطبيق الأساسي في الوضع العادي
                              color: isDark ? Colors.white : theme.primaryColor,
                            ),
                          ),

                          SizedBox(height: 20.h),

                          // العنوان الرئيسي
                          Text(
                            "Privacy Policy",
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurface,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(height: 12.h),

                          // شريط التاريخ (Chip)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? Colors.white12
                                  : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.update,
                                  size: 14.sp,
                                  color: theme.textTheme.bodySmall?.color,
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  "Last updated: March 2026",
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 24.h),

                          // --- الأقسام ---
                          _buildSection(
                            context: context,
                            icon: Icons.person_search_rounded,
                            iconColor: Colors.blue,
                            title: "1. Information We Collect",
                            description:
                            "Our application may collect basic information such as your name, profile image, and academic data to provide educational services and improve user experience.",
                          ),

                          _buildDivider(context),

                          _buildSection(
                            context: context,
                            icon: Icons.settings_suggest_rounded,
                            iconColor: Colors.purple,
                            title: "2. How We Use Your Information",
                            description:
                            "The collected information is used to provide application features such as messaging, attendance alerts, and personalized academic services.",
                          ),

                          _buildDivider(context),

                          _buildSection(
                            context: context,
                            icon: Icons.notifications_active_rounded,
                            iconColor: Colors.orange,
                            title: "3. Notifications",
                            description:
                            "Users can enable or disable notifications for messages and attendance alerts through the settings page.",
                          ),

                          _buildDivider(context),

                          _buildSection(
                            context: context,
                            icon: Icons.security_rounded,
                            iconColor: Colors.green,
                            title: "4. Data Security",
                            description:
                            "We take reasonable measures to protect user information and ensure that personal data is handled securely.",
                          ),

                          _buildDivider(context),

                          _buildSection(
                            context: context,
                            icon: Icons.sync_rounded,
                            iconColor: Colors.redAccent,
                            title: "5. Changes to This Policy",
                            description:
                            "This privacy policy may be updated from time to time. Users will be notified of any major changes through the application.",
                          ),

                          SizedBox(height: 10.h),

                          // زر أو نص تواصل في النهاية (اختياري)
                          TextButton.icon(
                            onPressed: () {},
                            icon: Icon(
                              Icons.headset_mic_rounded,
                              size: 18.sp,
                            ),
                            label: Text(
                              "Contact Support",
                              style: TextStyle(fontSize: 14.sp),
                            ),
                            style: TextButton.styleFrom(
                              foregroundColor: theme.colorScheme.primary,
                            ),
                          ),

                          SizedBox(height: 10.h),
                        ],
                      ),
                    ),

                    SizedBox(height: 40.h), // مسافة في الأسفل
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // دالة مساعدة لبناء الأقسام بشكل متكرر وجميل
  Widget _buildSection({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
  }) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // دائرة الأيقونة
          Container(
            margin: EdgeInsets.only(top: 4.h, right: 16.w),
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 22.sp,
            ),
          ),

          // النصوص
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    height: 1.5,
                    color: theme.textTheme.bodyMedium?.color?.withOpacity(0.8),
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // دالة لإنشاء فاصل جميل بين الأقسام
  Widget _buildDivider(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Divider(
        height: 1,
        thickness: 1,
        color: isDark ? Colors.white10 : Colors.grey.shade200,
        indent: 60.w, // إزاحة من اليسار لتكون تحت النص وليس تحت الأيقونة
        endIndent: 0,
      ),
    );
  }
}