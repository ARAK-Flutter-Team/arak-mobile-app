import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'current_user_provider.dart';
import 'image_picker_provider.dart';

class ProfileImageNotifier extends StateNotifier<void> {
  final Ref ref;

  ProfileImageNotifier(this.ref) : super(null);

  Future<void> pickFromGallery() async {
    final picker = ref.read(imagePickerProvider);
    final path = await picker.pickFromGallery();

    if (path == null) return;

    await _saveImage(path);
  }

  Future<void> pickFromCamera() async {
    final picker = ref.read(imagePickerProvider);
    final path = await picker.pickFromCamera();

    if (path == null) return;

    await _saveImage(path);
  }

  Future<void> _saveImage(String path) async {
    final user = ref.read(currentUserProvider);

    if (user == null) return;

    //final updatedUser = user.copyWith(avatarUrl: path);

    ref.read(currentUserProvider.notifier).updateAvatar(path);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("user_avatar", path);
  }
}

final profileImageProvider =
    StateNotifierProvider<ProfileImageNotifier, void>((ref) {
  return ProfileImageNotifier(ref);
});
