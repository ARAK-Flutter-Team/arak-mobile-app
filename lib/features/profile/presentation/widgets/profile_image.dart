import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../shared/providers/current_user_provider.dart';
import '../../../../shared/providers/profile_image_provider.dart';

// ✅ حط الـ IP بتاعك هنا
const String _baseUrl = 'http://YOUR_IP:7000';

class ProfileImage extends ConsumerWidget {
  const ProfileImage({super.key, this.radius = 50});

  final double radius;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final uploadState = ref.watch(profileImageProvider);

    ref.listen<AsyncValue<void>>(profileImageProvider, (_, next) {
      if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('فشل رفع الصورة، حاول مرة أخرى'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });

    // ✅ الإصلاح: بنبني الـ full URL سواء كان relative أو absolute
    final rawUrl = user?.avatarUrl;
    ImageProvider imageProvider;

    if (rawUrl != null && rawUrl.isNotEmpty) {
      final fullUrl = rawUrl.startsWith('http') ? rawUrl : '$_baseUrl$rawUrl';
      imageProvider = NetworkImage(fullUrl);
    } else {
      imageProvider = const AssetImage('assets/images/download(1).jpg');
    }

    return Stack(
      children: [
        CircleAvatar(
          radius: radius.r,
          backgroundImage: imageProvider,
        ),
        if (uploadState is AsyncLoading)
          Positioned.fill(
            child: CircleAvatar(
              radius: radius.r,
              backgroundColor: Colors.black45,
              child: const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            ),
          ),
        if (uploadState is! AsyncLoading)
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => _showPickerOptions(context, ref),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(6),
                child: Icon(
                  Icons.camera_alt,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 18.sp,
                ),
              ),
            ),
          ),
      ],
    );
  }

  void _showPickerOptions(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text(AppLocalizations.of(context)!.chooseFromGallery),
              onTap: () {
                ref.read(profileImageProvider.notifier).pickFromGallery();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: Text(AppLocalizations.of(context)!.takePhoto),
              onTap: () {
                ref.read(profileImageProvider.notifier).pickFromCamera();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.close),
              title: Text(AppLocalizations.of(context)!.cancel),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
