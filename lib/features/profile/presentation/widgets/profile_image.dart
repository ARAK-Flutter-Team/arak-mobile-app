import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/providers/current_user_provider.dart';
import '../../../../shared/providers/profile_image_provider.dart';

class ProfileImage extends ConsumerWidget {
  const ProfileImage({super.key, this.radius = 50});

  final double radius;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    return Stack(
      children: [
        CircleAvatar(
          radius: radius.r,
          backgroundImage: user?.avatarUrl != null
              ? FileImage(File(user!.avatarUrl!)) as ImageProvider
              : const AssetImage('assets/images/download(1).jpg'),
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
              title: const Text("Choose from Gallery"),
              onTap: () {
                ref.read(profileImageProvider.notifier).pickFromGallery();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text("Take Photo"),
              onTap: () {
                ref.read(profileImageProvider.notifier).pickFromCamera();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.close),
              title: const Text("Cancel"),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}