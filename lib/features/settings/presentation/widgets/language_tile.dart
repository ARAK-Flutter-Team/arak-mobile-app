import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/providers/locale_provider.dart';

class SettingsLanguageTile extends ConsumerWidget {
  const SettingsLanguageTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final locale = ref.watch(localeProvider);

    String currentLanguage =
    locale.languageCode == 'ar' ? 'العربية' : 'English';

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 12.h,
        horizontal: 4.w,
      ),
      child: Row(
        children: [
          /// النص
          Expanded(
            child: Text(
              "Language",
              style: theme.textTheme.bodyLarge?.copyWith(
                fontFamily: 'Teachers',
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          /// اللغة الحالية + سهم
          GestureDetector(
            onTap: () {
              _showLanguageDialog(context, ref, locale);
            },
            child: Row(
              children: [
                Text(
                  currentLanguage,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 14.sp,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16.sp,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog(
      BuildContext context, WidgetRef ref, Locale locale) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text("Choose Language"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _option(context, ref, "English", 'en',
                  locale.languageCode == 'en'),
              _option(context, ref, "العربية", 'ar',
                  locale.languageCode == 'ar'),
            ],
          ),
        );
      },
    );
  }

  Widget _option(BuildContext context, WidgetRef ref, String title,
      String code, bool selected) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      trailing:
      selected ? const Icon(Icons.check, color: Colors.green) : null,
      onTap: () {
        ref.read(localeProvider.notifier).state = Locale(code);
        Navigator.pop(context);
      },
    );
  }
}