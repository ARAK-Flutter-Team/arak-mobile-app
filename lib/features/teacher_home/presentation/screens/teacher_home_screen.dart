/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../shared/providers/current_user_provider.dart';
import '../../../../shared/widgets/app_main_appbar.dart';
import '../../../../shared/widgets/performance_indicator.dart';
import '../../../../shared/widgets/quick_action_grid.dart';
import '../../../../shared/widgets/recent_activities_section.dart';
import '../../../../shared/widgets/user_header_card.dart';
import '../../../notification_indicator/presentation/providers/notification_indicator_notifier.dart';
import '../providers/recent_activities_provider.dart';
import '../providers/teacher_home_provider.dart';
import '../../../../shared/providers/quick_actions_provider.dart';

class TeacherHomeScreen extends ConsumerWidget {
  const TeacherHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final performanceAsync = ref.watch(teacherPerformanceProvider);
    final notificationState = ref.watch(notificationProvider);
    final user = ref.watch(currentUserProvider);
    final quickActions = ref.watch(quickActionsProvider);

    /// لو المستخدم لسه بيحمل
    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      /// ✅ AppBar
      appBar: AppMainAppBar(
        title: AppLocalizations.of(context)!.welcome(user.name),
        showBackButton: false,
      ),

      /// ✅ Body
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(teacherPerformanceProvider);
            ref.invalidate(recentActivitiesProvider);
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// 1️⃣ User Header
                UserHeaderCard(
                  name: user.name,
                  subtitle: user.subject ?? "",
                  imageUrl: user.avatarUrl,
                  showSearch: true,
                  showVerifiedIcon: true,
                  searchRoute: '/teacher-search',
                ),

                SizedBox(height: 30.h),

                /// 2️⃣ Performance
                performanceAsync.when(
                  loading: () =>
                  const Center(child: CircularProgressIndicator()),
                  error: (_, __) => const SizedBox(),
                  data: (percentage) => AppPerformanceIndicator(
                    percentage: percentage,
                    title: AppLocalizations.of(context)!.teacherPerformance,
                  ),
                ),

                SizedBox(height: 24.h),

                /// 3️⃣ Quick Actions
                QuickActionsGrid(
                  items: quickActions,
                  hasNewTasks: false,
                  hasNewMessages: notificationState.hasNewMessages,
                  onTasksOpened: () async {
                    await context.push('/teacher/tasks');
                  },
                ),

                SizedBox(height: 24.h),

                /// 4️⃣ Recent Activities
                const RecentActivitiesSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}*/
// lib/features/teacher_home/presentation/screens/teacher_home_screen.dart

// lib/features/teacher_home/presentation/screens/teacher_home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/app_main_appbar.dart';
import '../../../../shared/widgets/quick_action_grid.dart';
import '../../../../shared/widgets/user_header_card.dart';
import '../../../../shared/widgets/performance_indicator.dart';
import '../../../../shared/models/quick_action_item.dart';
import '../providers/teacher_home_provider.dart';

class TeacherHomeScreen extends ConsumerWidget {
  const TeacherHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teacherDataAsync = ref.watch(teacherHomeProvider);
    final tr = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      // ✅ AppBar بيستخدم welcome مع name كـ parameter
      appBar: AppMainAppBar(
        title: teacherDataAsync.when(
          data: (teacherData) => tr.welcome(teacherData.teacherName),  // ✅ Welcome Ms. Maria / مرحباً Ms. Maria
          loading: () => tr.welcome(''),  // ✅ Welcome / مرحباً
          error: (_, __) => tr.welcome(''),  // ✅ Welcome / مرحباً
        ),
        showBackButton: false,
      ),

      body: teacherDataAsync.when(
        loading: () => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              SizedBox(height: 16.h),
              Text(tr.loading),
            ],
          ),
        ),
        error: (error, stack) => SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 48.sp, color: Colors.red),
                  SizedBox(height: 16.h),
                  Text(
                    tr.error,
                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    error.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                  ),
                  SizedBox(height: 24.h),
                  ElevatedButton(
                    onPressed: () => ref.invalidate(teacherHomeProvider),
                    child: Text(tr.retry),
                  ),
                ],
              ),
            ),
          ),
        ),
        data: (teacherData) {
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(teacherHomeProvider);
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User Header Card
                  UserHeaderCard(
                    name: teacherData.teacherName,
                    subtitle: teacherData.subject,
                    imageUrl: null,
                    showSearch: true,
                    showVerifiedIcon: true,
                    searchRoute: '/teacher-search',
                  ),

                  SizedBox(height: 30.h),

                  // Performance Indicator
                  AppPerformanceIndicator(
                    percentage: teacherData.performance,
                    title: tr.teacherPerformance,
                  ),

                  SizedBox(height: 24.h),

                  // Today Classes Card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.2),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tr.todayClasses,  // ✅ من الترجمة
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              '${teacherData.todayClassesCount}',
                              style: TextStyle(
                                fontSize: 28.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(
                            Icons.calendar_today,
                            size: 32.sp,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // Assigned Classes Card
                  if (teacherData.assignedClasses.isNotEmpty) ...[
                    Text(
                      tr.assignedClasses,  // ✅ من الترجمة
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      ),
                      child: Wrap(
                        spacing: 12.w,
                        runSpacing: 12.h,
                        children: teacherData.assignedClasses.map((className) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              className,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],

                  // Quick Actions Grid
                  QuickActionsGrid(
                    hasNewTasks: false,
                    hasNewMessages: false,
                    onTasksOpened: () async {
                      await context.push('/teacher/tasks');
                    },
                    items: [
                      QuickActionItem(
                        title: tr.tasks,
                        iconPath: "assets/icons/tasks.svg",
                        route: "/teacher/tasks",
                      ),
                      QuickActionItem(
                        title: tr.schedule,
                        iconPath: "assets/icons/schedule.svg",
                        route: "/teacher-schedule",
                      ),
                      QuickActionItem(
                        title: tr.attendance,
                        iconPath: "assets/icons/attendance.svg",
                        route: "/teacher/attendance",
                      ),
                      QuickActionItem(
                        title: tr.messages,
                        iconPath: "assets/icons/messages.svg",
                        route: "/chat",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}