import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/app_main_appbar.dart';
import '../../domain/entities/student_details_entity.dart';
import '../providers/student_details_provider.dart';

class StudentDetailsScreen extends ConsumerWidget {
  final String studentId;
  const StudentDetailsScreen({super.key, required this.studentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailsAsync = ref.watch(studentDetailsProvider(studentId));
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppMainAppBar(
        title: 'Student Details',
        showBackButton: true,
        onBack: () => context.pop(),
      ),
      body: detailsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline,
                  size: 48.sp, color: theme.colorScheme.error),
              SizedBox(height: 12.h),
              Text(
                'Failed to load student details',
                style: theme.textTheme.titleMedium,
              ),
              SizedBox(height: 8.h),
              Text(
                e.toString(),
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: theme.colorScheme.error),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              ElevatedButton.icon(
                onPressed: () =>
                    ref.invalidate(studentDetailsProvider(studentId)),
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (student) => _StudentDetailsBody(student: student),
      ),
    );
  }
}

// ── Body ──────────────────────────────────────────────────────────────────────
class _StudentDetailsBody extends StatelessWidget {
  final StudentDetailsEntity student;
  const _StudentDetailsBody({required this.student});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Avatar + Name header ──────────────────────────────────────
          Center(
            child: Column(
              children: [
                _Avatar(imageUrl: student.profileImage, name: student.name),
                SizedBox(height: 14.h),
                Text(
                  student.name,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (student.isVerified) ...[
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.verified,
                          size: 16.sp,
                          color: theme.colorScheme.primary),
                      SizedBox(width: 4.w),
                      Text(
                        'Verified',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: 28.h),

          // ── Info card ────────────────────────────────────────────────
          _SectionCard(
            title: 'Academic Information',
            icon: Icons.school_outlined,
            children: [
              _InfoRow(
                label: 'Grade',
                value: student.grade.toString(),
                icon: Icons.grade_outlined,
              ),
              _InfoRow(
                label: 'Class',
                value: student.classNumber.toString(),
                icon: Icons.class_outlined,
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // ── Contact card ─────────────────────────────────────────────
          _SectionCard(
            title: 'Contact & Account',
            icon: Icons.contact_mail_outlined,
            children: [
              if (student.email != null && student.email!.isNotEmpty)
                _InfoRow(
                  label: 'Email',
                  value: student.email!,
                  icon: Icons.email_outlined,
                ),
              if (student.parentUsername != null &&
                  student.parentUsername!.isNotEmpty)
                _InfoRow(
                  label: 'Parent Account',
                  value: student.parentUsername!,
                  icon: Icons.person_outline,
                ),
              _InfoRow(
                label: 'Student ID',
                value: student.id,
                icon: Icons.badge_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Avatar Widget ─────────────────────────────────────────────────────────────
class _Avatar extends StatelessWidget {
  final String? imageUrl;
  final String name;
  const _Avatar({this.imageUrl, required this.name});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final initials = name.isNotEmpty
        ? name.trim().split(' ').map((w) => w[0]).take(2).join().toUpperCase()
        : '?';

    return Container(
      width: 90.w,
      height: 90.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primary.withValues(alpha: 0.6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 16,
            spreadRadius: 2,
          ),
        ],
      ),
      child: imageUrl != null && imageUrl!.isNotEmpty
          ? ClipOval(
              child: Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    _InitialsText(initials: initials),
              ),
            )
          : _InitialsText(initials: initials),
    );
  }
}

class _InitialsText extends StatelessWidget {
  final String initials;
  const _InitialsText({required this.initials});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        initials,
        style: TextStyle(
          color: Colors.white,
          fontSize: 28.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// ── Section Card ──────────────────────────────────────────────────────────────
class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;
  const _SectionCard({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (children.isEmpty) return const SizedBox.shrink();

    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card header
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 10.h),
            child: Row(
              children: [
                Icon(icon,
                    size: 18.sp, color: theme.colorScheme.primary),
                SizedBox(width: 8.w),
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: theme.colorScheme.outline.withValues(alpha: 0.15)),
          // Rows
          ...children,
        ],
      ),
    );
  }
}

// ── Info Row ──────────────────────────────────────────────────────────────────
class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  const _InfoRow({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          Icon(icon,
              size: 18.sp,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5)),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  value,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
