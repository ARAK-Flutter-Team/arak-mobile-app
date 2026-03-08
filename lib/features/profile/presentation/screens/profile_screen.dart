import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/entities/user.dart';
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

    final user = ref.watch(currentUserProvider);

    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(

      /// 🔹 Custom AppBar
      appBar: AppMainAppBar(
        title: "Profile",
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
        padding:  EdgeInsets.all(20.r),
        child: Column(
          children: [

            /// Profile Header
            ProfileHeader(user: user),

             SizedBox(height: 30.h),

            /// Personal Info
           /* InfoSection(
              title: "Personal Information",
              children: [
                InfoTile(
                  icon: Icons.email,
                  label: "Email",
                  value: user.email,
                ),
                SizedBox(height: 10.h),
                InfoTile(
                  icon: Icons.phone,
                  label: "Phone",
                  value: user.phone ?? "",
                  onEdit: (newPhone) {
                    // تعديل الرقم وتحديث الـ provider
                    ref.read(currentUserProvider.notifier).state =
                        ref.read(currentUserProvider.notifier).state?.copyWith(
                          phone: newPhone,
                        );
                  },
                ),
                SizedBox(height: 10.h),
                const InfoTile(
                  icon: Icons.person,
                  label: "Username",
                  value: "Ahmed123",
                ),
              ],
            ),*/
            InfoSection(
              title: "Personal Information",
              children: [

                /// Email
                InfoTile(
                  icon: Icons.email,
                  label: "Email",
                  value: user.email,
                ),

                SizedBox(height: 12.h),

                /// Phone
                InfoTile(
                  icon: Icons.phone,
                  label: "Phone",
                  value: user.phone ?? "",
                  onEdit: (newPhone) {
                    if (user != null) {
                      ref.read(currentUserProvider.notifier).state =
                          user.copyWith(phone: newPhone);
                    }
                  },
                ),

                SizedBox(height: 12.h),

                /// Username
                InfoTile(
                  icon: Icons.person,
                  label: "Username",
                  value: user.name,
                ),

              ],
            ),
             SizedBox(height: 20.h),

            /// Teacher Info
           if (user.role == UserRole.teacher)
            InfoSection(
              title: "Teacher Information",
              children: [
                 InfoTile(
                  icon: Icons.book,
                  label: "Subject",
                  value: user.subject ?? "", // بدل Math
                ),
                SizedBox(height: 12.h),
                InfoTile(
                  icon: Icons.school,
                  label: "Account Type",
                  value: user.role.name,
                ),
              ],
            ),

             SizedBox(height: 30.h),

            /// Logout
            const LogoutButton(),
          ],
        ),
      ),
    );
  }
}