/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'features/evaluation/presentation/pages/evaluation_page.dart';
import 'package:arak_app/features/search-for-student/presentation/pages/attendance_page.dart';
import 'features/attendance/presentation/teacher/pages/teacher_attendance_screen.dart';
import 'core/entities/user.dart';
import 'features/auth/presentation/providers/auth_providers.dart';
import 'features/messages/presentation/screens/chat_screen.dart';
import 'features/messages/presentation/screens/conversations_list_screen.dart';
import 'features/messages/presentation/screens/users_list_screen.dart';
import 'features/notifications/presentation/pages/notifications_page.dart';
import 'features/profile/presentation/screens/profile_screen.dart';
import 'package:arak_app/features/contact_page/presentation/pages/contact_page.dart';
import 'features/schedule/presentation/pages/teacher_schedule_page.dart';
import 'features/schedual-of-student/presentation/pages/schedule_screen.dart';
import 'features/search/presentation/pages/teacher_search_page.dart';
import 'features/settings/presentation/pages/privacy_policy_page.dart';
import 'features/settings/presentation/pages/settings_page.dart';
import 'features/splash/presentation/screens/splash_screen.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'core/router/main_shell.dart';
import 'features/search-page/presentation/pages/search_page.dart';
import 'features/tasks/presentation/pages/add_task_page.dart';
import 'features/tasks/presentation/pages/teacher_tasks_page.dart';
import 'features/teacher_home/presentation/screens/teacher_home_screen.dart';
import 'features/parent_home/presentation/screens/parent_home_screen.dart';
import 'features/tasks/presentation/pages/parent_tasks_page.dart';
import 'features/tasks/presentation/pages/parent_task_details_page.dart';
import 'features/tasks/domain/entities/task.dart';
import 'features/search-page/presentation/pages/details_page.dart';
import 'features/search-page/domain/entities/student.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/teacher-search',
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
            builder: (context, state) => const ScheduleScreen(),
          ),
          GoRoute(
            path: '/parent-home/contact',
            builder: (context, state) => const ContactPage(),
          ),
          GoRoute(
            path: '/parent-home/attendance',
            builder: (context, state) => const AttendancePage(),
          ),
          GoRoute(
            path: '/parent-home/chatbot',
            builder: (context, state) => const Placeholder(),
          ),
          GoRoute(
            path: '/search-for-student',
            builder: (context, state) => const AttendancePage(),
          ),
          GoRoute(
            path: '/search',
            builder: (context, state) => const SearchPage(),
          ),
          GoRoute(
            path: '/student-details',
            builder: (context, state) {
              final student = state.extra as Student;
              return DetailsPage(studentName: student.name);
            },
          ),
          GoRoute(
            path: '/contact',
            builder: (context, state) => const ContactPage(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
          GoRoute(
            path: '/notifications',
            builder: (context, state) => const NotificationsPage(),
          ),
          GoRoute(
            path: '/evaluation',
            builder: (context, state) => const StudentEvaluationPage(),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsPage(),
          ),
          GoRoute(
            path: '/teacher/tasks',
            builder: (context, state) {
              return Consumer(
                builder: (context, ref, _) {
                  final user = ref.watch(authProvider).user;
                  return const TeacherTasksScreen();
                },
              );
            },
          ),
          GoRoute(
            path: '/teacher/add-task',
            builder: (context, state) {
              // final teacherId = state.extra as String;
              return const AddTaskPage();
            },
          ),
          GoRoute(
            path: '/teacher-schedule',
            builder: (context, state) => const TeacherSchedulePage(),
          ),
          GoRoute(
            path: '/student-schedule',
            builder: (context, state) => const ScheduleScreen(),
          ),
          GoRoute(
            path: '/teacher/attendance/:classId',
            builder: (context, state) {
              final classId = state.pathParameters['classId']!;
              return TeacherAttendanceScreen(classId: classId);
            },
          ),
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
      
          GoRoute(
            path: '/settings/privacy-policy',
            builder: (context, state) => const PrivacyPolicyPage(),
          ),

          GoRoute(
            path: '/conversations',
            name: 'conversations',
            builder: (context, state) {
              final currentUserId = state.extra as String;
              return ConversationsListScreen(currentUserId: currentUserId);
            },
          ),
        ],
      ),
    ],
  );
});*/
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'features/evaluation/presentation/pages/evaluation_page.dart';
import 'package:arak_app/features/search-for-student/presentation/pages/attendance_page.dart';
import 'features/attendance/presentation/teacher/pages/teacher_attendance_screen.dart';
import 'core/entities/user.dart';
import 'features/auth/presentation/providers/auth_providers.dart';
import 'features/messages/presentation/screens/chat_screen.dart';
import 'features/messages/presentation/screens/conversations_list_screen.dart';
import 'features/notifications/presentation/pages/notifications_page.dart';
import 'features/profile/presentation/screens/profile_screen.dart';
import 'package:arak_app/features/contact_page/presentation/pages/contact_page.dart';
import 'features/schedule/presentation/pages/teacher_schedule_page.dart';
import 'features/schedual-of-student/presentation/pages/schedule_screen.dart';
import 'features/search/presentation/pages/teacher_search_page.dart';
import 'features/settings/presentation/pages/privacy_policy_page.dart';
import 'features/settings/presentation/pages/settings_page.dart';
import 'features/splash/presentation/screens/splash_screen.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'core/router/main_shell.dart';
import 'features/search-page/presentation/pages/search_page.dart';
import 'features/tasks/presentation/pages/add_task_page.dart';
import 'features/tasks/presentation/pages/teacher_tasks_page.dart';
import 'features/teacher_home/presentation/screens/teacher_home_screen.dart';
import 'features/parent_home/presentation/screens/parent_home_screen.dart';
import 'features/tasks/presentation/pages/parent_tasks_page.dart';
import 'features/tasks/presentation/pages/parent_task_details_page.dart';
import 'features/tasks/domain/entities/task.dart';
import 'features/search-page/presentation/pages/details_page.dart';
import 'features/search-page/domain/entities/student.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      // ==================== Routes خارج الـ Shell ====================
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

      // ==================== Shell Route (الرئيسي) ====================
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return MainShell(child: child);
        },
        routes: [
          // ==================== Home ====================
          GoRoute(
            path: '/home',
            name: 'home',
            builder: (context, state) {
              return Consumer(
                builder: (context, ref, _) {
                  final authState = ref.watch(authProvider);
                  final role = authState.user?.role;
                  if (role == UserRole.teacher) return const TeacherHomeScreen();
                  if (role == UserRole.parent) return const ParentHomeScreen();
                  return const Scaffold(
                    body: Center(child: Text("Loading...")),
                  );
                },
              );
            },
          ),

          // ==================== Parent Routes ====================
          GoRoute(
            path: '/parent-home/tasks',
            name: 'parent-tasks',
            builder: (context, state) {
              final studentId = state.extra as String? ?? '';
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

          // ==================== Search Routes ====================
          GoRoute(
            path: '/search-for-student',
            name: 'search-for-student',
            builder: (context, state) => const AttendancePage(),
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

          // ==================== General Routes ====================
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

          // ==================== Teacher Routes ====================
          GoRoute(
            path: '/teacher/tasks',
            name: 'teacher-tasks',
            builder: (context, state) {
              return Consumer(
                builder: (context, ref, _) {
                  return const TeacherTasksScreen();
                },
              );
            },
          ),
          GoRoute(
            path: '/teacher/add-task',
            name: 'teacher-add-task',
            builder: (context, state) {
              return const AddTaskPage();
            },
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
            path: '/teacher/attendance/:classId',
            name: 'teacher-attendance',
            builder: (context, state) {
              final classId = state.pathParameters['classId']!;
              return TeacherAttendanceScreen(classId: classId);
            },
          ),

          // ==================== Messages Routes ====================
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