import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/app_main_appbar.dart';
import '../../../../shared/theme/app_colors.dart';
import '../widgets/evaluation_load_button.dart';

class EvaluationFiltersScreen extends StatefulWidget {
  const EvaluationFiltersScreen({super.key});

  @override
  State<EvaluationFiltersScreen> createState() =>
      _EvaluationFiltersScreenState();
}

class _EvaluationFiltersScreenState extends State<EvaluationFiltersScreen> {
  int? classId;
  int? subjectId;
  String? type;

  final classes = {1: "Class 1", 2: "Class 2"};

  final subjects = {
    1: ["Math", "Science"],
    2: ["Physics", "Biology"],
  };

  final types = ["Month 1", "Month 2", "Final"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppMainAppBar(title: "Evaluation"),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.surface,
              Colors.grey.shade50,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _headerCard(),

              const SizedBox(height: 18),

              _sectionTitle("Select Class"),
              const SizedBox(height: 10),
              _horizontalList(
                classes.entries.map((e) {
                  return _selectCard(
                    title: e.value,
                    icon: Icons.school,
                    selected: classId == e.key,
                    onTap: () {
                      setState(() {
                        classId = e.key;
                        subjectId = null;
                      });
                    },
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),

              _sectionTitle("Select Subject"),
              const SizedBox(height: 10),

              if (classId == null)
                _emptyState("Select a class first")
              else
                _horizontalList(
                  (subjects[classId] ?? []).map((s) {
                    final id = s.hashCode;
                    return _selectCard(
                      title: s,
                      icon: Icons.book,
                      selected: subjectId == id,
                      onTap: () => setState(() => subjectId = id),
                    );
                  }).toList(),
                ),

              const SizedBox(height: 20),

              _sectionTitle("Assessment Type"),
              const SizedBox(height: 10),

              Wrap(
                spacing: 10,
                children: types.map((t) {
                  final selected = type == t;
                  return ChoiceChip(
                    label: Text(t),
                    selected: selected,
                    onSelected: (_) => setState(() => type = t),
                    selectedColor:
                    AppColors.strokeColor.withOpacity(0.15),
                    labelStyle: TextStyle(
                      color: selected
                          ? AppColors.strokeColor
                          : Colors.grey.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  );
                }).toList(),
              ),

              const Spacer(),

              EvaluationLoadButton(
                isEnabled: _canSubmit(),
                isLoading: false,
                onPressed: () {
                  context.push(
                    '/teacher-evaluation-details',
                    extra: {
                      "classId": classId,
                      "subjectId": subjectId,
                      "type": type,
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///  HEADER
  Widget _headerCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.strokeColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(Icons.assessment, color: AppColors.strokeColor),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              "Create & Filter Evaluations",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  ///TITLE
  Widget _sectionTitle(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: Colors.grey.shade800,
        ),
      ),
    );
  }

  ///  EMPTY STATE
  Widget _emptyState(String text) {
    return Container(
      height: 80,
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(color: Colors.grey.shade500),
      ),
    );
  }

  ///  HORIZONTAL LIST
  Widget _horizontalList(List<Widget> children) {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, i) => children[i],
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemCount: children.length,
      ),
    );
  }

  ///  CARD
  Widget _selectCard({
    required String title,
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 140,
        decoration: BoxDecoration(
          color: selected
              ? AppColors.strokeColor.withOpacity(0.12)
              : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected
                ? AppColors.strokeColor
                : Colors.grey.withOpacity(0.2),
            width: selected ? 1.5 : 1,
          ),
          boxShadow: selected
              ? [
            BoxShadow(
              color: AppColors.strokeColor.withOpacity(0.25),
              blurRadius: 12,
              offset: const Offset(0, 6),
            )
          ]
              : [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color:
              selected ? AppColors.strokeColor : Colors.grey.shade600,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: selected
                    ? AppColors.strokeColor
                    : Colors.grey.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _canSubmit() =>
      classId != null && subjectId != null && type != null;
}