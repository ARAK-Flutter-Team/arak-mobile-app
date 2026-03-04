import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'features/auth/domain/entities/user.dart';
import 'features/auth/presentation/providers/auth_notifier.dart';
import 'features/schedule/presentation/pages/teacher_schedule_page.dart';
import 'features/splash/presentation/screens/splash_screen.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'core/router/main_shell.dart';

import 'features/tasks/presentation/pages/add_task_page.dart';
import 'features/tasks/presentation/pages/teacher_tasks_page.dart';
import 'features/teacher_home/presentation/screens/teacher_home_screen.dart';

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
                  final role = ref.watch(authProvider).user?.role;

                  if (role == UserRole.teacher) {
                    return const TeacherHomeScreen();
                  } else if (role == UserRole.parent) {
                    //return const ParentHomeScreen();
                    return const Scaffold(
                        body: Center(
                          child: Text("Parent Module Under Development"),
                        ),);
                  }

                  return const SizedBox();
                },
              );
            },
          ),
          /// Profile
          GoRoute(
            path: '/profile',
            builder: (context, state) =>
            const Placeholder(),
          ),

          /// Notifications
          GoRoute(
            path: '/notifications',
            builder: (context, state) =>
            const Placeholder(),
          ),

          /// Settings
          GoRoute(
            path: '/settings',
            builder: (context, state) =>
            const Placeholder(),
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
        ],
      ),
    ],
  );
});