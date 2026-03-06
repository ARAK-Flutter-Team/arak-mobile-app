import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class PlusButton extends ConsumerWidget {
  final VoidCallback onPickImage;
  final VoidCallback onPickFile;
  final VoidCallback onOpenCamera;

  const PlusButton({
    super.key,
    required this.onPickImage,
    required this.onPickFile,
    required this.onOpenCamera,
  });

  void _showPlusOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Theme.of(context).dividerColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              ListTile(
                leading: Icon(Icons.camera_alt, color: Theme.of(context).colorScheme.primary),
                title: const Text("Camera"),
                onTap: () {
                  Navigator.pop(context);
                  onOpenCamera();
                },
              ),
              ListTile(
                leading: Icon(Icons.insert_drive_file, color: Theme.of(context).colorScheme.primary),
                title: const Text("File"),
                onTap: () {
                  Navigator.pop(context);
                  onPickFile();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: SvgPicture.asset("assets/icons/plus.svg", width: 22),
      onPressed: () => _showPlusOptions(context),
    );
  }
}