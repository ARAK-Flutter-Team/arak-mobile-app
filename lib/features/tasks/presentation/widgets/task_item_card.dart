/*import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/task.dart';
import 'package:arak_app/shared/theme/app_colors.dart';

class TaskItemCard extends StatelessWidget {
  final Task task;

  const TaskItemCard({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formattedDate = DateFormat('dd MMM yyyy').format(task.dueDate);

    /// Mock submission numbers
    final submittedStudents = 12;
    final totalStudents = 30;

    /// ألوان لكل مادة
    final subjectColors = {
      "Math": Colors.blue,
      "Science": Colors.green,
      "English": Colors.orange,
    };

    /// أيقونات PNG لكل مادة
    final subjectIcons = {
      "Math": 'assets/icons/calculator_14116967.png',
      "Science": 'assets/icons/microscope.png',
      "English": 'assets/icons/alphabet (1).png',
    };

    return Card(
      elevation: 2,
      color: theme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: AppColors.strokeColor,
          width: 0.7,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title + Subject Icon
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// أيقونة المادة داخل كونتينر دائري
                if (subjectIcons[task.subject] != null)
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: (subjectColors[task.subject] ?? Colors.grey)
                          .withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(6),
                    child: Image.asset(
                      subjectIcons[task.subject]!,
                      width: 24,
                      height: 24,
                      color: subjectColors[task.subject],
                    ),
                  ),
                const SizedBox(width: 12),

                /// عنوان المهمة
                Expanded(
                  child: Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: theme.textTheme.titleMedium?.color,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            /// اسم المادة
            Text(
              task.subject,
              style: theme.textTheme.bodyMedium,
            ),

            const SizedBox(height: 6),

            /// موعد التسليم
            Text(
              "Due: $formattedDate",
              style: theme.textTheme.bodySmall,
            ),

            const SizedBox(height: 14),

            /// عدد التسليمات
            Row(
              children: [
                Icon(
                  Icons.upload_file,
                  size: 18,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 6),
                Text(
                  "$submittedStudents / $totalStudents ${AppLocalizations.of(context)!.studentsSubmitted}",
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// زر "View Submissions"
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: theme.colorScheme.primary,
                ),
                child: const Text("View Submissions"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/task.dart';
import 'package:arak_app/shared/theme/app_colors.dart';

class TaskItemCard extends StatelessWidget {
  final Task task;

  const TaskItemCard({
    super.key,
    required this.task,
  });

  /// 🔥 ترجمة اسم المادة
  String getSubjectLabel(BuildContext context, String subject) {
    switch (subject.toLowerCase()) {
      case "math":
        return AppLocalizations.of(context)!.math;
      case "science":
        return AppLocalizations.of(context)!.science;
      case "english":
        return AppLocalizations.of(context)!.english;
      default:
        return subject;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formattedDate = DateFormat('dd MMM yyyy').format(task.dueDate);

    /// 👇 مهم جدًا (حل المشكلة)
    final subject = task.subject.toLowerCase();

    /// Mock submission numbers
    final submittedStudents = 12;
    final totalStudents = 30;

    /// ألوان لكل مادة
    final subjectColors = {
      "math": Colors.blue,
      "science": Colors.green,
      "english": Colors.orange,
    };

    /// أيقونات لكل مادة
    final subjectIcons = {
      "math": 'assets/icons/calculator_14116967.png',
      "science": 'assets/icons/microscope.png',
      "english": 'assets/icons/alphabet (1).png',
    };

    return Card(
      elevation: 2,
      color: theme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: AppColors.strokeColor,
          width: 0.7,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title + Subject Icon
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// 🔥 الأيقونة (هتظهر دلوقتي صح)
                if (subjectIcons[subject] != null)
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: (subjectColors[subject] ?? Colors.grey)
                          .withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(6),
                    child: Image.asset(
                      subjectIcons[subject]!,
                      width: 24,
                      height: 24,
                      color: subjectColors[subject],
                    ),
                  ),

                const SizedBox(width: 12),

                /// عنوان المهمة
                Expanded(
                  child: Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: theme.textTheme.titleMedium?.color,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            /// 🔥 اسم المادة (مترجم)
            Text(
              getSubjectLabel(context, task.subject),
              style: theme.textTheme.bodyMedium,
            ),

            const SizedBox(height: 6),

            /// موعد التسليم
            Text(
              "Due: $formattedDate",
              style: theme.textTheme.bodySmall,
            ),

            const SizedBox(height: 14),

            /// عدد التسليمات
            Row(
              children: [
                Icon(
                  Icons.upload_file,
                  size: 18,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 6),
                Text(
                  "$submittedStudents / $totalStudents ${AppLocalizations.of(context)!.studentsSubmitted}",
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// زر
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: theme.colorScheme.primary,
                ),
                child: const Text("View Submissions"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}