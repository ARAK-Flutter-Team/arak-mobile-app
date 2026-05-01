import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'current_user_provider.dart';
import 'image_picker_provider.dart';
import '../../features/profile/data/upload_repository.dart';

class ProfileImageNotifier extends StateNotifier<AsyncValue<void>> {
  final Ref ref;
  ProfileImageNotifier(this.ref) : super(const AsyncData(null));

  Future<void> pickFromGallery() async {
    final path = await ref.read(imagePickerProvider).pickFromGallery();
    if (path == null) return;
    await _uploadAndSave(path);
  }

  Future<void> pickFromCamera() async {
    final path = await ref.read(imagePickerProvider).pickFromCamera();
    if (path == null) return;
    await _uploadAndSave(path);
  }

  Future<void> _uploadAndSave(String localPath) async {
    state = const AsyncLoading();
    try {
      // 1️⃣ ارفع على السيرفر واجيب الـ URL
      final serverUrl =
          await ref.read(uploadRepositoryProvider).uploadPhoto(localPath);

      // 2️⃣ حدّث الـ user في الـ state
      final user = ref.read(currentUserProvider);
      if (user == null) return;
      ref.read(currentUserProvider.notifier).updateAvatar(serverUrl);

      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final profileImageProvider =
    StateNotifierProvider<ProfileImageNotifier, AsyncValue<void>>((ref) {
  return ProfileImageNotifier(ref);
});
