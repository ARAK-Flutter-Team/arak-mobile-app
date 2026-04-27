import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../shared/providers/current_user_provider.dart';
import '../../../../shared/providers/profile_image_provider.dart';

class ProfileImage extends ConsumerWidget {
  const ProfileImage({super.key, this.radius = 50});

  final double radius;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    ImageProvider imageProvider;

    final avatarUrl = user?.avatarUrl;

    if (avatarUrl != null && avatarUrl.isNotEmpty) {
      if (avatarUrl.startsWith('http')) {
        // ✅ صورة من السيرفر
        imageProvider = NetworkImage(avatarUrl);
      } else if (avatarUrl.startsWith('/') || avatarUrl.contains('storage')) {
        // ✅ صورة من الجاليري أو الكاميرا (local path)
        imageProvider = FileImage(File(avatarUrl));
      } else {
        // ❌ قيمة غلط زي "JP" → صورة افتراضية
        imageProvider = const AssetImage('assets/images/download(1).jpg');
      }
    } else {
      imageProvider = const AssetImage('assets/images/download(1).jpg');
    }

    return Stack(
      children: [
        CircleAvatar(
          radius: radius.r,
          backgroundImage: imageProvider,
        ),
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
