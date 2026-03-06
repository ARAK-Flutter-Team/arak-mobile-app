import 'package:flutter/material.dart';
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
}