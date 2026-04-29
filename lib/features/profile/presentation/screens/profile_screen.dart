import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/entities/user.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/providers/current_user_provider.dart';
import '../../../../shared/widgets/app_main_appbar.dart';

import '../widgets/info_tile.dart';
import '../widgets/profile_header.dart';
import '../widgets/info_section.dart';
import '../widgets/logout_button.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final loc = AppLocalizations.of(context)!;
    final user = ref.watch(currentUserProvider);

    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(

      appBar: AppMainAppBar(
        title: loc.profile,
        showBackButton: false,
        disableDefaultLeading: true,
        leadingWidget: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Icon(
              Icons.person,
              size: 26.w,
              color: Theme.of(context).iconTheme.color,
            )
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Column(
          children: [

            /// Header
            ProfileHeader(user: user),

            SizedBox(height: 30.h),

            /// Personal Info
            InfoSection(
              title: loc.personalInformation,
              children: [

                InfoTile(
                  icon: Icons.email,
                  label: loc.email,
                  value: user.email,
                ),

                SizedBox(height: 12.h),

                InfoTile(
                  icon: Icons.phone,
                  label: loc.phone,
                  value: user.phone ?? "",
                  onEdit: (newPhone) {
                    ref.read(currentUserProvider.notifier).state =
                        user.copyWith(phone: newPhone);
                  },
                ),

                SizedBox(height: 12.h),

                InfoTile(
                  icon: Icons.person,
                  label: loc.username,
                  value: user.name,
                ),
              ],
            ),

            SizedBox(height: 20.h),

            /// Teacher Info
            if (user.role == UserRole.teacher)
              InfoSection(
                title: loc.teacherInformation,
                children: [

                  InfoTile(
                    icon: Icons.book,
                    label: loc.subject,
                    value: user.subject ?? "",
                  ),

                  SizedBox(height: 12.h),

                  InfoTile(
                    icon: Icons.school,
                    label: loc.accountType,
                    value: user.role.name, // ممكن نحسنها تحت 👇
                  ),
                ],
              ),

            SizedBox(height: 30.h),

            const LogoutButton(),
          ],
        ),
      ),
    );
  }
}