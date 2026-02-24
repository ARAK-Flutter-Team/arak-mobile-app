import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// -------------------
// Provider
// -------------------
final splashProvider = Provider<SplashProvider>((ref) {
  return SplashProvider();
});

class SplashProvider {
  void startApp(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    });
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Login Screen')),
    );
  }
}