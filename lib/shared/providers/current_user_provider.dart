import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/entities/user.dart';

final currentUserProvider = StateNotifierProvider<CurrentUserNotifier, User?>(
  (ref) => CurrentUserNotifier(),
);

class CurrentUserNotifier extends StateNotifier<User?> {
  CurrentUserNotifier() : super(null);

  // ✅ setUser بيحفظ الـ user كما جاء من الـ API مباشرة
  // الـ avatarUrl بيجي من الـ Backend مع بيانات الـ User عند الـ login
  void setUser(User user) {
    state = user;
  }

  void updateAvatar(String url) {
    if (state == null) return;
    state = state!.copyWith(avatarUrl: url);
  }

  void clearUser() {
    state = null;
  }
}
