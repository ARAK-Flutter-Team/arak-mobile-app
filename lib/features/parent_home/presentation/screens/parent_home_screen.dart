import 'package:arak_app/shared/domain/entities/student.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/models/quick_action_item.dart';
import '../../../../shared/widgets/app_main_appbar.dart';
import '../../../../shared/widgets/quick_action_grid.dart';
import '../../../../shared/widgets/user_header_card.dart';
import '../../../notification_indicator/presentation/providers/notification_indicator_notifier.dart';
import 'widgets/parent_recent_activities_section.dart';
import '../providers/parent_home_provider.dart';
import 'package:arak_app/shared/providers/current_user_provider.dart';

class ParentHomeScreen extends ConsumerWidget {
  const ParentHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeAsync = ref.watch(parentHomeProvider);
    final selectedIndex = ref.watch(selectedStudentIndexProvider);
    final selectedStudent = ref.watch(selectedStudentProvider);
    final notificationAsync = ref.watch(notificationProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Colors.white,
      appBar: AppMainAppBar(
        title: "Welcome ${ref.watch(currentUserProvider)?.name ?? ''}!",
        showBackButton: false,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(parentHomeProvider);
            ref.invalidate(parentRecentActivitiesProvider);
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(16.w), // ✅
            child: Column(
              children: [
                homeAsync.when(
                  loading: () => const SizedBox(),
                  error: (_, __) => const SizedBox(),
                  data: (data) => UserHeaderCard(
                    name: selectedStudent?.name ?? '',
                    subtitle: selectedStudent?.parentUsername,
                    imageUrl: selectedStudent?.profileImage,
                    showSearch: true,
                    searchRoute: "/search",
                    showVerifiedIcon: selectedStudent?.isVerified ?? false,
                    students: data.students
                        .map((s) => Student(
                              id: s.id,
                              name: s.name,
                              avatarUrl: s.profileImage,
                            ))
                        .toList(),
                    selectedStudentIndex: selectedIndex,
                    onStudentSelected: (i) => ref
                        .read(selectedStudentIndexProvider.notifier)
                        .state = i,
                  ),
                ),

                SizedBox(height: 16.h), // ✅

                homeAsync.when(
                  loading: () => const CircularProgressIndicator(),
                  error: (_, __) => const SizedBox(),
                  data: (data) => _SwipeableStudentCard(
                    students: data.students,
                    selectedIndex: selectedIndex,
                    onPageChanged: (i) => ref
                        .read(selectedStudentIndexProvider.notifier)
                        .state = i,
                  ),
                ),

                SizedBox(height: 24.h), // ✅

                notificationAsync.when(
                  loading: () => const SizedBox(),
                  error: (_, __) => const SizedBox(),
                  data: (state) => QuickActionsGrid(
                    items: _buildQuickActions(),
                    hasNewTasks: state.hasNewTasks,
                    hasNewMessages: state.hasNewMessages,
                    onTasksOpened: () async {
                      await context.push(
                        '/parent-home/tasks',
                        extra: selectedStudent?.id ?? '',
                      );
                      await ref
                          .read(notificationProvider.notifier)
                          .markTasksAsSeen();
                    },
                  ),
                ),

                SizedBox(height: 24.h), // ✅

                const ParentRecentActivitiesSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<QuickActionItem> _buildQuickActions() => [
        QuickActionItem(
          title: "Tasks",
          route: '/parent-home/tasks',
          iconPath: 'assets/icons/tasks.svg',
        ),
        QuickActionItem(
          title: "Evaluation",
          route: '/parent-home/evaluation',
          iconPath: 'assets/icons/star.svg',
        ),
        QuickActionItem(
          title: "Schedule",
          route: '/parent-home/schedule',
          iconPath: 'assets/icons/schedule.svg',
        ),
        QuickActionItem(
          title: "Contact us",
          route: '/parent-home/contact',
          iconPath: 'assets/icons/contact.svg',
        ),
        QuickActionItem(
          title: "Attendance",
          route: '/parent-home/attendance',
          iconPath: 'assets/icons/attendance.svg',
        ),
        QuickActionItem(
          title: "Fox chatbot",
          iconPath: 'assets/icons/chatbot.svg',
          route: '/parent-home/chatbot',
        ),
      ];
}

// ── Swipeable Student Card ────────────────────────────────────
class _SwipeableStudentCard extends StatefulWidget {
  final List students;
  final int selectedIndex;
  final void Function(int) onPageChanged;

  const _SwipeableStudentCard({
    required this.students,
    required this.selectedIndex,
    required this.onPageChanged,
  });

  @override
  State<_SwipeableStudentCard> createState() => _SwipeableStudentCardState();
}

class _SwipeableStudentCardState extends State<_SwipeableStudentCard> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.selectedIndex);
  }

  @override
  void didUpdateWidget(_SwipeableStudentCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _pageController.animateToPage(
        widget.selectedIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        // Dots
        if (widget.students.length > 1) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.students.length, (i) {
              final isSelected = i == widget.selectedIndex;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 4.w), // ✅
                width: isSelected ? 16.w : 8.w, // ✅
                height: 8.h, // ✅
                decoration: BoxDecoration(
                  color: isSelected
                      ? theme.colorScheme.primary
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4.r), // ✅
                ),
              );
            }),
          ),
          SizedBox(height: 12.h), // ✅
        ],

        // Swipeable Cards
        SizedBox(
          height: 160.h, // ✅ الأهم
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.students.length,
            onPageChanged: widget.onPageChanged,
            itemBuilder: (context, i) {
              final student = widget.students[i];
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w), // ✅
                padding: EdgeInsets.all(16.w), // ✅
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(16.r), // ✅
                  border: Border.all(
                    color: theme.colorScheme.outline.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "student information",
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 12.h), // ✅
                    Text(
                      "Name: ${student.name}",
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text("Grade: ${student.grade}",
                        style: theme.textTheme.bodyMedium),
                    Text("Class: ${student.classNumber}",
                        style: theme.textTheme.bodyMedium),
                    SizedBox(height: 8.h), // ✅
                    GestureDetector(
                      onTap: () => context.push(
                        '/parent-home/student/${student.id}',
                      ),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "more",
                              style: TextStyle(
                                color: theme.colorScheme.primary,
                                fontSize: 12.sp, // ✅
                              ),
                            ),
                            SizedBox(width: 2.w), // ✅
                            Icon(
                              Icons.arrow_forward,
                              size: 14.sp, // ✅
                              color: theme.colorScheme.primary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
