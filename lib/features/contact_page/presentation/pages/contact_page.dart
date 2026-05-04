import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/app_main_appbar.dart';
import '../providers/contact_provider.dart';
import '../widgets/contact_card.dart';
import '../../data/models/social_link_model.dart';
import '../../data/models/contact_method_model.dart';

class ContactPage extends ConsumerStatefulWidget {
  const ContactPage({super.key});

  @override
  ConsumerState<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends ConsumerState<ContactPage> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(
      String url, BuildContext context, AppLocalizations l10n) async {
    try {
      Uri uri;
      if (url.startsWith('mailto:')) {
        uri = Uri(
          scheme: 'mailto',
          path: url.replaceFirst('mailto:', ''),
        );
      } else if (url.startsWith('tel:')) {
        uri = Uri(
          scheme: 'tel',
          path: url.replaceFirst('tel:', ''),
        );
      } else {
        uri = Uri.parse(url);
      }

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.couldNotLaunch(url))),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${e.toString()}")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final contactMethodsAsync = ref.watch(contactMethodsProvider);
    final socialLinksAsync = ref.watch(socialLinksProvider);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppMainAppBar(
        title: l10n.contactUs,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Contact Options Section

              SizedBox(height: 12.h),
              contactMethodsAsync.when(
                data: (methods) {
                  return Column(
                    children: methods.map((method) {
                      return ContactCard(method: method as ContactMethodModel);
                    }).toList(),
                  );
                },
                loading: () => const Center(
                    child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(),
                )),
                error: (err, stack) =>
                    Center(child: Text("Error loading contacts")),
              ),

              SizedBox(height: 24.h),

              // 2. Message Form Section (Primary)
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                      color: theme.colorScheme.primary.withOpacity(0.1)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.writeYourMessage,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "We usually respond within 24 hours",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color:
                            theme.textTheme.bodySmall?.color?.withOpacity(0.6),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    TextField(
                      controller: _messageController,
                      maxLines: 4,
                      style: theme.textTheme.bodyMedium,
                      decoration: InputDecoration(
                        hintText: l10n.typeYourMessage,
                        hintStyle: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.hintColor.withOpacity(0.5),
                        ),
                        filled: true,
                        fillColor: theme.cardColor,
                        contentPadding: EdgeInsets.all(16.w),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(
                              color: theme.dividerColor.withOpacity(0.1)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(
                              color: theme.colorScheme.primary, width: 1),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: () {
                          // Logic for sending message
                          if (_messageController.text.isNotEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Message sent successfully!")),
                            );
                            _messageController.clear();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          "Send",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40.h),

              // 3. Social Media Section
              Center(
                child: Column(
                  children: [
                    Text(
                      l10n.ourSocialMedia,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color:
                            theme.textTheme.bodySmall?.color?.withOpacity(0.5),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    socialLinksAsync.when(
                      data: (links) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: links.map((link) {
                            final socialModel = link as SocialLinkModel;
                            return _SocialIconButton(
                              iconPath: socialModel.iconPath,
                              onTap: () => _launchUrl(link.url, context, l10n),
                            );
                          }).toList(),
                        );
                      },
                      loading: () => const SizedBox.shrink(),
                      error: (err, stack) => const Text("Error loading links"),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialIconButton extends StatelessWidget {
  final String iconPath;
  final VoidCallback onTap;

  const _SocialIconButton({required this.iconPath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: theme.dividerColor.withOpacity(0.1)),
          ),
          child: SizedBox(
            width: 35.w,
            height: 35.h,
            child: iconPath.endsWith('.svg')
                ? SvgPicture.asset(
                    iconPath,
                    fit: BoxFit.contain,
                  )
                : Image.asset(
                    iconPath,
                    fit: BoxFit.contain,
                  ),
          ),
        ),
      ),
    );
  }
}
