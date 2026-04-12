/*import 'package:arak_app/core/entities/user.dart';
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
import '../widgets/language_tile.dart';
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
          padding: const EdgeInsets.only(left: 8),
          child: Icon(
            Icons.settings,
            size: 26.sp,
            color: Theme.of(context).iconTheme.color ?? Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            /// User Header
            UserHeaderCard(
              name: user.name,
              subtitle: user.role == UserRole.teacher
                  ? (user.subject ?? '') // ← المعلم يشوف المادة
                  : '', // ← ولي الأمر ملوش subtitle
              imageUrl: user.avatarUrl,
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
           /* SettingsSwitchTile(
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
            ),*/
            if (user.role == UserRole.parent)
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
                  message: value ? "Dark mode enabled" : "Dark mode disabled",
                  type: AppSnackBarType.info,
                );
              },
            ),
            ///Choose Language
            const SettingsLanguageTile(),
          ],
        ),
      ),
    );
  }
}*/
import 'package:arak_app/core/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/providers/current_user_provider.dart';
import '../../../../shared/theme/theme_provider.dart';
import '../../../../shared/widgets/app_main_appbar.dart';
import '../../../../shared/widgets/app_snackbar.dart';
import '../../../../shared/widgets/user_header_card.dart';
import '../providers/settings_provider.dart';
import '../widgets/language_tile.dart';
import '../widgets/settings_switch_tile.dart';
import '../widgets/settings_tile.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
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
        title: loc.settings,
        centerTitle: false,
        showBackButton: false,
        disableDefaultLeading: true,
        leadingWidget: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Icon(
            Icons.settings,
            size: 26.sp,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [

            /// User Header
            UserHeaderCard(
              name: user.name,
              subtitle: user.role == UserRole.teacher
                  ? (user.subject ?? '')
                  : '',
              imageUrl: user.avatarUrl,
              showSearch: false,
            ),

            SizedBox(height: 16.h),

            /// Privacy Policy
            SettingsTile(
              title: loc.privacyPolicy,
              onTap: () {
                //context.push('/privacy-policy');
                context.push('/settings/privacy-policy');
              },
            ),

            SizedBox(height: 12.h),

            /// Message Notification
            SettingsSwitchTile(
              title: loc.messageNotification,
              value: state.messageNotification,
              onChanged: (value) {
                controller.toggleMessageNotification(value);

                AppSnackBar.show(
                  context,
                  message: value
                      ? loc.messageEnabled
                      : loc.messageDisabled,
                  type: AppSnackBarType.info,
                );
              },
            ),

            /// Attendance Alerts (لولي الأمر فقط)
            if (user.role == UserRole.parent)
              SettingsSwitchTile(
                title: loc.attendanceAlerts,
                value: state.attendanceAlert,
                onChanged: (value) {
                  controller.toggleAttendanceAlert(value);

                  AppSnackBar.show(
                    context,
                    message: value
                        ? loc.attendanceEnabled
                        : loc.attendanceDisabled,
                    type: AppSnackBarType.info,
                  );
                },
              ),

            /// Dark Mode
            SettingsSwitchTile(
              title: loc.darkMode,
              value: state.darkMode,
              onChanged: (value) {
                controller.toggleDarkMode(value);
                ref.read(themeProvider.notifier).toggleDarkMode(value);

                AppSnackBar.show(
                  context,
                  message: value
                      ? loc.darkModeEnabled
                      : loc.darkModeDisabled,
                  type: AppSnackBarType.info,
                );
              },
            ),

            /// Language
            const SettingsLanguageTile(),
          ],
        ),
      ),
    );
  }
}