import 'package:arak_app/shared/domain/entities/student.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/models/quick_action_item.dart';
import '../../../../shared/widgets/app_main_appbar.dart';
import '../../../../shared/widgets/quick_action_grid.dart';
import '../../../../shared/widgets/user_header_card.dart';
import '../../../notification_indicator/presentation/providers/notification_indicator_notifier.dart';
import '../../../notifications/presentation/providers/notifications_provider.dart'; // ✅ جديد
import '../providers/parent_home_provider.dart';
import 'package:arak_app/shared/providers/current_user_provider.dart';

class ParentHomeScreen extends ConsumerStatefulWidget {
  // ✅ تغيير
  const ParentHomeScreen({super.key});

  @override
  ConsumerState<ParentHomeScreen> createState() =>
      _ParentHomeScreenState(); // ✅ تغيير
}

class _ParentHomeScreenState extends ConsumerState<ParentHomeScreen> {
  // ✅ جديد

  @override
  void initState() {
    // ✅ جديد
    super.initState();
    Future.microtask(() async {
      try {
        final count = await ref.read(getUnreadCountUseCaseProvider).call();
        ref.read(unreadNotificationsProvider.notifier).state = count;
      } catch (_) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    // ✅ شلنا WidgetRef ref من هنا
    final l10n = AppLocalizations.of(context)!;
    final homeAsync = ref.watch(parentHomeProvider);
    final selectedIndex = ref.watch(selectedStudentIndexProvider);
    final selectedStudent = ref.watch(selectedStudentProvider);
    final notificationAsync = ref.watch(notificationProvider);
    final unreadCount = ref.watch(unreadNotificationsProvider); // ✅ جديد

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppMainAppBar(
        title: l10n.welcome(ref.watch(currentUserProvider)?.name ?? ''),
        showBackButton: false,
        actions: [
          // ✅ جديد
          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: Badge(
              isLabelVisible: unreadCount > 0,
              label: Text(
                unreadCount > 99 ? '99+' : unreadCount.toString(),
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.red,
              child: IconButton(
                icon: Icon(Icons.notifications_outlined, size: 24.sp),
                onPressed: () => context.push('/notifications'),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(parentHomeProvider);
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                homeAsync.when(
                  loading: () => const SizedBox(),
                  error: (_, __) => const SizedBox(),
                  data: (data) => UserHeaderCard(
                    name: selectedStudent?.name ?? '',
                    subtitle: selectedStudent?.parentUsername,
                    imageUrl: selectedStudent?.profileImage,
                    showSearch: false,
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
                SizedBox(height: 16.h),
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
                SizedBox(height: 24.h),
                QuickActionsGrid(
                  items: _buildQuickActions(selectedStudent?.id ?? '', l10n),
                  hasNewTasks: notificationAsync.hasNewTasks,
                  hasNewMessages: notificationAsync.hasNewMessages,
                  onTasksOpened: () async {
                    await context.push(
                      '/parent-home/tasks',
                      extra: selectedStudent?.id ?? '',
                    );
                  },
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<QuickActionItem> _buildQuickActions(
          String studentId, AppLocalizations l10n) =>
      [
        QuickActionItem(
          title: l10n.tasks,
          route: '/parent-home/tasks',
          iconPath: 'assets/icons/tasks.svg',
          extra: studentId,
        ),
        QuickActionItem(
          title: l10n.evaluation,
          route: '/parent-home/evaluation',
          iconPath: 'assets/icons/star.svg',
        ),
        QuickActionItem(
          title: l10n.schedule,
          route: '/parent-home/schedule',
          iconPath: 'assets/icons/schedule.svg',
        ),
        QuickActionItem(
          title: l10n.contactUs,
          route: '/parent-home/contact',
          iconPath: 'assets/icons/contact.svg',
        ),
        QuickActionItem(
          title: l10n.attendance,
          route: '/parent-home/attendance',
          iconPath: 'assets/icons/attendance.svg',
        ),
        QuickActionItem(
          title: l10n.foxChatbot,
          route: '/parent-home/chatbot',
          iconPath: 'assets/icons/chatbot.svg',
        ),
        QuickActionItem(
          title: l10n.messages,
          route: '/conversations',
          iconPath: 'assets/icons/messages.svg',
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
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        if (widget.students.length > 1) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.students.length, (i) {
              final isSelected = i == widget.selectedIndex;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                width: isSelected ? 16.w : 8.w,
                height: 8.h,
                decoration: BoxDecoration(
                  color: isSelected
                      ? theme.colorScheme.primary
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              );
            }),
          ),
          SizedBox(height: 12.h),
        ],
        SizedBox(
          height: 160.h,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.students.length,
            onPageChanged: widget.onPageChanged,
            itemBuilder: (context, i) {
              final student = widget.students[i];
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: theme.colorScheme.outline.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        l10n.studentInformation,
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "${l10n.studentName}: ${student.name}",
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${l10n.studentGrade}: ${student.grade}",
                      style: theme.textTheme.bodyMedium,
                    ),
                    Text(
                      "${l10n.classLabel}: ${student.classNumber}",
                      style: theme.textTheme.bodyMedium,
                    ),
                    SizedBox(height: 8.h),
                    GestureDetector(
                      onTap: () => context.push(
                        '/parent-home/student/${student.id}',
                      ),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              l10n.more,
                              style: TextStyle(
                                color: theme.colorScheme.primary,
                                fontSize: 12.sp,
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Icon(
                              Icons.arrow_forward,
                              size: 14.sp,
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
