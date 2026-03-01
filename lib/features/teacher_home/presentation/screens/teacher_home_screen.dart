/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/teacher_home_provider.dart';
import '../widgets/teacher_home_body.dart';
import '../widgets/teacher_home_loading.dart';
import '../widgets/teacher_home_error.dart';

class TeacherHomeScreen extends ConsumerWidget {
  const TeacherHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final homeState = ref.watch(teacherHomeProvider);

    return Scaffold(
      body: homeState.when(
        data: (data) => TeacherHomeBody(data: data),
        loading: () => const TeacherHomeLoading(),
        error: (error, _) => TeacherHomeError(message: error.toString()),
      ),
    );
  }
}*/