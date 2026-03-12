/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;
import '../../domain/entities/student_entity.dart';
import '../providers/evaluation_provider.dart';

// --- الألوان والستايل ---
class AppColors {
  static const Color primary = Color(0xFF2979FF);
  static const Color gray = Color(0xFFF5F6FA);
  static const Color white = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF2D2D2D);
  static const Color lightSkyBlue = Color(0xFFE3F2FD);
}

class AppTextStyles {
  static const String fontFamily = 'Poppins';
  static const TextStyle textTitle = TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 18,
      color: AppColors.textDark);
  static const TextStyle textNormal = TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: Colors.grey);
  static const TextStyle textField = TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: 14,
      color: AppColors.textDark);
  static const TextStyle textLogo = TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w700,
      fontSize: 24,
      color: AppColors.textDark);
  static const TextStyle textLabel = TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 12,
      color: Colors.grey);
}

class StudentEvaluationPage extends ConsumerWidget {
  const StudentEvaluationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // هنا بنشوف الداتا (جاية جوه AsyncValue)
    final studentAsync = ref.watch(studentProvider);
    final downloadStatus = ref.watch(downloadStatusProvider);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 5, bottom: 5),
          child: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.1),
                      spreadRadius: 2,
                      blurRadius: 5)
                ]),
            child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new,
                    size: 18, color: Colors.black),
                onPressed: () {}),
          ),
        ),
        title: Text('Evaluation',
            style:
                AppTextStyles.textTitle.copyWith(fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      // هنا بنفتح العلبة: إما لودينج، أو إيرور، أو داتا
      body: studentAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator()), // لو لسه بيحمل
        error: (err, stack) =>
            Center(child: Text('Error: $err')), // لو فيه مشكلة
        data: (student) => SingleChildScrollView(
          // لو الداتا وصلت (هنا الـ student بقى Student عادي)
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _buildStudentCard(student),
              const SizedBox(height: 25),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Subjects', style: AppTextStyles.textTitle)),
              const SizedBox(height: 15),
              Column(
                  children: student.subjects
                      .map((s) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _buildSubjectItem(s)))
                      .toList()),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: downloadStatus == DownloadStatus.downloading
                          ? null
                          : () async {
                              ref.read(downloadStatusProvider.notifier).state =
                                  DownloadStatus.downloading;
                              await Future.delayed(const Duration(seconds: 2));
                              ref.read(downloadStatusProvider.notifier).state =
                                  DownloadStatus.success;

                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Row(children: [
                                      const Icon(Icons.check_circle_outline,
                                          color: Colors.white),
                                      const SizedBox(width: 8),
                                      Text('Report Downloaded!',
                                          style: AppTextStyles.textNormal
                                              .copyWith(color: Colors.white))
                                    ]),
                                    backgroundColor: Colors.green),
                              );

                              await Future.delayed(const Duration(seconds: 1));
                              ref.read(downloadStatusProvider.notifier).state =
                                  DownloadStatus.idle;
                            },
                      icon: downloadStatus == DownloadStatus.downloading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                  color: Colors.white, strokeWidth: 2))
                          : const Icon(Icons.download, color: Colors.white),
                      label: Text(
                          downloadStatus == DownloadStatus.downloading
                              ? 'Downloading...'
                              : 'Download Report',
                          style: AppTextStyles.textField
                              .copyWith(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        disabledBackgroundColor:
                            AppColors.primary.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12)),
                    child: IconButton(
                        onPressed: () {},
                        icon:
                            const Icon(Icons.upload, color: AppColors.primary),
                        iconSize: 28,
                        padding: const EdgeInsets.all(14)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStudentCard(Student student) {
    String overallPercentage = student.overallScore.toStringAsFixed(0);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: AppColors.gray,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withValues(alpha: 0.1),
                spreadRadius: 5,
                blurRadius: 15)
          ]),
      child: Column(
        children: [
          Row(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(student.name, style: AppTextStyles.textLogo),
              Text(student.grade, style: AppTextStyles.textNormal)
            ])
          ]),
          const SizedBox(height: 25),
          Text('Overall performance',
              style: AppTextStyles.textNormal
                  .copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          CustomPaint(
            size: const Size(180, 100),
            painter: _SemiCirclePainter(
                percentage: student.overallScore, color: AppColors.primary),
            child: SizedBox(
                height: 100,
                width: 180,
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text('$overallPercentage%',
                      style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary)),
                  Text(student.overallRating,
                      style: AppTextStyles.textNormal.copyWith(
                          color: Colors.green, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),
                ])),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectItem(Subject subject) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: AppColors.lightSkyBlue,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withValues(alpha: 0.05),
                spreadRadius: 2,
                blurRadius: 5)
          ]),
      child: Column(
        children: [
          Row(children: [
            Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: subject.color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10)),
                child: Icon(subject.icon, color: subject.color)),
            const SizedBox(width: 15),
            Text(subject.name, style: AppTextStyles.textField),
            const Spacer(),
            Text('${subject.score}%', style: AppTextStyles.textField),
            const SizedBox(width: 10),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(8)),
                child: Text(subject.rating,
                    style: AppTextStyles.textLabel
                        .copyWith(color: Colors.green[700])))
          ]),
          const SizedBox(height: 10),
          ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: LinearProgressIndicator(
                  value: subject.score / 100,
                  backgroundColor: AppColors.gray,
                  color: AppColors.primary,
                  minHeight: 6)),
        ],
      ),
    );
  }
}

class _SemiCirclePainter extends CustomPainter {
  final double percentage;
  final Color color;
  _SemiCirclePainter({required this.percentage, required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2;
    final bgPaint = Paint()
      ..color = AppColors.gray
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), math.pi,
        math.pi, false, bgPaint);
    final fgPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), math.pi,
        (percentage / 100) * math.pi, false, fgPaint);
  }

  @override
  bool shouldRepaint(covariant _SemiCirclePainter old) =>
      old.percentage != percentage || old.color != color;
}*/
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;
import '../../domain/entities/student_entity.dart';
import '../providers/evaluation_provider.dart';
import '../../../../shared/widgets/app_main_appbar.dart';

// --- الألوان والستايل ---
class AppColors {
  static const Color primary = Color(0xFF2979FF);
  static const Color gray = Color(0xFFF5F6FA);
  static const Color white = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF2D2D2D);
  static const Color lightSkyBlue = Color(0xFFE3F2FD);
}

class AppTextStyles {
  static const String fontFamily = 'Poppins';
  static const TextStyle textTitle = TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 18,
      color: AppColors.textDark);
  static const TextStyle textNormal = TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: Colors.grey);
  static const TextStyle textField = TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: 14,
      color: AppColors.textDark);
  static const TextStyle textLogo = TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w700,
      fontSize: 24,
      color: AppColors.textDark);
  static const TextStyle textLabel = TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 12,
      color: Colors.grey);
}

class StudentEvaluationPage extends ConsumerWidget {
  const StudentEvaluationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentAsync = ref.watch(studentProvider);
    final downloadStatus = ref.watch(downloadStatusProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,

      appBar: const AppMainAppBar(
        title: "Evaluation",
        centerTitle: false,
      ),

      body: studentAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (student) => SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _buildStudentCard(context, student),
              const SizedBox(height: 25),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Subjects',
                  style: AppTextStyles.textTitle.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Column(
                  children: student.subjects
                      .map((s) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildSubjectItem(context, s)))
                      .toList()),
              const SizedBox(height: 30),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: downloadStatus == DownloadStatus.downloading
                          ? null
                          : () async {
                        ref.read(downloadStatusProvider.notifier).state =
                            DownloadStatus.downloading;
                        await Future.delayed(const Duration(seconds: 2));
                        ref.read(downloadStatusProvider.notifier).state =
                            DownloadStatus.success;

                        if (!context.mounted) return;

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Row(children: [
                                const Icon(Icons.check_circle_outline,
                                    color: Colors.white),
                                const SizedBox(width: 8),
                                Text('Report Downloaded!',
                                    style: AppTextStyles.textNormal
                                        .copyWith(color: Colors.white))
                              ]),
                              backgroundColor: Colors.green),
                        );

                        await Future.delayed(const Duration(seconds: 1));

                        ref.read(downloadStatusProvider.notifier).state =
                            DownloadStatus.idle;
                      },
                      icon: downloadStatus == DownloadStatus.downloading
                          ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2))
                          : const Icon(Icons.download, color: Colors.white),
                      label: Text(
                          downloadStatus == DownloadStatus.downloading
                              ? 'Downloading...'
                              : 'Download Report',
                          style: AppTextStyles.textField
                              .copyWith(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        disabledBackgroundColor:
                        AppColors.primary.withValues(alpha: 0.5),
                      ),
                    ),
                  ),

                  const SizedBox(width: 15),

                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12)),
                    child: IconButton(
                        onPressed: () {},
                        icon:
                        const Icon(Icons.upload, color: AppColors.primary),
                        iconSize: 28,
                        padding: const EdgeInsets.all(14)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStudentCard(BuildContext context, Student student) {
    String overallPercentage = student.overallScore.toStringAsFixed(0);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              spreadRadius: 2,
              blurRadius: 12,
              offset: const Offset(0, 4),
            )
          ]
      ),
      child: Column(
        children: [
          Row(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

              // --- التعديل هنا فقط ---
              Text(
                student.name,
                style: AppTextStyles.textLogo.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),

              Text(student.grade, style: AppTextStyles.textNormal)
            ])
          ]),

          const SizedBox(height: 25),

          Text('Overall performance',
              style: AppTextStyles.textNormal
                  .copyWith(fontWeight: FontWeight.w600)),

          const SizedBox(height: 10),

          CustomPaint(
            size: const Size(180, 100),
            painter: _SemiCirclePainter(
                percentage: student.overallScore,
                color: AppColors.primary),
            child: SizedBox(
                height: 100,
                width: 180,
                child:
                Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text('$overallPercentage%',
                      style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary)),
                  Text(student.overallRating,
                      style: AppTextStyles.textNormal.copyWith(
                          color: Colors.green,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),
                ])),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectItem(BuildContext context, Subject subject) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withValues(alpha: 0.05),
                spreadRadius: 2,
                blurRadius: 5)
          ]),
      child: Column(
        children: [
          Row(children: [
            Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: subject.color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10)),
                child: Icon(subject.icon, color: subject.color)),
            const SizedBox(width: 15),

            Text(subject.name,
                style: AppTextStyles.textField.copyWith(
                    color: Theme.of(context).colorScheme.onSurface)),

            const Spacer(),

            Text('${subject.score}%',
                style: AppTextStyles.textField.copyWith(
                    color: Theme.of(context).colorScheme.onSurface)),

            const SizedBox(width: 10),

            Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(8)),
                child: Text(subject.rating,
                    style: AppTextStyles.textLabel
                        .copyWith(color: Colors.green[700])))
          ]),

          const SizedBox(height: 10),

          ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: LinearProgressIndicator(
                  value: subject.score / 100,
                  backgroundColor:
                  Theme.of(context).colorScheme.surface,
                  color: AppColors.primary,
                  minHeight: 6)),
        ],
      ),
    );
  }
}

class _SemiCirclePainter extends CustomPainter {
  final double percentage;
  final Color color;

  _SemiCirclePainter({required this.percentage, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2;

    final bgPaint = Paint()
      ..color = AppColors.gray
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), math.pi,
        math.pi, false, bgPaint);

    final fgPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), math.pi,
        (percentage / 100) * math.pi, false, fgPaint);
  }

  @override
  bool shouldRepaint(covariant _SemiCirclePainter old) =>
      old.percentage != percentage || old.color != color;
}