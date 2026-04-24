/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/app_main_appbar.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../domain/entities/schedule_item.dart';
import '../providers/teacherScheduleNotifierProvider.dart';
import '../providers/schedule_state.dart';
import '../widgets/schedule_day_section.dart';
import '../widgets/schedule_header.dart';

class TeacherSchedulePage extends ConsumerStatefulWidget {
  const TeacherSchedulePage({super.key});

  @override
  ConsumerState<TeacherSchedulePage> createState() =>
      _TeacherSchedulePageState();
}

class _TeacherSchedulePageState
    extends ConsumerState<TeacherSchedulePage> {

  /// ثابت بالإنجليزي (logic)
  final List<String> daysOrder = const [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  ///  ترجمة لعرض فقط (UI)
  String getTranslatedDay(String day) {
    final loc = AppLocalizations.of(context)!;

    switch (day) {
      case 'Sunday': return loc.sunday;
      case 'Monday': return loc.monday;
      case 'Tuesday': return loc.tuesday;
      case 'Wednesday': return loc.wednesday;
      case 'Thursday': return loc.thursday;
      case 'Friday': return loc.friday;
      case 'Saturday': return loc.saturday;
      default: return day;
    }
  }

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final user = ref.read(authProvider).user;

      if (user != null) {
        ref
            .read(scheduleNotifierProvider.notifier)
            .loadSchedule(user.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(scheduleNotifierProvider);

    return Scaffold(
      body: Column(
        children: [
          AppMainAppBar(
            title: AppLocalizations.of(context)!.myWeeklySchedule,
            showBackButton: true,
          ),
          Expanded(
            child: _buildBody(state),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(ScheduleState state) {
    if (state is ScheduleLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is ScheduleError) {
      return Center(child: Text(state.message));
    }

    if (state is ScheduleLoaded) {
      final schedule = state.schedule;

      ///  Grouping بالـ English (زي ما جاي من backend)
      final Map<String, List<ScheduleItem>> grouped = {};

      for (var item in schedule) {
        grouped.putIfAbsent(item.day, () => []);
        grouped[item.day]!.add(item);
      }

      return SingleChildScrollView(
        padding:
        const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ScheduleHeader(),

            ///  Loop بالإنجليزي
            ...daysOrder.map((day) {
              final items = grouped[day] ?? [];

              if (items.isEmpty) {
                return const SizedBox.shrink();
              }

              return ScheduleDaySection(
                ///  هنا بس الترجمة (UI)
                day: getTranslatedDay(day),
                items: items,
              );
            }),
          ],
        ),
      );
    }

    return const SizedBox();
  }
}*/
/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/app_main_appbar.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
// ⚠️ ركزي هنا: ممنوع أي Import فيه كلمة student-schedule
import '../../domain/entities/schedule_item.dart';
import '../providers/teacherScheduleNotifierProvider.dart';
import '../providers/schedule_state.dart';
import '../widgets/schedule_day_section.dart';
import '../widgets/schedule_header.dart';

class TeacherSchedulePage extends ConsumerStatefulWidget {
  const TeacherSchedulePage({super.key});

  @override
  ConsumerState<TeacherSchedulePage> createState() => _TeacherSchedulePageState();
}

class _TeacherSchedulePageState extends ConsumerState<TeacherSchedulePage> {
  final Map<int, String> daysMap = {
    0: 'Sunday', 1: 'Monday', 2: 'Tuesday', 3: 'Wednesday',
    4: 'Thursday', 5: 'Friday', 6: 'Saturday',
  };

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final user = ref.read(authProvider).user;
      if (user != null) {
        // نستخدم الـ Provider والـ Notifier المخصص للمدرس
        ref.read(teacherScheduleNotifierProvider.notifier).loadSchedule(user.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(teacherScheduleNotifierProvider);

    return Scaffold(
      body: Column(
        children: [
          AppMainAppBar(
            title: AppLocalizations.of(context)!.myWeeklySchedule,
            showBackButton: true,
          ),
          Expanded(child: _buildBody(state)),
        ],
      ),
    );
  }

  Widget _buildBody(TeacherScheduleState state) {
    if (state is TeacherScheduleLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is TeacherScheduleError) {
      return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
    }

    if (state is TeacherScheduleLoaded) {
      final schedule = state.schedule;
      if (schedule.isEmpty) return const Center(child: Text("No schedule found"));

      return RefreshIndicator(
        onRefresh: () async {
          final user = ref.read(authProvider).user;
          if (user != null) {
            await ref.read(teacherScheduleNotifierProvider.notifier).loadSchedule(user.id);
          }
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ScheduleHeader(),
              const SizedBox(height: 10),
              ...List.generate(7, (index) {
                final items = schedule.where((item) => item.dayOfWeek == index).toList();
                if (items.isEmpty) return const SizedBox.shrink();
                return ScheduleDaySection(
                  day: _getTranslatedDay(index),
                  items: items,
                );
              }),
            ],
          ),
        ),
      );
    }
    return const SizedBox();
  }

  String _getTranslatedDay(int index) {
    final loc = AppLocalizations.of(context)!;
    final dayName = daysMap[index];
    switch (dayName) {
      case 'Sunday': return loc.sunday;
      case 'Monday': return loc.monday;
      case 'Tuesday': return loc.tuesday;
      case 'Wednesday': return loc.wednesday;
      case 'Thursday': return loc.thursday;
      case 'Friday': return loc.friday;
      case 'Saturday': return loc.saturday;
      default: return "";
    }
  }
}*/
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// 1. ملف اللغات
import '../../../../l10n/app_localizations.dart';
// 2. الـ AppBar المشترك
import '../../../../shared/widgets/app_main_appbar.dart';
// 3. الـ Auth Provider عشان نجيب الـ ID بتاع المستخدم
import '../../../auth/presentation/providers/auth_providers.dart';
// 4. الانتيتي الخاص بجدول المعلم (تأكدي إن المسار فيه /schedule/ وليس schedual-of-student)
import '../../domain/entities/schedule_item.dart';
// 5. الـ Providers الخاص بالمعلم
import '../providers/schedule_providers.dart';
import '../providers/schedule_state.dart';
// 6. الودجتس الخاصة بجدول المعلم
import '../widgets/schedule_day_section.dart';
import '../widgets/schedule_header.dart';

class TeacherSchedulePage extends ConsumerStatefulWidget {
  const TeacherSchedulePage({super.key});

  @override
  ConsumerState<TeacherSchedulePage> createState() =>
      _TeacherSchedulePageState();
}

class _TeacherSchedulePageState
    extends ConsumerState<TeacherSchedulePage> {

  // ترتيب الأيام بالإنجليزي (زي ما هي قادمة من الباك)
  final List<String> daysOrder = const [
    'Sunday', 'Monday', 'Tuesday', 'Wednesday',
    'Thursday', 'Friday', 'Saturday',
  ];

  // دالة الترجمة للعرض فقط
  String getTranslatedDay(String day) {
    final loc = AppLocalizations.of(context)!;

    switch (day) {
      case 'Sunday': return loc.sunday;
      case 'Monday': return loc.monday;
      case 'Tuesday': return loc.tuesday;
      case 'Wednesday': return loc.wednesday;
      case 'Thursday': return loc.thursday;
      case 'Friday': return loc.friday;
      case 'Saturday': return loc.saturday;
      default: return day;
    }
  }

  /*@override
  void initState() {
    super.initState();

    Future.microtask(() {
      // جلب بيانات المستخدم الحالي
      final user = ref.read(authProvider).user;

      // التأكد من وجود ID وطلب البيانات من الباك
      if (user != null && user.id != null) {
        // استخدام teacherScheduleNotifierProvider لضمان عدم التعارض
        ref
            .read(teacherScheduleNotifierProvider.notifier)
            .loadSchedule(int.parse(user.id.toString()));
      }
    });
  }*/
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final user = ref.read(authProvider).user;

      if (user != null) {
        // محاولة تحويل الـ ID لرقم
        int? teacherId;

        // 1. الـ ID موجود وهو رقم؟
        if (user.id != null && RegExp(r'^\d+$').hasMatch(user.id!)) {
          teacherId = int.parse(user.id!);
        }
        // 2. لو الـ ID نص (من التوكن)، هنستخدم HashCode مؤقت عشان ما يبقاش فاضي
        else if (user.id != null) {
          teacherId = user.id!.hashCode;
          print("Warning: Using ID HashCode for Request: $teacherId");
        }

        if (teacherId != null) {
          ref
              .read(teacherScheduleNotifierProvider.notifier)
              .loadSchedule(teacherId);
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    // مراقبة حالة البيانات (Loading, Loaded, Error)
    final state = ref.watch(teacherScheduleNotifierProvider);

    return Scaffold(
      body: Column(
        children: [
          AppMainAppBar(
            title: AppLocalizations.of(context)!.myWeeklySchedule,
            showBackButton: true,
          ),
          Expanded(
            child: _buildBody(state),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(ScheduleState state) {
    if (state is ScheduleLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is ScheduleError) {
      return Center(child: Text(state.message));
    }

    if (state is ScheduleLoaded) {
      final schedule = state.schedule;

      // تجميع الدروس حسب اليوم (بالإنجليزي)
      final Map<String, List<ScheduleItem>> grouped = {};

      for (var item in schedule) {
        grouped.putIfAbsent(item.day, () => []);
        grouped[item.day]!.add(item);
      }

      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ScheduleHeader(),

            // عرض الأيام حسب الترتيب المحدد
            ...daysOrder.map((day) {
              final items = grouped[day] ?? [];
              if (items.isEmpty) return const SizedBox.shrink();

              return ScheduleDaySection(
                day: getTranslatedDay(day), // ترجمة العنوان
                items: items,
              );
            }),
          ],
        ),
      );
    }

    return const SizedBox();
  }
}