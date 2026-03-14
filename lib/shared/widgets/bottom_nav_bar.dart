/*import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AppBottomNavBar extends StatelessWidget {
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

    return SvgPicture.asset(
      assetPath,
      width: 24.w,
      height: 24.h,
      colorFilter: ColorFilter.mode(
        isActive
            ? const Color(0xFF42B0FF)
            : (isDark ? Colors.white : Colors.black),
        BlendMode.srcIn,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: isDark ? Colors.black : Colors.white,
      elevation: 5,
      currentIndex: currentIndex,

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

      selectedItemColor: const Color(0xFF42B0FF),
      unselectedItemColor: isDark ? Colors.white : Colors.black,

      items: [
        BottomNavigationBarItem(
          icon: _buildSvgIcon(
            context,
            'assets/icons/home-1.svg',
            currentIndex == 0,
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: _buildSvgIcon(
            context,
            'assets/icons/user-1.svg',
            currentIndex == 1,
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: _buildSvgIcon(
            context,
            'assets/icons/bell.svg',
            currentIndex == 2,
          ),
          label: "",
        ),
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
}*/
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/notifications/presentation/providers/notifications_badge_provider.dart';

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

    return SvgPicture.asset(
      assetPath,
      width: 24.w,
      height: 24.h,
      colorFilter: ColorFilter.mode(
        isActive
            ? const Color(0xFF42B0FF)
            : (isDark ? Colors.white : Colors.black),
        BlendMode.srcIn,
      ),
    );
  }

  /// 🔔 الجرس مع رقم الإشعارات
  Widget _buildNotificationIcon(
      BuildContext context,
      int unreadCount,
      bool isActive,
      ) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _buildSvgIcon(
          context,
          'assets/icons/bell.svg',
          isActive,
        ),

        if (unreadCount > 0)
          Positioned(
            right: -6,
            top: -4,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              constraints: const BoxConstraints(
                minWidth: 18,
                minHeight: 18,
              ),
              child: Text(
                unreadCount > 9 ? "9+" : unreadCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unreadCount = ref.watch(unreadNotificationsProvider);

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: isDark ? Colors.black : Colors.white,
      elevation: 5,
      currentIndex: currentIndex,

      onTap: (index) {
        switch (index) {
          case 0:
            context.go('/home');
            break;

          case 1:
            context.go('/profile');
            break;

          case 2:
          /// عند فتح صفحة الإشعارات نخلي العدد صفر
            ref.read(unreadNotificationsProvider.notifier).state = 0;

            context.go('/notifications');
            break;

          case 3:
            context.go('/settings');
            break;
        }
      },

      selectedItemColor: const Color(0xFF42B0FF),
      unselectedItemColor: isDark ? Colors.white : Colors.black,

      items: [
        BottomNavigationBarItem(
          icon: _buildSvgIcon(
            context,
            'assets/icons/home-1.svg',
            currentIndex == 0,
          ),
          label: "",
        ),

        BottomNavigationBarItem(
          icon: _buildSvgIcon(
            context,
            'assets/icons/user-1.svg',
            currentIndex == 1,
          ),
          label: "",
        ),

        BottomNavigationBarItem(
          icon: _buildNotificationIcon(
            context,
            unreadCount,
            currentIndex == 2,
          ),
          label: "",
        ),

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
