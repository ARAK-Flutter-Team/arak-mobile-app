import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/app_main_appbar.dart';
import '../../../../shared/widgets/performance_indicator.dart';
import '../../../../shared/widgets/quick_action_grid.dart';
import '../../../../shared/widgets/recent_activities_section.dart';
import '../../../../shared/widgets/user_header_card.dart';
import '../../../notification_indicator/presentation/providers/notification_indicator_notifier.dart';
import '../providers/recent_activities_provider.dart';
import '../providers/teacher_home_provider.dart';

class TeacherHomeScreen extends ConsumerWidget {
  const TeacherHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final performanceAsync = ref.watch(teacherPerformanceProvider);
    final teacherAsync = ref.watch(teacherProfileProvider);
    final notificationAsync = ref.watch(notificationProvider);

    return teacherAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (_, __) =>
          const Scaffold(body: Center(child: Text("Error loading profile"))),
      data: (data) {
        // ✅ ناخد آخر قيمة بدون ما نخفي الواجهة
        final notificationState = notificationAsync.value;

        return Scaffold(
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Colors.white,
          appBar: AppMainAppBar(
            title: "Welcome ${data.teacherName}",
            showBackButton: false,
          ),
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(teacherPerformanceProvider);
                ref.invalidate(recentActivitiesProvider);
                ref.invalidate(teacherProfileProvider);
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 1️⃣ User Header
                    UserHeaderCard(
                      students: [],
                      name: data.teacherName,
                      subtitle: data.subjectName,
                      imageUrl: data.profileImage,
                      showSearch: true,
                      showVerifiedIcon: true,
                      searchRoute: '/teacher-search',
                      selectedStudentIndex: 0,
                      onStudentSelected: (int value) {},
                    ),

                    const SizedBox(height: 30),

                    /// 2️⃣ Performance
                    performanceAsync.when(
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (_, __) => const SizedBox(),
                      data: (percentage) => AppPerformanceIndicator(
                        percentage: percentage,
                        title: "Teacher Performance",
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// 3️⃣ Quick Actions (حل احترافي بدون اختفاء)
                    QuickActionsGrid(
                      items: [],
                      hasNewTasks: notificationState?.hasNewTasks ?? false,
                      hasNewMessages:
                          notificationState?.hasNewMessages ?? false,
                      onTasksOpened: () async {
                        await context.push('/teacher/tasks');

                        await ref
                            .read(notificationProvider.notifier)
                            .markTasksAsSeen();
                      },
                    ),

                    const SizedBox(height: 24),

                    /// 4️⃣ Recent Activities
                    const RecentActivitiesSection(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
