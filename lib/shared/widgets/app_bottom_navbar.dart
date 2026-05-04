import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:arak_app/features/auth/presentation/providers/auth_providers.dart';

class AppBottomNavBar extends ConsumerWidget {
  final int currentIndex;

  const AppBottomNavBar({super.key, required this.currentIndex});

  Widget _buildSvgIcon(BuildContext context, String assetPath, bool isActive) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    double size = 28;

    if (assetPath.contains('home') || assetPath.contains('user')) {
      size = 24;
    }

    return SvgPicture.asset(
      assetPath,
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(
        isActive ? const Color(0xFF2979FF) : (isDark ? Colors.white : Colors.black),
        BlendMode.srcIn,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: isDark ? Colors.black : Colors.white,
      elevation: 5,
      currentIndex: currentIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: (index) {
        switch (index) {
          case 0:
            context.go('/home');
            break;
          case 1:
            context.go('/profile');
            break;
          case 2:
            final userId = ref.read(authProvider).user?.id ?? '';
            context.push('/conversations', extra: userId);
            break;
          case 3:
            context.go('/notifications');
            break;
          case 4:
            context.go('/settings');
            break;
        }
      },
      selectedItemColor: const Color(0xFF2979FF),
      unselectedItemColor: isDark ? Colors.white : Colors.black,
      items: [
        BottomNavigationBarItem(
          icon: _buildSvgIcon(context, 'assets/icons/home-1.svg', currentIndex == 0),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: _buildSvgIcon(context, 'assets/icons/user-1.svg', currentIndex == 1),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: _buildSvgIcon(context, 'assets/icons/messages.svg', currentIndex == 2),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: _buildSvgIcon(context, 'assets/icons/bell.svg', currentIndex == 3),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: _buildSvgIcon(context, 'assets/icons/settings.svg', currentIndex == 4),
          label: "",
        ),
      ],
    );
  }
}