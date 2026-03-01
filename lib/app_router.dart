import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'features/splash/presentation/screens/splash_screen.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'core/router/main_shell.dart';

// هنعملهم بعدين
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
            path: '/teacher-home',
            builder: (context, state) => const TeacherHomeScreen(),
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
        ],
      ),
    ],
  );
});