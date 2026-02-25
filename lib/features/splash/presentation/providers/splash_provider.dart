import 'package:flutter_riverpod/flutter_riverpod.dart';

final splashProvider = Provider<SplashLogic>((ref) {
  return SplashLogic();
});

class SplashLogic {
  Future<void> initializeApp() async {
    await Future.delayed(const Duration(seconds: 3));
  }
}