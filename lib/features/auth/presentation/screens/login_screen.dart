/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/entities/user.dart';
import '../providers/auth_providers.dart';
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

    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.isSuccess && next.user != null) {
        switch (next.user!.role) {
          case UserRole.admin:
            openAdminPanel();
            break;

          case UserRole.teacher:
          case UserRole.parent:
            context.go('/home');
            break;
        }
      }
    });

    final state = ref.watch(authProvider);
    final notifier = ref.read(authProvider.notifier);

    return Directionality(
        textDirection: TextDirection.ltr,
        child: Localizations.override(
          context: context,
          locale: const Locale('en'),
          child: Scaffold(
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
                onChanged: (value) {
                  ref.read(authProvider.notifier).validateEmail(value);
                },
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
                onChanged: (value) {
                  ref.read(authProvider.notifier).validatePassword(value);
                },
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

                  notifier.validateRole(value);
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

              SizedBox(height: 30.h),

              Center(
                child: Column(
                  children: [
                    SvgPicture.asset(
                      "assets/images/undraw_secure-login_m11a (1).svg",
                      width: 120.w,
                    ),

                    SizedBox(height: 10.h),

                    Text(
                      "Secure access for authorized users",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              )

// TODO: Social login removed as per product decision (Closed system)
              //const SocialLoginSection(),
            ],
          ),
        ),
      ),
    ),
    ));
  }
}*/
/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/entities/user.dart';
import '../providers/auth_providers.dart';
import '../providers/auth_state.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/account_type_dropdown.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? selectedAccountType;
  final List<String> accountTypes = ['Admin', 'Teacher', 'Parent'];

  bool _obscurePassword = true;

  double _opacity = 0;
  double _translateY = 40;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _opacity = 1;
        _translateY = 0;
      });
    });
  }

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

    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.isSuccess && next.user != null) {
        switch (next.user!.role) {
          case UserRole.admin:
            openAdminPanel();
            break;
          case UserRole.teacher:
          case UserRole.parent:
            context.go('/home');
            break;
        }
      }
    });

    final state = ref.watch(authProvider);
    final notifier = ref.read(authProvider.notifier);

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Localizations.override(
        context: context,
        locale: const Locale('en'),
        child: Scaffold(
          resizeToAvoidBottomInset: true, // 🔥 مهم مع الكيبورد
          body: Container(
            width: double.infinity,
            height: double.infinity,

            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFEAF4FF),
                  Colors.white,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),

            child: SafeArea(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 800),
                opacity: _opacity,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 800),
                  transform: Matrix4.translationValues(0, _translateY, 0),

                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),

                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height,
                      ),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          /*SvgPicture.asset(
                            "assets/images/undraw_secure-login_m11a (1).svg",
                            width: 140.w,
                          ),*/

                          //SizedBox(height: 20.h),

                          Text(
                            "Welcome Back 👋",
                            style: TextStyle(
                              fontSize: 32.sp,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0B2545),
                            ),
                          ),

                          SizedBox(height: 6.h),

                          Text(
                            "Login to continue",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey,
                            ),
                          ),

                          SizedBox(height: 30.h),

                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 25,
                                  offset: Offset(0, 10),
                                ),
                              ],
                            ),

                            child: Column(
                              children: [
                                /*Center(
                                  child: Container(
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 15,
                                          offset: Offset(0, 6),
                                        ),
                                      ],
                                      border: Border.all(
                                        color: Color(0xFFEAF4FF),
                                        width: 3,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: SvgPicture.asset(
                                        "assets/icons/avatar-user-svgrepo-com.svg",
                                        fit: BoxFit.contain,
                                        colorFilter: const ColorFilter.mode(
                                          Color(0xFF1B4D89), // نفس لون الـ button
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),*/

                                AuthTextField(
                                  label: "Email Address",
                                  controller: _emailController,
                                  errorText: state.emailError,
                                  onChanged: (value) {
                                    notifier.validateEmail(value);
                                  },
                                ),

                                SizedBox(height: 14.h),

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
                                  onChanged: (value) {
                                    notifier.validatePassword(value);
                                  },
                                ),

                                SizedBox(height: 14.h),

                                /*AccountTypeDropdown(
                                  value: selectedAccountType,
                                  items: accountTypes,
                                  errorText: state.accountError,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedAccountType = value;
                                    });
                                    notifier.validateRole(value);
                                  },
                                ),*/
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: AccountTypeDropdown(
                                    value: selectedAccountType,
                                    items: accountTypes,
                                    errorText: state.accountError,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedAccountType = value;
                                      });
                                      notifier.validateRole(value);
                                    },
                                  ),
                                ),

                                SizedBox(height: 20.h),

                                Container(
                                  width: double.infinity,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF0B2545),
                                        Color(0xFF1B4D89),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                    ),
                                    onPressed: () {
                                      notifier.login(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                        role: selectedAccountType,
                                      );
                                    },
                                    child: state.isLoadingLogin
                                        ? const CircularProgressIndicator(color: Colors.white)
                                        : const Text(
                                      "Login",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 20.h),

                          Text(
                            "Secure access for authorized users",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}*/
/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/entities/user.dart';
import '../providers/auth_providers.dart';
import '../providers/auth_state.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/account_type_dropdown.dart';

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
  Widget build(BuildContext context) {

    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.isSuccess && next.user != null) {
        switch (next.user!.role) {
          case UserRole.admin:
            break;
          case UserRole.teacher:
          case UserRole.parent:
            context.go('/home');
            break;
        }
      }
    });

    final state = ref.watch(authProvider);
    final notifier = ref.read(authProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [

              SizedBox(height: 40.h),

              /// 🧠 LOGO
              Image.asset(
                "assets/images/app_icon.png",
                height: 70,
              ),

              SizedBox(height: 20.h),

              Text(
                "Welcome Back",
                style: TextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1B4D89),
                ),
              ),

              SizedBox(height: 6.h),

              Text(
                "Login to your account",
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),

              SizedBox(height: 30.h),

              /// 👇 Card
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [

                    /// 👤 Avatar
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAF4FF),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Color(0xFF1B4D89),
                        size: 35,
                      ),
                    ),

                    SizedBox(height: 20.h),

                    /// 📧 Email
                    AuthTextField(
                      label: "Email",
                      controller: _emailController,
                      errorText: state.emailError,
                      onChanged: notifier.validateEmail,
                    ),

                    SizedBox(height: 14.h),

                    /// 🔒 Password
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

                    SizedBox(height: 14.h),

                    /// 👇 Account Type
                    AccountTypeDropdown(
                      value: selectedAccountType,
                      items: accountTypes,
                      errorText: state.accountError,
                      onChanged: (value) {
                        setState(() {
                          selectedAccountType = value;
                        });
                        notifier.validateRole(value);
                      },
                    ),

                    SizedBox(height: 25.h),

                    /// 🚀 Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1B4D89),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          notifier.login(
                            email: _emailController.text,
                            password: _passwordController.text,
                            role: selectedAccountType,
                          );
                        },
                        child: state.isLoadingLogin
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              Text(
                "Secure access for authorized users",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/entities/user.dart';
import '../providers/auth_providers.dart';
import '../providers/auth_state.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/account_type_dropdown.dart';

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
  Widget build(BuildContext context) {

    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.isSuccess && next.user != null) {
        switch (next.user!.role) {
          case UserRole.admin:
            break;
          case UserRole.teacher:
          case UserRole.parent:
            context.go('/home');
            break;
        }
      }
    });

    final state = ref.watch(authProvider);
    final notifier = ref.read(authProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: Stack(
        children: [

          /// 🔷 HEADER
          Container(
            height: 300,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF1B4D89),
                  Color(0xFF3A7BD5),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 60.h),

                /// 👤 Avatar
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.2),
                  ),
                  child:  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Image.asset(
                      "assets/images/app_icon.png",
                      height: 40,
                    ),
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

          /// 🧊 FORM
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.65,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    /// 📧 Email
                    AuthTextField(
                      label: "Email",
                      controller: _emailController,
                      errorText: state.emailError,
                      //prefixIcon: const Icon(Icons.email_outlined),
                      onChanged: notifier.validateEmail,
                    ),

                    SizedBox(height: 16.h),

                    /// 🔒 Password
                    AuthTextField(
                      label: "Password",
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      errorText: state.passwordError,
                      //prefixIcon: const Icon(Icons.lock_outline),
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

                    /// 👇 Account Type
                    AccountTypeDropdown(
                      value: selectedAccountType,
                      items: accountTypes,
                      errorText: state.accountError,
                      onChanged: (value) {
                        setState(() {
                          selectedAccountType = value;
                        });
                        notifier.validateRole(value);
                      },
                    ),

                    SizedBox(height: 30.h),

                    /// 🚀 BUTTON (Gradient 🔥)
                    GestureDetector(
                      onTap: () {
                        notifier.login(
                          email: _emailController.text,
                          password: _passwordController.text,
                          role: selectedAccountType,
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
                              ? const CircularProgressIndicator(color: Colors.white)
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
    );
  }
}