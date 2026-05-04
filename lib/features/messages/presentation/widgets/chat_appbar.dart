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
    final isDark = theme.brightness == Brightness.dark;
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return AppBar(
      backgroundColor: isDark ? Colors.black : Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      centerTitle: false,
      toolbarHeight: 60.h,
      titleSpacing: 10.w,
      leading: IconButton(
        onPressed: () {
          if (context.canPop()) {
            context.pop();
          } else {
            context.go('/home');
          }
        },
        icon: Transform(
          alignment: Alignment.center,
          transform: isRtl ? Matrix4.rotationY(3.1416) : Matrix4.identity(),
          child: SvgPicture.asset(
            'assets/icons/arrow.svg',
            width: 24.w,
            height: 24.h,
            colorFilter: ColorFilter.mode(
              theme.iconTheme.color ?? theme.colorScheme.onSurface,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
      title: Row(
        children: [
          CircleAvatar(
            radius: 18.r,
            backgroundImage: avatarUrl.isNotEmpty ? NetworkImage(avatarUrl) : null,
            child: avatarUrl.isEmpty ? Icon(Icons.person, size: 18.r) : null,
          ),
          SizedBox(width: 10.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: theme.textTheme.titleMedium,
              ),
              Text(
                role,
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
  Size get preferredSize => Size.fromHeight(60.h);
}