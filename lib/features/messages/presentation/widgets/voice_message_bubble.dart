/*import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import '../../domain/entities/message.dart';
import 'message_status.dart';
import 'message_time.dart';

class VoiceMessageBubble extends StatefulWidget {
  final Message message;
  final bool isMe;

  const VoiceMessageBubble({
    super.key,
    required this.message,
    required this.isMe,
  });

  @override
  State<VoiceMessageBubble> createState() => _VoiceMessageBubbleState();
}

class _VoiceMessageBubbleState extends State<VoiceMessageBubble> {
  static final FlutterSoundPlayer _player = FlutterSoundPlayer();
  static String? _currentPlayingId;

  late PlayerController waveformController;

  bool isPlaying = false;
  Duration currentPosition = Duration.zero;
  double speed = 1.0;

  @override
  void initState() {
    super.initState();
    waveformController = PlayerController();
    _initPlayer();
    _prepareWave();
  }

  Future<void> _prepareWave() async {
    if (widget.message.fileUrl == null) return;
    await waveformController.preparePlayer(
      path: widget.message.fileUrl!,
      shouldExtractWaveform: true,
    );
  }

  Future<void> _initPlayer() async {
    if (!_player.isOpen()) await _player.openPlayer();
    await _player.setSubscriptionDuration(const Duration(milliseconds: 200));

    _player.onProgress?.listen((event) {
      if (_currentPlayingId == widget.message.id) {
        setState(() {
          currentPosition = event.position;
        });
      }
    });
  }

  Future<void> _togglePlay() async {
    if (_player.isPlaying) await _player.stopPlayer();

    if (_currentPlayingId == widget.message.id && isPlaying) {
      setState(() {
        isPlaying = false;
        currentPosition = Duration.zero;
      });
      _currentPlayingId = null;
      return;
    }

    if (widget.message.fileUrl == null) return;

    _currentPlayingId = widget.message.id;

    await _player.startPlayer(
      fromURI: widget.message.fileUrl!,
      whenFinished: () {
        if (mounted) {
          setState(() {
            isPlaying = false;
            currentPosition = Duration.zero;
          });
        }
        _currentPlayingId = null;
      },
    );

    await _player.setSpeed(speed);

    setState(() => isPlaying = true);
  }

  Future<void> _changeSpeed() async {
    speed = speed == 1.0 ? 2.0 : 1.0;
    await _player.setSpeed(speed);
    setState(() {});
  }

  Future<void> _seek(double value) async {
    final total = Duration(seconds: widget.message.duration ?? 0);
    final newPosition =
    Duration(milliseconds: (total.inMilliseconds * value).toInt());
    await _player.seekToPlayer(newPosition);
    setState(() => currentPosition = newPosition);
  }

  String format(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$m:$s";
  }

  @override
  void dispose() {
    waveformController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalDuration = Duration(seconds: widget.message.duration ?? 0);

    return Align(
      alignment: widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: widget.isMe ? Colors.blue : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
          widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// زر التشغيل
                GestureDetector(
                  onTap: _togglePlay,
                  child:Icon(
                    isPlaying ? Icons.pause_circle : Icons.play_circle,
                    color: isPlaying
                        ? Colors.green
                        : (widget.isMe ? Colors.white : Colors.black),
                    size: 28,
                  )
                  /*Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: widget.isMe ? Colors.white : Colors.black,
                  ),*/
                ),
                const SizedBox(width: 10),

                /// Waveform
                GestureDetector(
                  onTapDown: (details) {
                    final box = context.findRenderObject() as RenderBox;
                    final local = box.globalToLocal(details.globalPosition);
                    final value = local.dx / 140;
                    _seek(value.clamp(0, 1));
                  },
                  child: SizedBox(
                    width: 140,
                    height: 35,
                    child: AudioFileWaveforms(
                      size: const Size(140, 35),
                      playerController: waveformController,
                      waveformType: WaveformType.fitWidth,
                      /*playerWaveStyle: PlayerWaveStyle(
                        fixedWaveColor: widget.isMe
                            ? Colors.white.withOpacity(.35)
                            : Colors.grey.shade400,
                        liveWaveColor: widget.isMe
                            ? Colors.yellowAccent
                            : Colors.blueAccent,
                        spacing: 4,
                        waveThickness: 2,
                      ),*/
                      playerWaveStyle: PlayerWaveStyle(
                        fixedWaveColor: widget.isMe
                            ? Colors.white.withOpacity(.25)
                            : Colors.grey.shade400,

                        liveWaveColor: widget.isMe
                            ? Colors.orangeAccent
                            : Colors.blueAccent,

                        spacing: 4,
                        waveThickness: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                /// الوقت
                Text(
                  isPlaying ? format(currentPosition) : format(totalDuration),
                  style: TextStyle(
                    color: widget.isMe ? Colors.white : Colors.black,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(width: 8),

                /// سرعة الصوت
                GestureDetector(
                  onTap: _changeSpeed,
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: widget.isMe ? Colors.white24 : Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      "${speed}x",
                      style: TextStyle(
                        fontSize: 11,
                        color: widget.isMe ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 4),

            /// الوقت + حالة الرسالة
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MessageTime(time: widget.message.createdAt, isMe: widget.isMe),
                const SizedBox(width: 6),
                if (widget.isMe)
                  MessageStatusWidget(status: widget.message.status),
              ],
            ),
          ],
        ),
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import '../../domain/entities/message.dart';
import 'message_status.dart';
import 'message_time.dart';

/*class VoiceMessageBubble extends StatefulWidget {
  final Message message;
  final bool isMe;

  const VoiceMessageBubble({
    super.key,
    required this.message,
    required this.isMe,
  });

  @override
  State<VoiceMessageBubble> createState() => _VoiceMessageBubbleState();
}

class _VoiceMessageBubbleState extends State<VoiceMessageBubble> {

  static final FlutterSoundPlayer _player = FlutterSoundPlayer();
  static String? _currentPlayingId;

  late PlayerController waveformController;

  bool isPlaying = false;
  Duration currentPosition = Duration.zero;
  double speed = 1.0;

  final GlobalKey _waveKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    waveformController = PlayerController();

    _initPlayer();
    _prepareWave();
  }

  Future<void> _prepareWave() async {

    if (widget.message.fileUrl == null) return;

    await waveformController.preparePlayer(
      path: widget.message.fileUrl!,
      shouldExtractWaveform: true,
    );
  }

  Future<void> _initPlayer() async {

    if (!_player.isOpen()) {
      await _player.openPlayer();
    }

    await _player.setSubscriptionDuration(const Duration(milliseconds: 50));
    _player.onProgress?.listen((event) {
      if (_currentPlayingId == widget.message.id) {
        setState(() {
          currentPosition = event.position;
        });

        // خلي الدايرة والwaveform يعتمدوا على نفس الـ currentPosition
        waveformController.seekTo(currentPosition.inMilliseconds);
      }
    });
    /*_player.onProgress?.listen((event) {

      if (_currentPlayingId == widget.message.id) {

        final position = event.position;

        setState(() {
          currentPosition = position;
        });

        /// تحديث تقدم waveform
        waveformController.seekTo(position.inMilliseconds);
      }
    });*/
  }

  Future<void> _togglePlay() async {

    if (_player.isPlaying) {
      await _player.stopPlayer();
    }

    if (_currentPlayingId == widget.message.id && isPlaying) {

      setState(() {
        isPlaying = false;
        currentPosition = Duration.zero;
      });

      waveformController.seekTo(0);

      _currentPlayingId = null;

      return;
    }

    if (widget.message.fileUrl == null) return;

    _currentPlayingId = widget.message.id;

    await _player.startPlayer(
      fromURI: widget.message.fileUrl!,
      whenFinished: () {

        if (!mounted) return;

        setState(() {
          isPlaying = false;
          currentPosition = Duration.zero;
        });

        waveformController.seekTo(0);

        _currentPlayingId = null;
      },
    );

    await _player.setSpeed(speed);

    setState(() {
      isPlaying = true;
    });
  }

  Future<void> _changeSpeed() async {

    speed = speed == 1.0 ? 2.0 : 1.0;

    await _player.setSpeed(speed);

    setState(() {});
  }

  Future<void> _seek(double value) async {

    final total = Duration(seconds: widget.message.duration ?? 0);

    final newPosition =
    Duration(milliseconds: (total.inMilliseconds * value).toInt());

    await _player.seekToPlayer(newPosition);

    waveformController.seekTo(newPosition.inMilliseconds);

    setState(() {
      currentPosition = newPosition;
    });
  }

  String format(Duration d) {

    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');

    return "$m:$s";
  }

  @override
  void dispose() {

    waveformController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final totalDuration =
    Duration(seconds: widget.message.duration ?? 0);

    return Align(
      alignment:
      widget.isMe ? Alignment.centerRight : Alignment.centerLeft,

      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),

        padding: const EdgeInsets.all(10),

        decoration: BoxDecoration(
          color: widget.isMe ? Colors.blue : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(18),
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,

          crossAxisAlignment: widget.isMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,

          children: [

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [

                /// زر التشغيل
                GestureDetector(
                  onTap: _togglePlay,
                  child: Icon(
                    isPlaying
                        ? Icons.pause_circle
                        : Icons.play_circle,
                    color: widget.isMe
                        ? Colors.white
                        : Theme.of(context).iconTheme.color,
                    size: 28,
                  ),
                ),

                const SizedBox(width: 10),

                /// waveform
                GestureDetector(
                  key: _waveKey,
                  onTapDown: (details) {

                    final box = _waveKey.currentContext!
                        .findRenderObject() as RenderBox;

                    final local =
                    box.globalToLocal(details.globalPosition);

                    final value = local.dx / box.size.width;

                    _seek(value.clamp(0, 1));
                  },

                  child: SizedBox(
                    width: 140,
                    height: 35,
                    child: Stack(
                      children: [

                        // الموجة ثابتة اللون بالكامل بدون أي جزء حي
                        AudioFileWaveforms(
                          size: const Size(140, 35),
                          playerController: waveformController,
                          waveformType: WaveformType.fitWidth,
                          playerWaveStyle: PlayerWaveStyle(
                            fixedWaveColor: Colors.white.withOpacity(0.5), // لون ثابت للكل
                            spacing: 4,
                            waveThickness: 2,
                            showSeekLine: false, // منع أي لون حي
                          ),
                        ),

                        // الدايرة تتحرك فوق الموجة
                        AnimatedBuilder(
                          animation: waveformController,
                          builder: (context, child) {

                            double progress = 0;
                            if (widget.message.duration != null && widget.message.duration! > 0) {
                              progress = currentPosition.inMilliseconds / (widget.message.duration! * 1000);
                              progress = progress.clamp(0.0, 1.0);
                            }

                            return Positioned(
                              left: 140 * progress - 6, // ناقص نصف حجم الدايرة
                              top: 0,
                              bottom: 0,
                              child: Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: Colors.white, // الدايرة أبيض
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.grey.shade400, width: 1),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  /*SizedBox(
                    width: 140,
                    height: 35,

                    child: AudioFileWaveforms(
                      size: const Size(140, 35),

                      playerController: waveformController,

                      waveformType: WaveformType.fitWidth,

                      playerWaveStyle: PlayerWaveStyle(

                        /// الجزء غير المشغل
                        fixedWaveColor: widget.isMe
                            ? Colors.white.withOpacity(.25)
                            : Colors.grey.shade400,

                        /// الجزء المشغل
                        liveWaveColor: widget.isMe
                            ? Colors.orangeAccent
                            : Theme.of(context).colorScheme.primary,

                        spacing: 4,
                        waveThickness: 2,
                      ),
                    ),
                  ),*/
                ),

                const SizedBox(width: 10),

                /// الوقت
                Text(
                  isPlaying
                      ? format(currentPosition)
                      : format(totalDuration),

                  style: TextStyle(
                    color: widget.isMe
                        ? Colors.white
                        : Colors.black,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(width: 8),

                /// السرعة
                GestureDetector(
                  onTap: _changeSpeed,

                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),

                    decoration: BoxDecoration(
                      color: widget.isMe
                          ? Colors.white24
                          : Colors.grey.shade400,

                      borderRadius: BorderRadius.circular(6),
                    ),

                    child: Text(
                      "${speed}x",

                      style: TextStyle(
                        fontSize: 11,
                        color: widget.isMe
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 4),

            /// الوقت + الحالة
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [

                MessageTime(
                  time: widget.message.createdAt,
                  isMe: widget.isMe,
                ),

                const SizedBox(width: 6),

                if (widget.isMe)
                  MessageStatusWidget(
                    status: widget.message.status,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}*/
class VoiceMessageBubble extends StatefulWidget {
  final Message message;
  final bool isMe;

  const VoiceMessageBubble({
    super.key,
    required this.message,
    required this.isMe,
  });

  @override
  State<VoiceMessageBubble> createState() => _VoiceMessageBubbleState();
}

class _VoiceMessageBubbleState extends State<VoiceMessageBubble>
    with WidgetsBindingObserver {

  static final FlutterSoundPlayer _player = FlutterSoundPlayer();
  static String? _currentPlayingId;

  late PlayerController waveformController;

  bool isPlaying = false;
  Duration currentPosition = Duration.zero;
  double speed = 1.0;

  final GlobalKey _waveKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    waveformController = PlayerController();

    _initPlayer();
    _prepareWave();
  }

  Future<void> _prepareWave() async {
    if (widget.message.fileUrl == null) return;

    await waveformController.preparePlayer(
      path: widget.message.fileUrl!,
      shouldExtractWaveform: true,
    );
  }

  Future<void> _initPlayer() async {
    if (!_player.isOpen()) {
      await _player.openPlayer();
    }

    await _player.setSubscriptionDuration(const Duration(milliseconds: 50));
    _player.onProgress?.listen((event) {
      if (_currentPlayingId == widget.message.id) {
        setState(() {
          currentPosition = event.position;
        });
        waveformController.seekTo(currentPosition.inMilliseconds);
      }
    });
  }

  Future<void> _togglePlay() async {
    if (_player.isPlaying) {
      await _player.stopPlayer();
    }

    if (_currentPlayingId == widget.message.id && isPlaying) {
      setState(() {
        isPlaying = false;
        currentPosition = Duration.zero;
      });
      waveformController.seekTo(0);
      _currentPlayingId = null;
      return;
    }

    if (widget.message.fileUrl == null) return;

    _currentPlayingId = widget.message.id;

    await _player.startPlayer(
      fromURI: widget.message.fileUrl!,
      whenFinished: () {
        if (!mounted) return;
        setState(() {
          isPlaying = false;
          currentPosition = Duration.zero;
        });
        waveformController.seekTo(0);
        _currentPlayingId = null;
      },
    );

    await _player.setSpeed(speed);

    setState(() {
      isPlaying = true;
    });
  }

  Future<void> _changeSpeed() async {
    speed = speed == 1.0 ? 2.0 : 1.0;
    await _player.setSpeed(speed);
    setState(() {});
  }

  Future<void> _seek(double value) async {
    final total = Duration(seconds: widget.message.duration ?? 0);
    final newPosition =
    Duration(milliseconds: (total.inMilliseconds * value).toInt());

    await _player.seekToPlayer(newPosition);
    waveformController.seekTo(newPosition.inMilliseconds);

    setState(() {
      currentPosition = newPosition;
    });
  }

  String format(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$m:$s";
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive || state == AppLifecycleState.paused) {
      if (_player.isPlaying) {
        _player.stopPlayer();
        _currentPlayingId = null;
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (_player.isPlaying) {
      _player.stopPlayer();
      _currentPlayingId = null;
    }
    waveformController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalDuration = Duration(seconds: widget.message.duration ?? 0);

    return Align(
      alignment:
      widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: widget.isMe ? Colors.blue : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
          widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // زر التشغيل
                GestureDetector(
                  onTap: _togglePlay,
                  child: Icon(
                    isPlaying ? Icons.pause_circle : Icons.play_circle,
                    color: widget.isMe
                        ? Colors.white
                        : Theme.of(context).iconTheme.color,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 10),
                // waveform + الدايرة
                GestureDetector(
                  key: _waveKey,
                  onTapDown: (details) {
                    final box = _waveKey.currentContext!.findRenderObject() as RenderBox;
                    final local = box.globalToLocal(details.globalPosition);
                    final value = local.dx / box.size.width;
                    _seek(value.clamp(0, 1));
                  },
                  child: SizedBox(
                    width: 140,
                    height: 35,
                    child: Stack(
                      children: [
                        AudioFileWaveforms(
                          size: const Size(140, 35),
                          playerController: waveformController,
                          waveformType: WaveformType.fitWidth,
                          playerWaveStyle: PlayerWaveStyle(
                            fixedWaveColor: Colors.white, // لون ثابت أبيض
                            spacing: 4,
                            waveThickness: 2,
                          ),
                        ),
                        Positioned(
                          left: 140 *
                              (currentPosition.inMilliseconds /
                                  ((widget.message.duration ?? 1) * 1000)) -
                              6,
                          top: 0,
                          bottom: 0,
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Colors.white, // الدايرة لون غامق
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // الوقت
                Text(
                  isPlaying ? format(currentPosition) : format(totalDuration),
                  style: TextStyle(
                    color: widget.isMe ? Colors.white : Colors.black,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 8),
                // السرعة
                GestureDetector(
                  onTap: _changeSpeed,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: widget.isMe ? Colors.white24 : Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      "${speed}x",
                      style: TextStyle(
                        fontSize: 11,
                        color: widget.isMe ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MessageTime(
                  time: widget.message.createdAt,
                  isMe: widget.isMe,
                ),
                const SizedBox(width: 6),
                if (widget.isMe)
                  MessageStatusWidget(
                    status: widget.message.status,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}