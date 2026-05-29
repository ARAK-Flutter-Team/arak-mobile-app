import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:arak_app/shared/widgets/app_bottom_navbar.dart';
import '../../features/notifications/presentation/providers/notifications_provider.dart';

class MainShell extends ConsumerStatefulWidget {
  final Widget child;

  const MainShell({super.key, required this.child});

  @override
  ConsumerState<MainShell> createState() => _MainShellState();
}

class _MainShellState extends ConsumerState<MainShell> {
  Timer? _timer;

  int _calculateIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/profile')) return 1;
    if (location.startsWith('/notifications')) return 2;
    if (location.startsWith('/settings')) return 3;

    return 0;
  }

  @override
  void initState() {
    super.initState();

    // أول تحميل
    _loadUnreadCount();

    // تحديث كل 10 ثواني
    _timer = Timer.periodic(
      const Duration(seconds: 10),
          (_) => _loadUnreadCount(),
    );
  }

  Future<void> _loadUnreadCount() async {
    try {
      final count = await ref
          .read(getUnreadCountUseCaseProvider)
          .call();

      ref.read(unreadNotificationsProvider.notifier).state = count;
    } catch (_) {}
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _calculateIndex(context);

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: currentIndex,
      ),
    );
  }
}