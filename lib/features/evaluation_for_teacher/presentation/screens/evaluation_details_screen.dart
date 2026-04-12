import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/widgets/app_main_appbar.dart';
import '../../../../shared/widgets/app_snackbar.dart';
import '../providers/evaluation_providers.dart';
import '../widgets/evaluation_table.dart';
import '../widgets/evaluation_actions.dart';

class EvaluationDetailsScreen extends ConsumerStatefulWidget {
  final int classId;
  final int subjectId;
  final String type;

  const EvaluationDetailsScreen({
    super.key,
    required this.classId,
    required this.subjectId,
    required this.type,
  });

  @override
  ConsumerState<EvaluationDetailsScreen> createState() =>
      _EvaluationDetailsScreenState();
}

class _EvaluationDetailsScreenState
    extends ConsumerState<EvaluationDetailsScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref
          .read(evaluationControllerProvider.notifier)
          .loadData(
        classId: widget.classId,
        subjectId: widget.subjectId,
        assessmentType: widget.type,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(evaluationControllerProvider);

    ref.listen(evaluationControllerProvider, (prev, next) {
      if (prev?.isSaving == true && next.isSaving == false) {
        if (next.error != null) {
          AppSnackBar.show(
            context,
            message: next.error!,
            type: AppSnackBarType.error,
          );
        } else {
          AppSnackBar.show(
            context,
            message: "Saved successfully",
            type: AppSnackBarType.success,
          );
        }
      }
    });

    return Scaffold(
      appBar: const AppMainAppBar(title: "Students Evaluation"),
      body: Column(
        children: [
          const Expanded(child: EvaluationTable()),

          EvaluationActions(
            isLoading: state.isSaving,
          ),
        ],
      ),
    );
  }
}