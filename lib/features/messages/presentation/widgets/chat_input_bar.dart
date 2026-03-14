/*import 'dart:async';
import 'package:arak_app/features/messages/presentation/widgets/plus_button.dart';
import 'package:arak_app/features/messages/presentation/widgets/send_or_mic_button.dart';
import 'package:arak_app/features/messages/presentation/widgets/image_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
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

  bool hasText = false;

  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool isRecording = false;

  String? recordedFilePath;

  Duration recordingDuration = Duration.zero;

  Timer? _timer;

  final FlutterSoundPlayer _player = FlutterSoundPlayer();

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      setState(() {
        hasText = controller.text.trim().isNotEmpty;
      });
    });

    _openRecorder();
    _player.openPlayer();
  }

  Future<void> _openRecorder() async {
    await _recorder.openRecorder();
  }

  @override
  void dispose() {
    controller.dispose();
    _recorder.closeRecorder();
    _player.closePlayer();
    _timer?.cancel();
    super.dispose();
  }

  //========================
  // SEND TEXT
  //========================

  void _sendText() {
    if (controller.text.trim().isEmpty) return;

    ref.read(chatControllerProvider.notifier).sendTextMessage(
      senderId: widget.senderId,
      receiverId: widget.receiverId,
      text: controller.text.trim(),
    );

    controller.clear();
  }

  //========================
  // RECORD
  //========================

  Future<void> _toggleRecording() async {
    final status = await Permission.microphone.request();

    if (!status.isGranted) return;

    if (!isRecording) {

      final dir = await getTemporaryDirectory();

      recordedFilePath =
      '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.aac';

      await _recorder.startRecorder(
        toFile: recordedFilePath,
        codec: Codec.aacADTS,
      );

      setState(() {
        isRecording = true;
        recordingDuration = Duration.zero;
      });

      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          recordingDuration += const Duration(seconds: 1);
        });
      });

    } else {

      await _recorder.stopRecorder();

      _timer?.cancel();

      setState(() {
        isRecording = false;
      });

      await _sendRecordedVoice();
    }
  }

  //========================
  // SEND VOICE
  //========================

  Future<void> _sendRecordedVoice() async {
    if (isRecording) {
      await _recorder.stopRecorder();
    }

    _timer?.cancel();

    setState(() {
      isRecording = false;
    });

    if (recordedFilePath != null) {
      ref.read(chatControllerProvider.notifier).sendVoiceMessage(
        senderId: widget.senderId,
        receiverId: widget.receiverId,
        filePath: recordedFilePath!,
        duration: recordingDuration.inSeconds,
      );
    }

    recordedFilePath = null;
    recordingDuration = Duration.zero;
  }

  //========================
  // CANCEL RECORD
  //========================

  Future<void> _cancelRecording() async {
    await _recorder.stopRecorder();

    _timer?.cancel();

    setState(() {
      isRecording = false;
      recordedFilePath = null;
      recordingDuration = Duration.zero;
    });
  }

  //========================
  // SEND BUTTON LOGIC
  //========================

  void _handleSend() {
    if (hasText) {
      _sendText();
      return;
    }

    if (recordedFilePath != null) {
      _sendRecordedVoice();
      return;
    }
  }

  //========================
  // IMAGE
  //========================

  Future<void> _pickImage() async {
    final picker = ImagePicker();

    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {
      ref.read(chatControllerProvider.notifier).sendImageMessage(
        senderId: widget.senderId,
        receiverId: widget.receiverId,
        filePath: image.path,
      );
    }
  }

  //========================
  // FILE
  //========================

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.any);

    if (result != null && result.files.single.path != null) {
      ref.read(chatControllerProvider.notifier).sendFileMessage(
        senderId: widget.senderId,
        receiverId: widget.receiverId,
        filePath: result.files.single.path!,
      );
    }
  }

  //========================
  // CAMERA
  //========================

  Future<void> _openCamera() async {
    final status = await Permission.camera.request();

    if (!status.isGranted) return;

    final picker = ImagePicker();

    final XFile? image =
    await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      ref.read(chatControllerProvider.notifier).sendImageMessage(
        senderId: widget.senderId,
        receiverId: widget.receiverId,
        filePath: image.path,
      );
    }
  }

  //========================
  // UI
  //========================

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            PlusButton(
              onPickImage: _pickImage,
              onPickFile: _pickFile,
              onOpenCamera: _openCamera,
            ),

            ImageButton(onPickImage: _pickImage),

           /* Expanded(
              child: TextField(
                controller: controller,
                minLines: 1,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Type message...",
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(29),
                    borderSide: const BorderSide(
                      color: AppColors.strokeColor,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(29),
                    borderSide: const BorderSide(
                      color: AppColors.strokeColor,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),*/
            if (isRecording)
              Expanded(
                child: Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(.08),
                    borderRadius: BorderRadius.circular(29),
                    border: Border.all(
                      color: AppColors.strokeColor,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.mic, color: Colors.red),
                      const SizedBox(width: 8),

                      const Text(
                        "Recording...",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),

                      const Spacer(),

                      Text(
                        "${recordingDuration.inMinutes.toString().padLeft(2, '0')}:"
                            "${(recordingDuration.inSeconds % 60).toString().padLeft(2, '0')}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              Expanded(
                child: TextField(
                  controller: controller,
                  minLines: 1,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Type message...",
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(29),
                      borderSide: const BorderSide(
                        color: AppColors.strokeColor,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(29),
                      borderSide: const BorderSide(
                        color: AppColors.strokeColor,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
            const SizedBox(width: 8),

            SendOrMicButton(
              hasText: hasText,
              isRecording: isRecording,
              recordingDuration: recordingDuration,
              onSend: _handleSend,
              onRecord: _toggleRecording,
              onCancelRecording: _cancelRecording,
            ),
          ],
        ),
      ),
    );
  }
}*/
import 'dart:async';
import 'package:arak_app/features/messages/presentation/widgets/plus_button.dart';
import 'package:arak_app/features/messages/presentation/widgets/send_or_mic_button.dart';
import 'package:arak_app/features/messages/presentation/widgets/image_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
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

  bool hasText = false;

  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool isRecording = false;

  String? recordedFilePath;

  Duration recordingDuration = Duration.zero;

  Timer? _timer;

  final FlutterSoundPlayer _player = FlutterSoundPlayer();

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      setState(() {
        hasText = controller.text.trim().isNotEmpty;
      });
    });

    _openRecorder();
    _player.openPlayer();
  }

  Future<void> _openRecorder() async {
    await _recorder.openRecorder();
  }

  @override
  void dispose() {
    controller.dispose();
    _recorder.closeRecorder();
    _player.closePlayer();
    _timer?.cancel();
    super.dispose();
  }

  void _sendText() {
    if (controller.text.trim().isEmpty) return;

    ref.read(chatControllerProvider.notifier).sendTextMessage(
      senderId: widget.senderId,
      receiverId: widget.receiverId,
      text: controller.text.trim(),
    );

    controller.clear();
  }

  Future<void> _toggleRecording() async {
    final status = await Permission.microphone.request();

    if (!status.isGranted) return;

    if (!isRecording) {
      final dir = await getTemporaryDirectory();

      recordedFilePath =
      '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.aac';

      await _recorder.startRecorder(
        toFile: recordedFilePath,
        codec: Codec.aacADTS,
      );

      setState(() {
        isRecording = true;
        recordingDuration = Duration.zero;
      });

      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          recordingDuration += const Duration(seconds: 1);
        });
      });
    } else {
      await _recorder.stopRecorder();

      _timer?.cancel();

      setState(() {
        isRecording = false;
      });

      await _sendRecordedVoice();
    }
  }

  Future<void> _sendRecordedVoice() async {
    if (isRecording) {
      await _recorder.stopRecorder();
    }

    _timer?.cancel();

    setState(() {
      isRecording = false;
    });

    if (recordedFilePath != null) {
      ref.read(chatControllerProvider.notifier).sendVoiceMessage(
        senderId: widget.senderId,
        receiverId: widget.receiverId,
        filePath: recordedFilePath!,
        duration: recordingDuration.inSeconds,
      );
    }

    recordedFilePath = null;
    recordingDuration = Duration.zero;
  }

  Future<void> _cancelRecording() async {
    await _recorder.stopRecorder();

    _timer?.cancel();

    setState(() {
      isRecording = false;
      recordedFilePath = null;
      recordingDuration = Duration.zero;
    });
  }

  void _handleSend() {
    if (hasText) {
      _sendText();
      return;
    }

    if (recordedFilePath != null) {
      _sendRecordedVoice();
      return;
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();

    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {
      ref.read(chatControllerProvider.notifier).sendImageMessage(
        senderId: widget.senderId,
        receiverId: widget.receiverId,
        filePath: image.path,
      );
    }
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.any);

    if (result != null && result.files.single.path != null) {
      ref.read(chatControllerProvider.notifier).sendFileMessage(
        senderId: widget.senderId,
        receiverId: widget.receiverId,
        filePath: result.files.single.path!,
      );
    }
  }

  Future<void> _openCamera() async {
    final status = await Permission.camera.request();

    if (!status.isGranted) return;

    final picker = ImagePicker();

    final XFile? image =
    await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      ref.read(chatControllerProvider.notifier).sendImageMessage(
        senderId: widget.senderId,
        receiverId: widget.receiverId,
        filePath: image.path,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [

            /// اخفاء الازرار اثناء التسجيل
            if (!isRecording) ...[
              PlusButton(
                onPickImage: _pickImage,
                onPickFile: _pickFile,
                onOpenCamera: _openCamera,
              ),

              ImageButton(onPickImage: _pickImage),
            ],

            Expanded(
              child: isRecording
                  ? Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(29),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.mic, color: Colors.red),
                    const SizedBox(width: 8),

                    const Text(
                      "Recording...",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),

                    const Spacer(),

                  ],
                ),
              )
                  : TextField(
                controller: controller,
                minLines: 1,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Type message...",
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(29),
                    borderSide: const BorderSide(
                      color: AppColors.strokeColor,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(29),
                    borderSide: const BorderSide(
                      color: AppColors.strokeColor,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 8),

            SendOrMicButton(
              hasText: hasText,
              isRecording: isRecording,
              recordingDuration: recordingDuration,
              onSend: _handleSend,
              onRecord: _toggleRecording,
              onCancelRecording: _cancelRecording,
            ),
          ],
        ),
      ),
    );
  }
}