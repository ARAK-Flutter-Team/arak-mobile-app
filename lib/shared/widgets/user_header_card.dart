import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/providers/current_user_provider.dart';
import '../domain/entities/student.dart';
import '../theme/app_colors.dart';

class UserHeaderCard extends ConsumerWidget {
  final String name;
  final String? subtitle;
  final String? imageUrl;
  final bool showSearch;
  final bool showVerifiedIcon;
  final String? searchRoute;

  final List<Student>? students;
  final int? selectedStudentIndex;
  final ValueChanged<int>? onStudentSelected;

  const UserHeaderCard({
    super.key,
    required this.name,
    this.subtitle,
    this.imageUrl,
    this.showSearch = false,
    this.showVerifiedIcon = false,
    this.searchRoute,
    this.students,
    this.selectedStudentIndex,
    this.onStudentSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final user = ref.watch(currentUserProvider);
    final avatar = user?.avatarUrl ?? imageUrl;

    ImageProvider imageProvider;
    if (avatar != null && avatar.isNotEmpty) {
      if (avatar.startsWith('http')) {
        imageProvider = NetworkImage(avatar);
      } else {
        imageProvider = FileImage(File(avatar));
      }
    } else {
      imageProvider = const AssetImage('assets/images/download(1).jpg');
    }

    final hasMultipleStudents = students != null && students!.length > 1;
    final screenWidth = MediaQuery.of(context).size.width; // ✅ هنا

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.strokeColor, width: 0.5),
        borderRadius: BorderRadius.circular(12.r),
        color: theme.cardColor,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30.r,
            backgroundColor: theme.colorScheme.surfaceVariant,
            backgroundImage: imageProvider,
          ),

          SizedBox(width: 12.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: 6.w),
                    if (showVerifiedIcon)
                      SvgPicture.asset(
                        'assets/icons/true sign.svg',
                        width: 14.w,
                        height: 14.h,
                      ),
                  ],
                ),
                SizedBox(height: 4.h),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
              ],
            ),
          ),

          // ── Search Button
          if (showSearch)
            GestureDetector(
              onTap: () => context.push(searchRoute!),
              child: Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.colorScheme.primary.withOpacity(0.1),
                ),
                child: SvgPicture.asset(
                  'assets/icons/search.svg',
                  width: 15.w,
                  height: 15.h,
                  colorFilter: ColorFilter.mode(
                    theme.colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),

          // ✅ Dropdown Button
          if (hasMultipleStudents) ...[
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: () =>
                  _showStudentsDropdown(context, theme, screenWidth), // ✅
              child: Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.colorScheme.primary.withOpacity(0.1),
                ),
                child: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: theme.colorScheme.primary,
                  size: 18.w,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showStudentsDropdown(
      BuildContext context, ThemeData theme, double screenWidth) {
    // ✅
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    showMenu(
      context: context,
      color: theme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.strokeColor, width: 0.5),
      ),
      position: RelativeRect.fromLTRB(
        screenWidth * 0.1,
        offset.dy + size.height + 8,
        screenWidth * 0.1,
        0,
      ),
      items: students!.asMap().entries.map((entry) {
        final index = entry.key;
        final student = entry.value;
        final isSelected = index == selectedStudentIndex;

        return PopupMenuItem(
          value: index,
          child: Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                backgroundImage: student.avatarUrl != null
                    ? NetworkImage(student.avatarUrl!)
                    : null,
                child: student.avatarUrl == null
                    ? Icon(Icons.person,
                        size: 16, color: theme.colorScheme.primary)
                    : null,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  student.name,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight:
                        isSelected ? FontWeight.w700 : FontWeight.normal,
                    color: isSelected ? theme.colorScheme.primary : null,
                  ),
                ),
              ),
              if (isSelected)
                Icon(Icons.check, size: 16, color: theme.colorScheme.primary),
            ],
          ),
        );
      }).toList(),
    ).then((selectedIndex) {
      if (selectedIndex != null && onStudentSelected != null) {
        onStudentSelected!(selectedIndex);
      }
    });
  }
}
