import 'package:arak_app/features/teacher_home/presentation/screens/teacher_quotes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../shared/models/quick_action_item.dart';
import '../../../../shared/widgets/app_main_appbar.dart';
import '../../../../shared/widgets/quick_action_grid.dart';
import '../../../../shared/widgets/user_header_card.dart';
import '../providers/teacher_home_provider.dart';

class TeacherHomeScreen extends ConsumerWidget {
  const TeacherHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teacherDataAsync = ref.watch(teacherHomeProvider);
    final tr = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppMainAppBar(
        title: teacherDataAsync.when(
          data: (teacherData) => tr.welcome(teacherData.teacherName),
          loading: () => tr.welcome(''),
          error: (_, __) => tr.welcome(''),
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
                  Icon(
                    Icons.error_outline,
                    size: 48.sp,
                    color: Colors.red,
                  ),

                  SizedBox(height: 16.h),

                  Text(
                    tr.error,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8.h),

                  Text(
                    error.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey,
                    ),
                  ),

                  SizedBox(height: 24.h),

                  ElevatedButton(
                    onPressed: () {
                      ref.invalidate(teacherHomeProvider);
                    },
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

              padding: EdgeInsets.symmetric(
                horizontal: 18.w,
                vertical: 14.h,
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  /// ─────────────────────────────
                  /// Teacher Header Card
                  /// ─────────────────────────────
                  UserHeaderCard(
                    name: teacherData.teacherName,
                    subtitle: teacherData.subject,
                    imageUrl: null,
                    showSearch: false,
                    showVerifiedIcon: true,
                    searchRoute: '/teacher-search',
                  ),

                  SizedBox(height: 55.h),

                  /// ─────────────────────────────
                  /// Quick Actions Grid
                  /// ─────────────────────────────
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),

                    child: QuickActionsGrid(
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
                          route: "/conversations",
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 50.h),

                  /// ─────────────────────────────
                  /// Quotes Section
                  /// ─────────────────────────────
                  const TeacherQuotesSection(),

                  SizedBox(height: 40.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}