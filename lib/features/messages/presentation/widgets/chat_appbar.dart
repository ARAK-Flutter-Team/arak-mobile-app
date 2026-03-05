import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {

  final String name;
  final String role;
  final String avatarUrl;

  const ChatAppBar({
    super.key,
    required this.name,
    required this.role,
    required this.avatarUrl,
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
      centerTitle: false,
      toolbarHeight: kToolbarHeight,
      titleSpacing: 0,

      leading: IconButton(
        onPressed: () {
          if (context.canPop()) {
            context.pop();
          } else {
            context.go('/home');
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
      ),

      title: Row(
        children: [

          /// الصورة
          CircleAvatar(
            radius: 18.r,
            backgroundImage: NetworkImage(avatarUrl),
          ),

          SizedBox(width: 10.w),

          /// الاسم + الرول
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                name,
                style: theme.textTheme.titleMedium,
              ),

              Text(
                role == "parent" ? "Parent" : "Teacher",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}