import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/theme/app_colors.dart';
import '../providers/auth_notifier.dart';

class SocialLoginSection extends ConsumerWidget {
  const SocialLoginSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);

    return Column(
      children: [
        // --- Or Divider ---
        Row(
          children: [
            Expanded(child: Divider(color: Color(0xFF0B2545))),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                "or",
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: Color(0xFF0B2545),
                  fontSize: 14.sp,
                ),
              ),
            ),

            Expanded(child: Divider(color: Color(0xFF0B2545))),
          ],
        ),
        SizedBox(height: 16.h),

        // --- Apple Button ---
        SizedBox(
          width: double.infinity,
          height: 56.h,
          child: OutlinedButton(
            onPressed: authState.isLoadingApple
                ? null
                : () async {
              // هنا حطي كود Apple Sign-In حسب المكتبة اللي هتستخدميها
              // مثال:
              final idToken = "dummy_apple_token"; // Replace with real token
              await authNotifier.socialLogin(
                idToken: idToken,
                provider: "apple",
              );


              if (ref.read(authProvider).isSuccess) {
                context.go('/main');
              }
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.strokeColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: authState.isLoadingApple
                ? SizedBox(
              width: 24.w,
              height: 24.h,
              child: CircularProgressIndicator(
                strokeWidth: 2.w,
                color: Color(0xFF0B2545),
              ),
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Continue with Apple",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color:Color(0xFF0B2545),
                  ),
                ),
                SizedBox(width: 12.w),
                Image.asset(
                  'assets/icons/apple.png',
                  width: 24.w,
                  height: 24.h,
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 12.h),

        // --- Google Button ---
        SizedBox(
          width: double.infinity,
          height: 56.h,
          child: OutlinedButton(
            onPressed: authState.isLoadingGoogle
                ? null
                : () async {
              final GoogleSignIn googleSignIn = GoogleSignIn();
              final googleUser = await googleSignIn.signIn();

              if (googleUser == null) return;

              final googleAuth = await googleUser.authentication;
              final idToken = googleAuth.idToken;

              if (idToken == null) return;

              await authNotifier.socialLogin(
                idToken: idToken,
                provider: "google",
              );

              if (ref.read(authProvider).isSuccess) {
                context.go('/main');
              }
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.strokeColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: authState.isLoadingGoogle
                ? SizedBox(
              width: 24.w,
              height: 24.h,
              child: CircularProgressIndicator(
                strokeWidth: 2.w,
                color: Color(0xFF0B2545),
              ),
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Continue with Google",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: Color(0xFF0B2545),
                  ),
                ),
                SizedBox(width: 12.w),
                Image.asset(
                  'assets/icons/google.png',
                  width: 24.w,
                  height: 24.h,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}