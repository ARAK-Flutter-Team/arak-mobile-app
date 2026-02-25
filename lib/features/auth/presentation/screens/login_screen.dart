import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/theme/app_colors.dart';
import '../providers/auth_notifier.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? selectedAccountType;
  final List<String> accountTypes = ['Admin', 'Teacher', 'Parent'];

  bool _obscurePassword = true;

  InputDecoration _inputDecoration({
    required String label,
    String? errorText,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h), // قللنا الارتفاع
      filled: true,
      fillColor: AppColors.coloredFilled,
      label: RichText(
        text: TextSpan(
          text: label,
          style: TextStyle(color: AppColors.gray, fontFamily: 'Inter'),
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
        borderSide: BorderSide(color: AppColors.primaryBlue, width: 1.w),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: AppColors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: AppColors.red, width: 1.5.w),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h), // قللنا padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "welcome back!",
                style: TextStyle(
                  fontFamily: 'Teko',
                  fontSize: 50.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondary,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "keep in touch with us",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14.sp,
                  color: AppColors.secondary,
                ),
              ),
              SizedBox(height: 24.h),

              // Email
              TextField(
                controller: _emailController,
                obscuringCharacter: '*',
                decoration: _inputDecoration(
                  label: "Email Address",
                  errorText: authState.emailError,
                ),
                onChanged: (value) {
                  ref.read(authProvider.notifier).validateEmail(value);
                },
              ),
              SizedBox(height: 12.h),

              // Password
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                obscuringCharacter: '*',
                decoration: _inputDecoration(
                  label: "Password",
                  errorText: authState.passwordError,
                ),
                onChanged: (value) {
                  ref.read(authProvider.notifier).validatePassword(value);
                },
              ),
              SizedBox(height: 12.h),

              // Dropdown
              DropdownButtonFormField<String>(
                value: selectedAccountType,
                decoration: _inputDecoration(
                  label: "Account Type",
                  errorText: authState.accountError,
                ),
                items: accountTypes
                    .map((type) => DropdownMenuItem(
                  value: type,
                  child: Text(type),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedAccountType = value;
                  });

                  ref.read(authProvider.notifier).clearAccountError();
                },
              ),
              SizedBox(height: 16.h),

              // Login Button
              SizedBox(
                width: double.infinity,
                height: 48.h, // قللنا ارتفاع الزر
                child: ElevatedButton(
                  onPressed: authState.isLoading
                      ? null
                      : () async {
                    await authNotifier.login(
                      email: _emailController.text,
                      password: _passwordController.text,
                      role: selectedAccountType,
                    );
                    if (ref.read(authProvider).isSuccess) {
                      context.go('/main');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: authState.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                    "login",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}