import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/theme/app_colors.dart';
import '../providers/splash_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _start();
  }

  Future<void> _start() async {
    await ref.read(splashProvider).initializeApp();

    if (mounted) {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // --------- اللوجو ---------
            Shimmer.fromColors(
              baseColor: AppColors.primaryBlue,
              highlightColor: AppColors.white,
              period: const Duration(seconds: 3),
              child: Image.asset(
                'assets/images/app_icon.png',
                width: 200.w,
                height: 200.h,
                fit: BoxFit.contain,
              ),
            ),

            SizedBox(height: 30.h),

            // --------- النص ---------
            Shimmer.fromColors(
              baseColor: Colors.white,
              highlightColor: AppColors.primaryBlue.withOpacity(0.5),
              period: const Duration(seconds: 3),
              child: Column(
                children: [
                  Text(
                    'ARAK',
                    style: TextStyle(
                      fontFamily: 'Teko',
                      fontSize: 45.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 2.5,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'أراك ... لنطمئن',
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}