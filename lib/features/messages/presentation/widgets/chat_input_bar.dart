/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../shared/theme/app_colors.dart';
import '../providers/chat_provider.dart';

class ChatInputBar extends ConsumerStatefulWidget {

  final String senderId;
  final String receiverId;

  const ChatInputBar({
    super.key,
    required this.senderId,
    required this.receiverId,
  });

  @override
  ConsumerState<ChatInputBar> createState() =>
      _ChatInputBarState();
}

class _ChatInputBarState extends ConsumerState<ChatInputBar> {

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final notifier =
    ref.read(chatNotifierProvider.notifier);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8),

        child: Row(
          children: [

            Expanded(
              child: TextField(
                controller: controller,

                decoration: InputDecoration(
                  hintText: "Type message...",

                  contentPadding:
                  const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(29),
                    borderSide: const BorderSide(
                      color: AppColors.strokeColor,
                    ),
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(29),
                    borderSide: const BorderSide(
                      color: AppColors.strokeColor,
                    ),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(29),
                    borderSide: const BorderSide(
                      color: AppColors.strokeColor,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 8),

            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/Frame.svg",
                width: 24,
                height: 24,
              ),

              onPressed: () {

                if (controller.text.trim().isEmpty) return;

                notifier.sendMessage(
                  senderId: widget.senderId,
                  receiverId: widget.receiverId,
                  text: controller.text.trim(),
                );

                controller.clear();
              },
            ),
          ],
        ),
      ),
    );
  }
}*/
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../shared/theme/app_colors.dart';
import '../providers/chat_provider.dart';

class ChatInputBar extends ConsumerStatefulWidget {
  final String senderId;
  final String receiverId;

  const ChatInputBar({
    super.key,
    required this.senderId,
    required this.receiverId,
  });

  @override
  ConsumerState<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends ConsumerState<ChatInputBar> {
  final TextEditingController controller = TextEditingController();

  /// اختيار صورة
  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();

      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        print("Image selected: ${image.path}");
      } else {
        print("User cancelled");
      }

    } catch (e) {
      print("Error picking image: $e");
    }
  }

  /// اختيار ملف
  Future<void> _pickFile() async {

    print("FILE CLICKED");

    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result == null) {
      print("No file selected");
      return;
    }

    final file = result.files.single;

    print("File selected: ${file.name}");
  }
  Future<void> _openCamera() async {

    print("CAMERA CLICKED");

    final status = await Permission.camera.request();

    if (!status.isGranted) {
      print("Camera permission denied");
      return;
    }

    final picker = ImagePicker();

    final image = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (image == null) {
      print("No photo taken");
      return;
    }

    print("Camera image: ${image.path}");
  }
  void _showPlusOptions() {

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),

      builder: (context) {

        return SafeArea(
          child:
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle صغير أعلى الـ BottomSheet
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Theme.of(context).dividerColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // زر الكاميرا
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: Material(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Navigator.pop(context);
                      _openCamera();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(12),
                            child: Icon(Icons.camera_alt, color: Theme.of(context).colorScheme.primary),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            "Camera",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // زر اختيار الملفات
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: Material(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Navigator.pop(context);
                      _pickFile();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(12),
                            child: Icon(Icons.insert_drive_file, color: Theme.of(context).colorScheme.primary),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            "File",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
          /*Column(
            mainAxisSize: MainAxisSize.min,

            children: [

              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Camera"),

                onTap: () {
                  Navigator.pop(context);
                  _openCamera();
                },
              ),

              ListTile(
                leading: const Icon(Icons.insert_drive_file),
                title: const Text("File"),

                onTap: () {
                  Navigator.pop(context);
                  _pickFile();
                },
              ),
            ],
          ),*/
        );

      },
    );
  }
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(chatNotifierProvider.notifier);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [


            /// زر البلص
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/plus.svg",
                width: 22,
              ),
              onPressed: _showPlusOptions,
            ),

            /// زر الصورة
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/Image fill.svg",
                width: 22,
              ),
              onPressed: _pickImage,
            ),

            /// حقل الكتابة
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: "Type message...",
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(29),
                    borderSide: const BorderSide(
                      color: AppColors.strokeColor, // هنا اللون الأزرق للـ border
                      width: 1, // ممكن تغيري السماكة لو تحبي
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(29),
                    borderSide: const BorderSide(
                      color: AppColors.strokeColor, // نفس اللون لما الـ TextField يكون متفاعل
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 8),

            /// زر الارسال
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/Frame.svg",
                width: 24,
                height: 24,
              ),
              onPressed: () {
                if (controller.text.trim().isEmpty) return;

                notifier.sendMessage(
                  senderId: widget.senderId,
                  receiverId: widget.receiverId,
                  text: controller.text.trim(),
                );

                controller.clear();
              },
            ),
          ],
        ),
      ),
    );
  }
}