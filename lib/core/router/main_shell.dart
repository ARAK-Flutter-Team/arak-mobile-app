/*import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class MainShell extends StatelessWidget {
  final Widget child;

  const MainShell({super.key, required this.child});

  int _calculateIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/profile')) return 1;
    if (location.startsWith('/notifications')) return 2;
    if (location.startsWith('/settings')) return 3;

    return 0;
  }

  Widget _buildSvgIcon(
      BuildContext context,
      String assetPath,
      bool isActive,
      ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SvgPicture.asset(
      assetPath,
      width: 24,
      height: 24,
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
    final currentIndex = _calculateIndex(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: child,

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.black : Colors.white,

          // ظل خفيف من فوق في اللايت مود فقط
          boxShadow: isDark
              ? []
              : [
            const BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
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
                  context, 'assets/icons/bell.svg',
                  currentIndex == 2),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: _buildSvgIcon(
                  context, 'assets/icons/settings.svg', currentIndex == 3),
              label: "",
            ),
          ],
        ),
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../shared/widgets/app_bottom_navbar.dart';

class MainShell extends StatelessWidget {
  final Widget child;

  const MainShell({super.key, required this.child});

  int _calculateIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/profile')) return 1;
    if (location.startsWith('/notifications')) return 2;
    if (location.startsWith('/settings')) return 3;

    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _calculateIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: currentIndex,
      ),
    );
  }
}