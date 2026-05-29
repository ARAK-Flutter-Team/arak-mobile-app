import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:arak_app/features/evaluation/presentation/pages/evaluation_page.dart';
import 'package:arak_app/features/parent_attendance/presentation/pages/attendance_page.dart';
import 'package:arak_app/features/attendance/presentation/teacher/pages/teacher_attendance_screen.dart';
import 'package:arak_app/core/entities/user.dart';
import 'package:arak_app/features/auth/presentation/providers/auth_providers.dart';
import 'package:arak_app/features/messages/presentation/screens/chat_screen.dart';
import 'package:arak_app/features/messages/presentation/screens/conversations_list_screen.dart';
import 'package:arak_app/features/notifications/presentation/pages/notifications_page.dart';
import 'package:arak_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:arak_app/features/contact_page/presentation/pages/contact_page.dart';
import 'package:arak_app/features/schedule/presentation/pages/teacher_schedule_page.dart';
import 'package:arak_app/features/schedule-of-student/presentation/pages/schedule_screen.dart';
import 'package:arak_app/features/search/presentation/pages/teacher_search_page.dart';
import 'package:arak_app/features/settings/presentation/pages/privacy_policy_page.dart';
import 'package:arak_app/features/settings/presentation/pages/settings_page.dart';
import 'package:arak_app/features/splash/presentation/screens/splash_screen.dart';
import 'package:arak_app/features/auth/presentation/screens/login_screen.dart';
import 'package:arak_app/core/router/main_shell.dart';
import 'package:arak_app/features/search-page/presentation/pages/search_page.dart';
import 'package:arak_app/features/tasks/presentation/pages/add_task_page.dart';
import 'package:arak_app/features/tasks/presentation/pages/teacher_tasks_page.dart';
import 'package:arak_app/features/teacher_home/presentation/screens/teacher_home_screen.dart';
import 'package:arak_app/features/parent_home/presentation/screens/parent_home_screen.dart';
import 'package:arak_app/features/parent_home/presentation/providers/parent_home_provider.dart';
import 'package:arak_app/features/tasks/presentation/pages/parent_tasks_page.dart';
import 'package:arak_app/features/tasks/presentation/pages/parent_task_details_page.dart';
import 'package:arak_app/features/tasks/domain/entities/task.dart';
import 'package:arak_app/features/search-page/presentation/pages/details_page.dart';
import 'package:arak_app/features/search-page/domain/entities/student.dart';
import 'package:arak_app/features/task_status/presentation/screens/task_status_screen.dart';
import 'package:arak_app/features/parent_home/presentation/screens/student_details_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/teacher-search',
        name: 'teacher-search',
        builder: (context, state) => const TeacherSearchPage(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return MainShell(child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            name: 'home',
            builder: (context, state) {
              return Consumer(
                builder: (context, ref, _) {
                  final authState = ref.watch(authProvider);
                  final role = authState.user?.role;
                  if (role == UserRole.teacher)
                    return const TeacherHomeScreen();
                  if (role == UserRole.parent) return const ParentHomeScreen();
                  return const Scaffold(
                    body: Center(child: Text("Loading...")),
                  );
                },
              );
            },
          ),
          /*GoRoute(
            path: '/parent-home/tasks',
            name: 'parent-tasks',
            builder: (context, state) {
              final studentId = state.extra?.toString() ??
                  ref.read(selectedStudentProvider)?.id ??
                  '';
              return ParentTasksPage(studentId: studentId);
            },
            routes: [
              GoRoute(
                path: 'details',
                name: 'parent-task-details',
                builder: (context, state) {
                  final task = state.extra as Task;
                  return ParentTaskDetailsPage(task: task);
                },
              ),
            ],
          ),*/
          GoRoute(
            path: '/parent-home/tasks',
            name: 'parent-tasks',
            builder: (context, state) {

              final studentId = state.extra as String? ?? '';

              return ParentTasksPage(
                studentId: studentId,
              );
            },

            routes: [
              GoRoute(
                path: 'details',
                name: 'parent-task-details',
                builder: (context, state) {

                  final task = state.extra as Task;

                  return ParentTaskDetailsPage(
                    task: task,
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: '/parent-home/student/:studentId',
            name: 'parent-student-details',
            builder: (context, state) {
              final studentId = state.pathParameters['studentId'] ?? '';
              return StudentDetailsScreen(studentId: studentId);
            },
          ),
          GoRoute(
            path: '/parent-home/evaluation',
            name: 'parent-evaluation',
            builder: (context, state) => const StudentEvaluationPage(),
          ),
          GoRoute(
            path: '/parent-home/schedule',
            name: 'parent-schedule',
            builder: (context, state) => const ScheduleScreen(),
          ),
          GoRoute(
            path: '/parent-home/contact',
            name: 'parent-contact',
            builder: (context, state) => const ContactPage(),
          ),
          GoRoute(
            path: '/parent-home/attendance',
            name: 'parent-attendance',
            builder: (context, state) => const AttendancePage(),
          ),
          GoRoute(
            path: '/parent-home/chatbot',
            name: 'parent-chatbot',
            builder: (context, state) => const Placeholder(),
          ),
          GoRoute(
            path: '/search',
            name: 'search',
            builder: (context, state) => const SearchPage(),
          ),
          GoRoute(
            path: '/student-details',
            name: 'student-details',
            builder: (context, state) {
              final student = state.extra as Student;
              return DetailsPage(studentName: student.name);
            },
          ),
          GoRoute(
            path: '/contact',
            name: 'contact',
            builder: (context, state) => const ContactPage(),
          ),
          GoRoute(
            path: '/profile',
            name: 'profile',
            builder: (context, state) => const ProfileScreen(),
          ),
          GoRoute(
            path: '/notifications',
            name: 'notifications',
            builder: (context, state) => const NotificationsPage(),
          ),
          GoRoute(
            path: '/evaluation',
            name: 'evaluation',
            builder: (context, state) => const StudentEvaluationPage(),
          ),
          GoRoute(
            path: '/settings',
            name: 'settings',
            builder: (context, state) => const SettingsPage(),
          ),
          GoRoute(
            path: '/settings/privacy-policy',
            name: 'privacy-policy',
            builder: (context, state) => const PrivacyPolicyPage(),
          ),
          GoRoute(
            path: '/teacher/tasks',
            name: 'teacher-tasks',
            builder: (context, state) => const TeacherTasksScreen(),
          ),

          // Step 4: Missing routes for search results
          GoRoute(
            path: '/teacher/task-status',
            name: 'teacher-task-status',
            builder: (context, state) {
              final task = state.extra as Task;
              return TaskStatusScreen(task: task);
            },
          ),
          GoRoute(
            path: '/teacher/student-details',
            name: 'teacher-student-details',
            builder: (context, state) {
              final student = state.extra as Student;
              return DetailsPage(studentName: student.name);
            },
          ),

          GoRoute(
            path: '/teacher/add-task',
            name: 'teacher-add-task',
            builder: (context, state) => const AddTaskPage(),
          ),
          GoRoute(
            path: '/teacher-schedule',
            name: 'teacher-schedule',
            builder: (context, state) => const TeacherSchedulePage(),
          ),
          GoRoute(
            path: '/student-schedule',
            name: 'student-schedule',
            builder: (context, state) => const ScheduleScreen(),
          ),
          GoRoute(
            path: '/teacher/attendance',
            name: 'teacher-attendance',
            builder: (context, state) {
              return const TeacherAttendanceScreen(classId: "");
            },
          ),
          GoRoute(
            path: '/conversations',
            name: 'conversations',
            builder: (context, state) {
              final currentUserId = state.extra as String;
              return ConversationsListScreen(currentUserId: currentUserId);
            },
          ),
          GoRoute(
            path: '/chat',
            name: 'chat',
            builder: (context, state) {
              final data = state.extra as Map<String, dynamic>?;
              return ChatScreen(
                currentUserId: data?["currentUserId"] ?? "",
                otherUserId: data?["otherUserId"] ?? "",
                name: data?["name"] ?? "",
                role: data?["role"] ?? "",
                avatarUrl: data?["avatarUrl"] ?? "",
              );
            },
          ),
        ],
      ),
    ],
  );
});
