import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/entities/user.dart';
import '../providers/auth_providers.dart';
import '../providers/auth_state.dart';
import '../widgets/auth_text_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.isSuccess && next.user != null) {
        switch (next.user!.role) {
          case UserRole.teacher:
          case UserRole.parent:
            context.go('/home');
            break;
          default:
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Unauthorized role"),
              ),
            );
        }
      }
    });

    final state = ref.watch(authProvider);
    final notifier = ref.read(authProvider.notifier);

    return Directionality(
      textDirection: TextDirection.ltr,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color(0xFFF5F7FB),
          body: Stack(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF1B4D89),
                      Color(0xFF3A7BD5),
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 60.h),
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: Image.asset(
                        "assets/images/app_icon.png",
                        height: 40,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    const Text(
                      "Welcome Back",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Login to your account",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.65,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 25,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        AuthTextField(
                          label: "Email",
                          controller: _emailController,
                          errorText: state.emailError,
                          onChanged: notifier.validateEmail,
                        ),
                        SizedBox(height: 16.h),
                        AuthTextField(
                          label: "Password",
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          errorText: state.passwordError,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          onChanged: notifier.validatePassword,
                        ),
                        SizedBox(height: 16.h),
                        SizedBox(height: 16.h),
                        SizedBox(height: 20.h),
                        if (state.generalError != null)
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              state.generalError!,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        SizedBox(height: 25.h),
                        GestureDetector(
                          onTap: state.isLoadingLogin
                              ? null
                              : () {
                            notifier.login(
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: 55,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF1B4D89),
                                  Color(0xFF3A7BD5),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Center(
                              child: state.isLoadingLogin
                                  ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                                  : const Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
