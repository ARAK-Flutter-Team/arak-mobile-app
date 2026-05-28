/*import 'package:flutter/material.dart';
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
        isActive
            ? const Color(0xFF2979FF)
            : (isDark ? Colors.white : Colors.black),
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
      elevation: 4,
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
            context.go('/notifications');
            break;
          case 3:
            context.go('/settings');
            break;
        }
      },
      selectedItemColor: const Color(0xFF2979FF),
      unselectedItemColor: isDark ? Colors.white : Colors.black,
      items: [
        BottomNavigationBarItem(
          icon: _buildSvgIcon(
              context, 'assets/icons/home-1.svg', currentIndex == 0),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: _buildSvgIcon(
              context, 'assets/icons/user-1.svg', currentIndex == 1),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: _buildSvgIcon(
              context, 'assets/icons/bell.svg', currentIndex == 2),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: _buildSvgIcon(
              context, 'assets/icons/settings.svg', currentIndex == 3),
          label: "",
        ),
      ],
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:arak_app/features/notifications/presentation/providers/notifications_provider.dart';

class AppBottomNavBar extends ConsumerWidget {
  final int currentIndex;

  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
  });

  Widget _buildSvgIcon(
      BuildContext context,
      String assetPath,
      bool isActive,
      ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    double size = 28;

    if (assetPath.contains('home') ||
        assetPath.contains('user')) {
      size = 24;
    }

    return SvgPicture.asset(
      assetPath,
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(
        isActive
            ? const Color(0xFF2979FF)
            : (isDark ? Colors.white : Colors.black),
        BlendMode.srcIn,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    final unreadCount =
    ref.watch(unreadNotificationsProvider);

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor:
      isDark ? Colors.black : Colors.white,
      elevation: 4,
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
            context.go('/notifications');
            break;

          case 3:
            context.go('/settings');
            break;
        }
      },

      selectedItemColor: const Color(0xFF2979FF),

      unselectedItemColor:
      isDark ? Colors.white : Colors.black,

      items: [

        /// HOME
        BottomNavigationBarItem(
          icon: _buildSvgIcon(
            context,
            'assets/icons/home-1.svg',
            currentIndex == 0,
          ),
          label: "",
        ),

        /// PROFILE
        BottomNavigationBarItem(
          icon: _buildSvgIcon(
            context,
            'assets/icons/user-1.svg',
            currentIndex == 1,
          ),
          label: "",
        ),

        /// NOTIFICATIONS
        BottomNavigationBarItem(
          icon: Badge(
            isLabelVisible: unreadCount > 0,

            label: Text(
              unreadCount > 99
                  ? '99+'
                  : unreadCount.toString(),

              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),

            backgroundColor: Colors.red,

            child: _buildSvgIcon(
              context,
              'assets/icons/bell.svg',
              currentIndex == 2,
            ),
          ),
          label: "",
        ),

        /// SETTINGS
        BottomNavigationBarItem(
          icon: _buildSvgIcon(
            context,
            'assets/icons/settings.svg',
            currentIndex == 3,
          ),
          label: "",
        ),
      ],
    );
  }
}