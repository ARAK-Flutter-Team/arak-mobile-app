import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/providers/current_user_provider.dart';
import '../../../../shared/theme/theme_provider.dart';
import '../../../../shared/widgets/app_main_appbar.dart';
import '../../../../shared/widgets/app_snackbar.dart';
import '../../../../shared/widgets/user_header_card.dart';
import '../providers/settings_provider.dart';
import '../widgets/settings_switch_tile.dart';
import '../widgets/settings_tile.dart';

class SettingsPage extends ConsumerWidget {

  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final state = ref.watch(settingsProvider);
    final controller = ref.read(settingsProvider.notifier);
    final user = ref.watch(currentUserProvider);
    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppMainAppBar(
        title: "Settings",
        centerTitle: false,
        showBackButton: false,
        disableDefaultLeading: true,
        leadingWidget: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: SvgPicture.asset(
            'assets/icons/Group 17.svg',
            width: 24.w,
            height: 24.h,
            colorFilter: ColorFilter.mode(
              Theme.of(context).iconTheme.color ?? Colors.black,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),

        child: Column(
          children: [

            /// User Header
            UserHeaderCard(
              name: user?.name ?? "",
              subtitle: user?.subject ?? "", // المادة هنا كمان
              imageUrl: user?.avatarUrl,
              showSearch: false,
            ),

            SizedBox(height: 16.h),
            /// Privacy Policy
            SettingsTile(
              title: "Privacy Policy",
              onTap: () {
                context.push('/privacy-policy');
              },
            ),

            SizedBox(height: 12.h),

            /// Message Notification
            SettingsSwitchTile(
              title: "Message Notification",
              value: state.messageNotification,
              onChanged: (value) {

                controller.toggleMessageNotification(value);

                AppSnackBar.show(
                  context,
                  message: value
                      ? "Message notifications enabled"
                      : "Message notifications disabled",
                  type: AppSnackBarType.info,
                );
              },
            ),

            /// Attendance Alerts
            SettingsSwitchTile(
              title: "Attendance Alerts",
              value: state.attendanceAlert,
              onChanged: (value) {

                controller.toggleAttendanceAlert(value);

                AppSnackBar.show(
                  context,
                  message: value
                      ? "Attendance alerts enabled"
                      : "Attendance alerts disabled",
                  type: AppSnackBarType.info,
                );
              },
            ),

            /// Dark Mode
            SettingsSwitchTile(
              title: "Dark Mode",
              value: state.darkMode,
              onChanged: (value) {

                controller.toggleDarkMode(value);

                ref.read(themeProvider.notifier).toggleDarkMode(value);

                AppSnackBar.show(
                  context,
                  message: value
                      ? "Dark mode enabled"
                      : "Dark mode disabled",
                  type: AppSnackBarType.info,
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}