/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

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
}*/
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

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
      backgroundColor: Colors.transparent,
      builder: (_) {

        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[850]  // لون مناسب للدارك مود
                : Colors.white,      // لون مناسب لللايت مود
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(25),
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              _option(
                context,
                icon: Icons.camera_alt,
                label: "Camera",
                onTap: onOpenCamera,
                // اختياري: تغيير لون النص أو الأيقونات حسب الوضع
              ),

              _option(
                context,
                icon: Icons.insert_drive_file,
                label: "File",
                onTap: onPickFile,
                // اختياري: تغيير لون النص أو الأيقونات حسب الوضع
              ),

            ],
          ),
        );
      },
    );
  }

  Widget _option(
      BuildContext context, {
        required IconData icon,
        required String label,
        required VoidCallback onTap,
      }) {

    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),

          const SizedBox(height: 6),

          Text(label),

        ],
      ),
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