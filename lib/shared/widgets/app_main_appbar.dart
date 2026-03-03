import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AppMainAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;
  final VoidCallback? onBack;
  final bool centerTitle;
  final bool disableDefaultLeading;
  final Widget? leadingWidget;

  const AppMainAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.actions,
    this.onBack,
    this.centerTitle = false,
    this.disableDefaultLeading = false,
    this.leadingWidget,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      backgroundColor: isDark ? Colors.black : Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,

      automaticallyImplyLeading: false,
      centerTitle: centerTitle,
      toolbarHeight: kToolbarHeight,

      title: Text(
        title,
        style: theme.textTheme.titleLarge?.copyWith(
          fontSize: 25.sp,
          fontWeight: FontWeight.bold,
          fontFamily: 'Teachers',
        ),
      ),

      leading: disableDefaultLeading
          ? leadingWidget
          : showBackButton
          ? IconButton(
        onPressed: onBack ?? () {
          if (context.canPop()) {
            context.pop(); // هيرجع للصفحة اللي فاتت
          } else {
            context.go('/home'); // fallback لو مفيش صفحة ترجع لها
          }
        },
        icon: SvgPicture.asset(
          'assets/icons/arrow.svg',
          width: 24.w,
          height: 24.h,
          colorFilter: ColorFilter.mode(
            theme.iconTheme.color ?? theme.colorScheme.onSurface,
            BlendMode.srcIn,
          ),
        ),
      )
          : null,
      /*leading: disableDefaultLeading
          ? leadingWidget
          : showBackButton
          ? IconButton(
        onPressed: onBack ??
                () {
              if (context.canPop()) {
                context.go('/home');
              }
            },
        icon: SvgPicture.asset(
          'assets/icons/arrow.svg',
          width: 24.w,
          height: 24.h,
          colorFilter: ColorFilter.mode(
            theme.iconTheme.color ??
                theme.colorScheme.onSurface,
            BlendMode.srcIn,
          ),
        ),
      )
          : null,*/

      actions: actions,
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight);
}