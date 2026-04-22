import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/entities/user.dart';

final currentUserProvider = StateNotifierProvider<CurrentUserNotifier, User?>(
  (ref) => CurrentUserNotifier(),
);

class CurrentUserNotifier extends StateNotifier<User?> {
  CurrentUserNotifier() : super(null);

  // ✅ الفانكشن الوحيدة اللي لازم تتنادى لما يتسجل اليوزر
  Future<void> setUser(User user) async {
    state = user;
    await _loadSavedAvatar(user.id);
  }

  Future<void> _loadSavedAvatar(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    final avatar = prefs.getString("user_avatar_$userId");
    if (avatar != null && state != null) {
      state = state!.copyWith(avatarUrl: avatar);
    }
  }

  void updateAvatar(String path) {
    if (state == null) return;
    state = state!.copyWith(avatarUrl: path);
  }
}
