/*import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/models/contact_method_model.dart'; // استخدمنا الموديل عشان الـ IconData

class ContactCard extends StatelessWidget {
  final ContactMethodModel method;

  const ContactCard({super.key, required this.method});

  Future<void> _launchAction(String url, BuildContext context) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Could not launch $url")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.only(bottom: 15.h),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      child: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: theme.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child:
                  Icon(method.iconData, size: 30.sp, color: theme.primaryColor),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    method.title,
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    method.subtitle,
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => _launchAction(method.link, context),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
              child:
                  Text(method.actionLabel, style: TextStyle(fontSize: 12.sp)),
            ),
          ],
        ),
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/models/contact_method_model.dart';

class ContactCard extends StatelessWidget {

  final ContactMethodModel method;

  const ContactCard({super.key, required this.method});

  Future<void> _launchAction(String url, BuildContext context) async {

    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Could not launch $url")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Card(

      color: theme.cardColor,

      margin: EdgeInsets.only(bottom: 15.h),

      elevation: theme.brightness == Brightness.dark ? 1 : 3,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),

      child: Padding(
        padding: EdgeInsets.all(16.w),

        child: Row(
          children: [

            /// ICON
            Container(
              padding: EdgeInsets.all(10.w),

              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),

              child: Icon(
                method.iconData,
                size: 30.sp,
                color: theme.colorScheme.primary,
              ),
            ),

            SizedBox(width: 15.w),

            /// TEXT
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Text(
                    method.title,
                    style: theme.textTheme.titleMedium,
                  ),

                  Text(
                    method.subtitle,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),

            /// BUTTON
            ElevatedButton(

              onPressed: () =>
                  _launchAction(method.link, context),

              style: ElevatedButton.styleFrom(

                backgroundColor: theme.colorScheme.primary,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),

              child: Text(
                method.actionLabel,

                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}