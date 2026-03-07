/*import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/entities/user.dart';

final currentUserProvider = StateProvider<User?>((ref) => null);*/
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/entities/user.dart';

final currentUserProvider =
StateNotifierProvider<CurrentUserNotifier, User?>(
      (ref) => CurrentUserNotifier(),
);

class CurrentUserNotifier extends StateNotifier<User?> {
  CurrentUserNotifier() : super(null) {
    _loadSavedAvatar();
  }

  Future<void> _loadSavedAvatar() async {
    final prefs = await SharedPreferences.getInstance();
    final avatar = prefs.getString("user_avatar");

    if (avatar != null && state != null) {
      state = state!.copyWith(avatarUrl: avatar);
    }
  }

  void setUser(User user) {
    state = user;
  }

  void updateAvatar(String path) {
    if (state == null) return;
    state = state!.copyWith(avatarUrl: path);
  }
}