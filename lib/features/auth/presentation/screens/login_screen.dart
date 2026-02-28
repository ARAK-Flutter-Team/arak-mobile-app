import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/user.dart';
import '../providers/auth_notifier.dart';
import '../providers/auth_state.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/account_type_dropdown.dart';
import '../widgets/login_button.dart';
import 'package:url_launcher/url_launcher.dart';

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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  Future<void> openAdminPanel() async {
    final Uri url = Uri.parse("https://admin.yoursite.com");

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception("Could not launch $url");
    }
  }
  @override
  Widget build(BuildContext context) {

    @override
    void initState() {
      super.initState();

      ref.listen<AuthState>(authProvider, (previous, next) {
        if (next.isSuccess && next.user != null) {
          switch (next.user!.role) {
            case UserRole.admin:
              openAdminPanel();
              break;

            case UserRole.teacher:
              context.go('/teacherHome');
              break;

            case UserRole.parent:
              context.go('/parentHome');
              break;
          }
        }
      });
    }

    final state = ref.watch(authProvider);
    final notifier = ref.read(authProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "welcome back!",
                style: TextStyle(
                  fontFamily: 'Teko',
                  fontSize: 50.sp,

                  color: Color(0xFF0B2545),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "keep in touch with us",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14.sp,
                  color: Color(0xFF0B2545),
                ),
              ),
              SizedBox(height: 24.h),

              AuthTextField(
                label: "Email Address",
                controller: _emailController,
                errorText: state.emailError,
                onChanged: (value) => notifier.validateEmail(value),
              ),
              SizedBox(height: 12.h),

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
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                onChanged: (value) => notifier.validatePassword(value),
              ),
              SizedBox(height: 12.h),

              AccountTypeDropdown(
                value: selectedAccountType,
                items: accountTypes,
                errorText: state.accountError,
                onChanged: (value) {
                  setState(() {
                    selectedAccountType = value;
                  });
                  notifier.clearAccountError();
                },
              ),
              SizedBox(height: 16.h),

              LoginButton(
                isLoading: state.isLoadingLogin,
                onPressed: () {
                  notifier.login(
                    email: _emailController.text,
                    password: _passwordController.text,
                    role: selectedAccountType,
                  );
                },
              ),

              SizedBox(height: 24.h),
              Column(
                children: [
                  SizedBox(height: 16.h),
                  Text(
                    "Username and password are provided by school administration.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    "For assistance, please contact: 01012345678",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue,
                    ),
                  ),
                ],
              )
// TODO: Social login removed as per product decision (Closed system)
              //const SocialLoginSection(),
            ],
          ),
        ),
      ),
    );
  }
}