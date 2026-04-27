import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/contact_provider.dart';
import '../widgets/contact_card.dart';
import '../../data/models/social_link_model.dart';
import '../../data/models/contact_method_model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../shared/widgets/app_main_appbar.dart';

class ContactPage extends ConsumerWidget {
  const ContactPage({super.key});

  Future<void> _launchUrl(
      String url, BuildContext context, AppLocalizations l10n) async {
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.couldNotLaunch(url))), // ✅
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final contactMethodsAsync = ref.watch(contactMethodsProvider);
    final socialLinksAsync = ref.watch(socialLinksProvider);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppMainAppBar(
        title: l10n.contactUs, // ✅
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Contact Methods
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

              // Title
              Text(
                l10n.writeYourMessage, // ✅
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10.h),

              // Message Field
              TextField(
                maxLines: 5,
                style: theme.textTheme.bodyMedium,
                decoration: InputDecoration(
                  hintText: l10n.typeYourMessage, // ✅
                  hintStyle: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.hintColor,
                  ),
                  filled: true,
                  fillColor: theme.cardColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
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

              // Social Media
              Center(
                child: Column(
                  children: [
                    Text(
                      l10n.ourSocialMedia, // ✅
                      style: theme.textTheme.bodyMedium,
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
                                onTap: () =>
                                    _launchUrl(link.url, context, l10n),
                                child: Container(
                                  padding: EdgeInsets.all(12.w),
                                  decoration: BoxDecoration(
                                    color: theme.cardColor,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            theme.brightness == Brightness.dark
                                                ? Colors.black.withAlpha(150)
                                                : Colors.grey.withAlpha(60),
                                        spreadRadius: 2,
                                        blurRadius: 6,
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
                      error: (err, stack) => const Text("Error loading links"),
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
