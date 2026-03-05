import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'features/attendance/presentation/teacher/pages/teacher_attendance_screen.dart';
import 'features/auth/domain/entities/user.dart';
import 'features/auth/presentation/providers/auth_notifier.dart';
import 'features/messages/presentation/screens/chat_screen.dart';
import 'features/messages/presentation/screens/users_list_screen.dart';
import 'features/schedule/presentation/pages/teacher_schedule_page.dart';
import 'features/splash/presentation/screens/splash_screen.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'core/router/main_shell.dart';

import 'features/tasks/presentation/pages/add_task_page.dart';
import 'features/tasks/presentation/pages/teacher_tasks_page.dart';
import 'features/teacher_home/presentation/screens/teacher_home_screen.dart';
import 'features/parent_home/presentation/screens/parent_home_screen.dart';

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

          /// Profile
          GoRoute(
            path: '/profile',
            builder: (context, state) => const Placeholder(),
          ),

          /// Notifications
          GoRoute(
            path: '/notifications',
            builder: (context, state) => const Placeholder(),
          ),

          /// Settings
          GoRoute(
            path: '/settings',
            builder: (context, state) => const Placeholder(),
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
            builder: (context, state) =>
            const TeacherSchedulePage(),
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
        ],
      ),
    ],
  );
});
