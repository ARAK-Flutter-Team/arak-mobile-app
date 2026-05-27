import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/app_localizations.dart';

class TeacherQuotesSection extends StatelessWidget {
  const TeacherQuotesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;

    final quotes = [
      {
        "title": tr.teacherQuoteTitle1,
        "body": tr.teacherQuoteBody1,
        "author": tr.teacherQuoteAuthor1,
      },
      {
        "title": tr.teacherQuoteTitle2,
        "body": tr.teacherQuoteBody2,
        "author": tr.teacherQuoteAuthor2,
      },
      {
        "title": tr.teacherQuoteTitle3,
        "body": tr.teacherQuoteBody3,
        "author": tr.teacherQuoteAuthor3,
      },
      {
        "title": tr.teacherQuoteTitle4,
        "body": tr.teacherQuoteBody4,
        "author": tr.teacherQuoteAuthor4,
      },
      {
        "title": tr.teacherQuoteTitle5,
        "body": tr.teacherQuoteBody5,
        "author": tr.teacherQuoteAuthor5,
      },
    ];

    final randomQuote = quotes[Random().nextInt(quotes.length)];

    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),

      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,

        borderRadius: BorderRadius.circular(22.r),

        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.05)
              : Theme.of(context)
              .primaryColor
              .withOpacity(0.08),
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              isDark ? 0.15 : 0.03,
            ),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Stack(
        children: [
          /// Background Quote Icon
          Positioned(
            top: -18,
            right: -6,

            child: Icon(
              Icons.format_quote_rounded,
              size: 110.sp,

              color: isDark
                  ? Colors.white.withOpacity(0.06)
                  : Theme.of(context)
                  .primaryColor
                  .withOpacity(0.06),
            ),
          ),

          /// Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              Text(
                randomQuote["title"]!,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.color,
                ),
              ),

              SizedBox(height: 14.h),

              /// Quote Body
              Text(
                randomQuote["body"]!,
                style: TextStyle(
                  fontSize: 14.sp,
                  height: 1.7,
                  color: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.color
                      ?.withOpacity(0.85),
                ),
              ),

              SizedBox(height: 18.h),

              /// Author
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Text(
                  "— ${randomQuote["author"]!}",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}