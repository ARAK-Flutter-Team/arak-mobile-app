import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/theme/app_colors.dart';

class AppInputDecoration {
  static InputDecoration build({
    required String label,
    String? errorText,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      contentPadding:
      EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      filled: true,
      fillColor: AppColors.coloredFilled,
      label: RichText(
        text: TextSpan(
          text: label,
          style: TextStyle(
            color: AppColors.gray,
            fontFamily: 'Inter',
          ),
          children: const [
            TextSpan(
              text: ' *',
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
      errorText: errorText,
      errorStyle: TextStyle(fontSize: 12.sp),
      suffixIcon: suffixIcon,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: AppColors.strokeColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(
          color: AppColors.primaryBlue,
          width: 1.w,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: AppColors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(
          color: AppColors.red,
          width: 1.5.w,
        ),
      ),
    );
  }
}