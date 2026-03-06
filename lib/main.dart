import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;
import 'package:go_router/go_router.dart';
import 'dart:async'; // Required for Future.delayed

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

// --- 1. الألوان والثيم (Design System) ---
class AppColors {
  static const Color primary = Color(0xFF2979FF);
  static const Color gray = Color(0xFFF5F6FA);
  static const Color white = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF2D2D2D);
  static const Color lightSkyBlue = Color(0xFFE3F2FD); // A light sky blue
}

class AppTextStyles {
  static const String fontFamily = 'Poppins';
  static const TextStyle textTitle = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 18,
    color: AppColors.textDark,
  );
  static const TextStyle textNormal = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: Colors.grey,
  );
  static const TextStyle textField = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    color: AppColors.textDark,
  );
  static const TextStyle textLogo = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 24,
    color: AppColors.textDark,
  );
  static const TextStyle textLabel = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 12,
    color: Colors.grey,
  );
}

// --- 2. الهيكل البياني (Models) ---
class Subject {
  final String name;
  final int score;
  final IconData icon;
  final Color color;

  Subject({
    required this.name,
    required this.score,
    required this.icon,
    required this.color,
  });

  String get rating {
    if (score >= 85) return 'Excellent';
    if (score >= 75) return 'Very Good';
    if (score >= 60) return 'Good';
    return 'Weak';
  }
}

class Student {
  final String name;
  final String grade;
  final List<Subject> subjects;

  Student({
    required this.name,
    required this.grade,
    required this.subjects,
  });

  double get overallScore {
    if (subjects.isEmpty) return 0;
    int total = subjects.fold(0, (sum, s) => sum + s.score);
    return total / subjects.length;
  }

  String get overallRating {
    double score = overallScore;
    if (score >= 85) return 'Excellent';
    if (score >= 75) return 'Very Good';
    if (score >= 60) return 'Good';
    return 'Weak';
  }
}

// Enum for download status
enum DownloadStatus { idle, downloading, success }

// --- 3. Riverpod Providers ---
// Bottom Navigation Index
final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

// Student Data Provider (mock for now, will be replaced by API)
final studentProvider = Provider<Student>((ref) {
  return Student(
    name: 'Ahmed Abdullah',
    grade: 'Grade 9',
    subjects: [
      Subject(
          name: 'Math', score: 92, icon: Icons.calculate, color: Colors.orange),
      Subject(
          name: 'Science', score: 85, icon: Icons.science, color: Colors.green),
      Subject(
          name: 'English',
          score: 84,
          icon: Icons.book,
          color: Colors.lightBlue),
    ],
  );
});

// Download Status Provider
final downloadStatusProvider =
    StateProvider<DownloadStatus>((ref) => DownloadStatus.idle);

// --- 4. GoRouter Setup ---
final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const StudentEvaluationPage(),
    ),
    // هنا تقدر تضيف صفحات تانية لاحقاً
  ],
);

// --- 5. التطبيق الرئيسي ---
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: ThemeData.light().copyWith(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors
            .gray, // Default app scaffold background, overridden locally where needed
        textTheme: ThemeData.light()
            .textTheme
            .apply(fontFamily: AppTextStyles.fontFamily),
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: Colors.black,
        textTheme: ThemeData.dark()
            .textTheme
            .apply(fontFamily: AppTextStyles.fontFamily),
      ),
      themeMode: ThemeMode.system,
    );
  }
}

// --- 6. شاشة تقييم الطالب ---
class StudentEvaluationPage extends ConsumerWidget {
  const StudentEvaluationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final student = ref.watch(studentProvider);
    final currentIndex = ref.watch(bottomNavIndexProvider);
    final downloadStatus = ref.watch(downloadStatusProvider);

    String overallPercentage = student.overallScore.toStringAsFixed(0);

    return Scaffold(
      backgroundColor: AppColors.white, // Changed background to white
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
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5)
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new,
                  size: 18, color: Colors.black),
              onPressed: () {},
            ),
          ),
        ),
        title: Text('Evaluation',
            style:
                AppTextStyles.textTitle.copyWith(fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                  .map<Widget>((Subject subject) => Padding(
                        // Explicit type argument
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _buildSubjectItem(subject),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: downloadStatus == DownloadStatus.downloading
                        ? null // Disable button while downloading
                        : () async {
                            ref.read(downloadStatusProvider.notifier).state =
                                DownloadStatus.downloading;
                            await Future.delayed(const Duration(
                                seconds: 2)); // Simulate download time
                            ref.read(downloadStatusProvider.notifier).state =
                                DownloadStatus.success;

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Row(
                                  children: <Widget>[
                                    const Icon(Icons.check_circle_outline,
                                        color: Colors.white),
                                    const SizedBox(width: 8),
                                    Text('Report Downloaded Successfully!',
                                        style: AppTextStyles.textNormal
                                            .copyWith(color: Colors.white)),
                                  ],
                                ),
                                backgroundColor: Colors.green,
                                duration: const Duration(seconds: 3),
                              ),
                            );

                            await Future.delayed(const Duration(
                                seconds:
                                    1)); // Keep success state visible briefly
                            ref.read(downloadStatusProvider.notifier).state =
                                DownloadStatus.idle;
                          },
                    icon: downloadStatus == DownloadStatus.downloading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2),
                          )
                        : const Icon(Icons.download, color: Colors.white),
                    label: Text(
                      downloadStatus == DownloadStatus.downloading
                          ? 'Downloading...'
                          : 'Download Report',
                      style:
                          AppTextStyles.textField.copyWith(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      disabledBackgroundColor: AppColors.primary
                          .withOpacity(0.5), // Style for disabled state
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12)),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.upload, color: AppColors.primary),
                    iconSize: 28,
                    padding: const EdgeInsets.all(14),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(ref, currentIndex),
    );
  }

  Widget _buildStudentCard(Student student) {
    String overallPercentage = student.overallScore.toStringAsFixed(0);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color:
            AppColors.gray, // Changed student card background to AppColors.gray
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 15)
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(student.name, style: AppTextStyles.textLogo),
                  Text(student.grade, style: AppTextStyles.textNormal),
                ],
              )
            ],
          ),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('$overallPercentage%',
                      style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary)),
                  Text(student.overallRating,
                      style: AppTextStyles.textNormal.copyWith(
                          color: Colors.green, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectItem(Subject subject) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors
            .lightSkyBlue, // Changed subject item frame color to sky blue
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              spreadRadius: 2,
              blurRadius: 5)
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: subject.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10)),
                child: Icon(subject.icon, color: subject.color),
              ),
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
                        .copyWith(color: Colors.green[700])),
              )
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LinearProgressIndicator(
              value: subject.score / 100,
              backgroundColor: AppColors.gray,
              color: AppColors.primary,
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(WidgetRef ref, int currentIndex) {
    final List<Map<String, Object>> items = <Map<String, Object>>[
      // Explicit type argument
      {'icon': Icons.home_filled, 'label': 'Home'},
      {'icon': Icons.person_outline, 'label': 'Profile'},
      {'icon': Icons.notifications_none, 'label': 'Alerts', 'badge': true},
      {'icon': Icons.settings_outlined, 'label': 'Settings'},
    ];

    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, -1))
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List<Widget>.generate(items.length, (int index) {
          // Explicit type argument
          final Map<String, Object> item =
              items[index]; // Explicit type argument
          bool isSelected = currentIndex == index;
          return GestureDetector(
            onTap: () =>
                ref.read(bottomNavIndexProvider.notifier).state = index,
            behavior: HitTestBehavior.opaque,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Icon(item['icon']! as IconData,
                        size: 28,
                        color:
                            isSelected ? AppColors.primary : Colors.grey[400]),
                    if (item['badge'] == true)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Colors.white, width: 1.5))),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(item['label']! as String,
                    style: AppTextStyles.textLabel.copyWith(
                        color:
                            isSelected ? AppColors.primary : Colors.grey[400],
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.normal)),
              ],
            ),
          );
        }),
      ),
    );
  }
}

// --- 7. الرسام (Painter) ---
class _SemiCirclePainter extends CustomPainter {
  final double percentage;
  final Color color;

  _SemiCirclePainter({required this.percentage, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height);
    final double radius = size.width / 2;

    final Paint backgroundPaint = Paint()
      ..color = AppColors.gray
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), math.pi,
        math.pi, false, backgroundPaint);

    final Paint foregroundPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;
    double sweepAngle = (percentage / 100) * math.pi;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), math.pi,
        sweepAngle, false, foregroundPaint);
  }

  @override
  bool shouldRepaint(covariant _SemiCirclePainter oldDelegate) {
    return oldDelegate.percentage != percentage || oldDelegate.color != color;
  }
}
