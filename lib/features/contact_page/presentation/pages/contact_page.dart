/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/contact_provider.dart';
import '../widgets/contact_card.dart';
// --- التصحيح هنا: المسارات كانت بتطلع بره الفولدر ---
import '../../data/models/social_link_model.dart';
import '../../data/models/contact_method_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends ConsumerWidget {
  const ContactPage({super.key});

  Future<void> _launchUrl(String url, BuildContext context) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      // حل مشكلة الـ async gap
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Could not launch $url")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final contactMethodsAsync = ref.watch(contactMethodsProvider);
    final socialLinksAsync = ref.watch(socialLinksProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Us",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.0.w),
          child: InkWell(
            onTap: () => Navigator.of(context).pop(),
            borderRadius: BorderRadius.circular(20.r),
            child: Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey[600]!, width: 1.5),
              ),
              child: Icon(Icons.arrow_back_ios,
                  color: Colors.black54, size: 20.sp),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              contactMethodsAsync.when(
                data: (methods) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: methods.length,
                    itemBuilder: (context, index) {
                      // الـ Cast هيشتغل دلوقتي عشان الـ import صح
                      return ContactCard(
                          method: methods[index] as ContactMethodModel);
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(child: Text("Error: $err")),
              ),
              SizedBox(height: 20.h),
              Text(
                "Write your message below:",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),
              TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Type your message here...",
                  filled: true,
                  fillColor: theme.cardColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Center(
                child: Column(
                  children: [
                    Text(
                      "our social media",
                      style:
                          TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
                    ),
                    SizedBox(height: 15.h),
                    socialLinksAsync.when(
                      data: (links) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: links.map((link) {
                            final socialModel = link as SocialLinkModel;
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                              child: InkWell(
                                onTap: () => _launchUrl(link.url, context),
                                child: Container(
                                  padding: EdgeInsets.all(12.w),
                                  decoration: BoxDecoration(
                                    color: theme.cardColor,
                                    shape: BoxShape.circle,
                                    // حل مشكلة الـ deprecated withOpacity
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withAlpha(
                                            50), // بدل withOpacity(0.2)
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    socialModel.iconData,
                                    size: 28.sp,
                                    color: theme.primaryColor,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                      loading: () => const CircularProgressIndicator(),
                      error: (err, stack) => Text("Error loading links"),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/contact_provider.dart';
import '../widgets/contact_card.dart';
import '../../data/models/social_link_model.dart';
import '../../data/models/contact_method_model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../shared/widgets/app_main_appbar.dart';

class ContactPage extends ConsumerWidget {
  const ContactPage({super.key});

  Future<void> _launchUrl(String url, BuildContext context) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Could not launch $url")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final contactMethodsAsync = ref.watch(contactMethodsProvider);
    final socialLinksAsync = ref.watch(socialLinksProvider);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: const AppMainAppBar(
        title: "Contact Us",
        centerTitle: false,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Contact Methods
              contactMethodsAsync.when(
                data: (methods) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: methods.length,
                    itemBuilder: (context, index) {
                      return ContactCard(
                        method: methods[index] as ContactMethodModel,
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(child: Text("Error: $err")),
              ),

              SizedBox(height: 20.h),

              /// Title
              Text(
                "Write your message below:",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),

              SizedBox(height: 10.h),

              /// Message Field
              TextField(
                maxLines: 5,
                style: TextStyle(
                  color: theme.textTheme.bodyLarge?.color,
                ),
                decoration: InputDecoration(
                  hintText: "Type your message here...",
                  hintStyle: TextStyle(
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                  filled: true,
                  fillColor: theme.cardColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: theme.dividerColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: theme.dividerColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(
                      color: theme.colorScheme.primary,
                      width: 1.5,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30.h),

              /// Social Media
              Center(
                child: Column(
                  children: [
                    Text(
                      "our social media",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: theme.textTheme.bodyMedium?.color,
                      ),
                    ),

                    SizedBox(height: 15.h),

                    socialLinksAsync.when(
                      data: (links) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: links.map((link) {

                            final socialModel = link as SocialLinkModel;

                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.w),

                              child: InkWell(
                                onTap: () => _launchUrl(link.url, context),

                                child: Container(
                                  padding: EdgeInsets.all(12.w),

                                  decoration: BoxDecoration(
                                    color: theme.cardColor,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: theme.brightness == Brightness.dark
                                            ? Colors.black.withAlpha(120)
                                            : Colors.grey.withAlpha(50),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                      ),
                                    ],
                                  ),

                                  child: Icon(
                                    socialModel.iconData,
                                    size: 28.sp,
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },

                      loading: () => const CircularProgressIndicator(),

                      error: (err, stack) =>
                      const Text("Error loading links"),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}