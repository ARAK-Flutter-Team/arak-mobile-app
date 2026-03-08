import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'features/evaluation/presentation/pages/evaluation_page.dart';
import 'package:arak_app/features/search-for-student/presentation/pages/attendance_page.dart';
import 'features/attendance/presentation/teacher/pages/teacher_attendance_screen.dart';
import 'core/entities/user.dart';
import 'features/auth/presentation/providers/auth_notifier.dart';
import 'features/auth/presentation/providers/auth_providers.dart';
import 'features/messages/presentation/screens/chat_screen.dart';
import 'features/messages/presentation/screens/users_list_screen.dart';
import 'features/profile/presentation/screens/profile_screen.dart';
import 'features/schedule/presentation/pages/teacher_schedule_page.dart';
import 'features/settings/presentation/pages/privacy_policy_page.dart';
import 'features/settings/presentation/pages/settings_page.dart';
import 'features/splash/presentation/screens/splash_screen.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'core/router/main_shell.dart';

import 'features/tasks/presentation/pages/add_task_page.dart';
import 'features/tasks/presentation/pages/teacher_tasks_page.dart';
import 'features/teacher_home/presentation/screens/teacher_home_screen.dart';
import 'features/parent_home/presentation/screens/parent_home_screen.dart';

import 'features/tasks/presentation/pages/parent_tasks_page.dart';
import 'features/tasks/presentation/pages/parent_task_details_page.dart';
import 'features/tasks/domain/entities/task.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      /// Splash
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),

      /// Login
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),

      /// Shell (Bottom Nav)
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return MainShell(child: child);
        },
        routes: [
          /// Home
          GoRoute(
            path: '/home',
            builder: (context, state) {
              return Consumer(
                builder: (context, ref, _) {
                  final authState = ref.watch(authProvider);
                  final role = authState.user?.role;

                  if (role == UserRole.teacher) {
                    return const TeacherHomeScreen();
                  } else if (role == UserRole.parent) {
                    return const ParentHomeScreen(); // ✅ شغّلها
                  }

                  return const Scaffold(
                    body: Center(child: Text("Loading...")),
                  );
                },
              );
            },
          ),

          /// ── Parent Routes ──
          GoRoute(
            path: '/parent-home/tasks',
            builder: (context, state) {
              final studentId = state.extra as String? ?? '';
              return ParentTasksPage(studentId: studentId);
            },
            routes: [
              GoRoute(
                path: 'details',
                builder: (context, state) {
                  final task = state.extra as Task;
                  return ParentTaskDetailsPage(task: task);
                },
              ),
            ],
          ),
          GoRoute(
            path: '/parent-home/evaluation',
            builder: (context, state) => const StudentEvaluationPage(),
          ),
          GoRoute(
            path: '/parent-home/schedule',
            builder: (context, state) => const Placeholder(),
          ),
          GoRoute(
            path: '/parent-home/contact',
            builder: (context, state) => const Placeholder(),
          ),
          GoRoute(
            path: '/parent-home/attendance',
            builder: (context, state) => const AttendancePage(),
          ),
          GoRoute(
            path: '/parent-home/chatbot',
            builder: (context, state) => const Placeholder(),
          ),

          /// Search For Student (Attendance)
          GoRoute(
            path: '/search-for-student',
            builder: (context, state) => const AttendancePage(),
          ),

          /// Profile
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),

          /// Notifications
          GoRoute(
            path: '/notifications',
            builder: (context, state) => const Placeholder(),
          ),

          /// Evaluation Page
          GoRoute(
            path: '/evaluation',
            builder: (context, state) => const StudentEvaluationPage(),
          ),

          /// Search For Student Page
          GoRoute(
            path: '/search-for-student',
            builder: (context, state) => const AttendancePage(),
          ),

          /// Settings
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsPage(),
          ),

          ///teacher task
          GoRoute(
            path: '/teacher/tasks',
            builder: (context, state) {
              return Consumer(
                builder: (context, ref, _) {
                  final user = ref.watch(authProvider).user;

                  return TeacherTasksScreen(
                    teacherId: user?.id.toString() ?? '',
                  );
                },
              );
            },
          ),

          ///teacher add task
          GoRoute(
            path: '/teacher/add-task',
            builder: (context, state) {
              final teacherId = state.extra as String;

              return AddTaskPage(
                teacherId: teacherId,
              );
            },
          ),

          ///teacher schedule
          GoRoute(
            path: '/teacher-schedule',
            builder: (context, state) => const TeacherSchedulePage(),
          ),

          /// teacher attendance
          GoRoute(
            path: '/teacher/attendance/:classId',
            builder: (context, state) {
              final classId = state.pathParameters['classId']!;

              return TeacherAttendanceScreen(
                classId: classId,
              );
            },
          ),

          /// Chat Screen
          GoRoute(
            path: '/chat',
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
          GoRoute(
            path: '/chat-users',
            builder: (context, state) {
              final extra = state.extra as Map;

              return UsersListScreen(
                currentUserId: extra["currentUserId"],
                users: extra["users"],
              );
            },
          ),

          /// Privacy Policy Page

          GoRoute(
            path: "/privacy-policy",
            builder: (context, state) => const PrivacyPolicyPage(),
          ),
        ],
      ),
    ],
  );
});
