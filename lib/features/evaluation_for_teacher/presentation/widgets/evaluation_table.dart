/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/theme/app_colors.dart';
import '../providers/evaluation_providers.dart';

class EvaluationTable extends ConsumerWidget {
  const EvaluationTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(evaluationControllerProvider);

    /// Loading
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    /// Empty
    if (state.students.isEmpty) {
      return const Center(child: Text("No Students Found"));
    }

    return Column(
      children: [
        /// 🔥 HEADER
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          margin: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.strokeColor.withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            children: [
              Expanded(flex: 3, child: Text("Student")),
              Expanded(flex: 2, child: Text("Marks")),
              Expanded(child: Text("Max")),
              Expanded(child: Text("Absent")),
            ],
          ),
        ),

        const SizedBox(height: 8),

        /// 🔥 LIST
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: state.students.length,
            itemBuilder: (context, index) {
              final controller =
              ref.read(evaluationControllerProvider.notifier);

              final student = state.students[index];
              final mark = state.marks[student.id];
              final isAbsent = state.absent[student.id] ?? false;

              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),

                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(14),

                  /// 🔥 subtle border
                  border: Border.all(
                    color: AppColors.strokeColor.withOpacity(0.2),
                  ),
                ),

                child: Row(
                  children: [
                    /// Student Name
                    Expanded(
                      flex: 3,
                      child: Text(
                        student.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    /// Marks
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        initialValue: mark?.toString(),
                        enabled: !isAbsent,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,

                        decoration: InputDecoration(
                          hintText: "--",

                          isDense: true,

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: AppColors.strokeColor.withOpacity(0.5),
                            ),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: AppColors.strokeColor,
                              width: 1.5,
                            ),
                          ),
                        ),

                        onChanged: (val) {
                          controller.updateMark(
                            student.id,
                            int.tryParse(val),
                          );
                        },
                      ),
                    ),

                    /// Max
                    const Expanded(
                      child: Center(child: Text("50")),
                    ),

                    /// Checkbox
                    Expanded(
                      child: Center(
                        child: Transform.scale(
                          scale: 1.1,
                          child: Checkbox(
                            value: isAbsent,
                            onChanged: (val) {
                              controller.toggleAbsent(student.id, val!);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/theme/app_colors.dart';
import '../providers/evaluation_providers.dart';

class EvaluationTable extends ConsumerWidget {
  const EvaluationTable({super.key});

  final List<String> statusOptions = const [
    'Excellent',
    'Very Good',
    'Good',
    'Pass',
    'Fail',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(evaluationControllerProvider);

    /// Loading
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    /// Empty
    if (state.students.isEmpty) {
      return const Center(child: Text("No Students Found"));
    }

    return Column(
      children: [
        ///  HEADER
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          margin: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.strokeColor.withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            children: [
              Expanded(flex: 3, child: Text("Student")),
              Expanded(flex: 2, child: Text("Marks")),
              Expanded(child: Text("Max")),
              Expanded(flex: 2, child: Text("Status")), // 🔥 إضافة عمود الحالة
              Expanded(child: Text("Absent")),
            ],
          ),
        ),

        const SizedBox(height: 8),

        ///  LIST
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: state.students.length,
            itemBuilder: (context, index) {
              final controller =
              ref.read(evaluationControllerProvider.notifier);

              final student = state.students[index];
              final mark = state.marks[student.id];
              final isAbsent = state.absent[student.id] ?? false;
              final status = state.statuses[student.id]; // 🔥 جلب الحالة الحالية

              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),

                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(14),

                  ///  subtle border
                  border: Border.all(
                    color: AppColors.strokeColor.withOpacity(0.2),
                  ),
                ),

                child: Row(
                  children: [
                    /// Student Name
                    Expanded(
                      flex: 3,
                      child: Text(
                        student.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    /// Marks
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        initialValue: mark?.toString(),
                        enabled: !isAbsent,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,

                        decoration: InputDecoration(
                          hintText: "--",

                          isDense: true,

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: AppColors.strokeColor.withOpacity(0.5),
                            ),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: AppColors.strokeColor,
                              width: 1.5,
                            ),
                          ),
                        ),

                        onChanged: (val) {
                          controller.updateMark(
                            student.id,
                            int.tryParse(val),
                          );
                        },
                      ),
                    ),

                    /// Max
                    const Expanded(
                      child: Center(child: Text("50")),
                    ),

                    ///  Status Dropdown
                    Expanded(
                      flex: 2,
                      child: DropdownButtonFormField<String>(
                        value: status,
                        isExpanded: true,
                        hint: const Text("Select...", style: TextStyle(fontSize: 12)),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColors.strokeColor.withOpacity(0.3)),
                          ),
                        ),
                        items: statusOptions.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: const TextStyle(fontSize: 12)),
                          );
                        }).toList(),
                        onChanged: isAbsent
                            ? null
                            : (newValue) {
                          controller.updateStatus(student.id, newValue);
                        },
                      ),
                    ),

                    /// Checkbox
                    Expanded(
                      child: Center(
                        child: Transform.scale(
                          scale: 1.1,
                          child: Checkbox(
                            value: isAbsent,
                            onChanged: (val) {
                              controller.toggleAbsent(student.id, val!);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}