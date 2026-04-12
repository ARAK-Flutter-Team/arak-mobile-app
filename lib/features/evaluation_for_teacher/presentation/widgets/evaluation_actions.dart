import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/evaluation_providers.dart';
import 'evaluation_save_button.dart';

class EvaluationActions extends ConsumerWidget {
  final bool isLoading;

  const EvaluationActions({
    super.key,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: EvaluationSaveButton(
        isLoading: isLoading,
        onPressed: () {
          ref
              .read(evaluationControllerProvider.notifier)
              .save();
        },
      ),
    );
  }
}