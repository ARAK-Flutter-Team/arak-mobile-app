import 'package:arak_app/shared/providers/locale_provider.dart';
import 'package:arak_app/shared/theme/app_theme.dart';
import 'package:arak_app/shared/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// مهمين جدًا
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app_router.dart';
import 'core/di/injection_container.dart';
import 'l10n/app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  runApp(
    ProviderScope(
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        builder: (context, child) {
          return const MyApp();
        },
      ),
    ),
  );
}

TextTheme applyFont(TextTheme base, String fontFamily) {
  return base.copyWith(
    displayLarge: base.displayLarge?.copyWith(fontFamily: fontFamily),
    displayMedium: base.displayMedium?.copyWith(fontFamily: fontFamily),
    displaySmall: base.displaySmall?.copyWith(fontFamily: fontFamily),
    headlineLarge: base.headlineLarge?.copyWith(fontFamily: fontFamily),
    headlineMedium: base.headlineMedium?.copyWith(fontFamily: fontFamily),
    headlineSmall: base.headlineSmall?.copyWith(fontFamily: fontFamily),
    titleLarge: base.titleLarge?.copyWith(fontFamily: fontFamily),
    titleMedium: base.titleMedium?.copyWith(fontFamily: fontFamily),
    titleSmall: base.titleSmall?.copyWith(fontFamily: fontFamily),
    bodyLarge: base.bodyLarge?.copyWith(fontFamily: fontFamily),
    bodyMedium: base.bodyMedium?.copyWith(fontFamily: fontFamily),
    bodySmall: base.bodySmall?.copyWith(fontFamily: fontFamily),
    labelLarge: base.labelLarge?.copyWith(fontFamily: fontFamily),
    labelMedium: base.labelMedium?.copyWith(fontFamily: fontFamily),
    labelSmall: base.labelSmall?.copyWith(fontFamily: fontFamily),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeProvider);
    final locale = ref.watch(localeProvider);

    final fontFamily =
    locale.languageCode == 'ar' ? 'Tajawal' : 'Poppins';

    return MaterialApp.router(
      title: 'Arak',
      debugShowCheckedModeBanner: false,

      /// ✅ Light Theme
      theme: AppTheme.lightTheme.copyWith(
        textTheme: applyFont(
          AppTheme.lightTheme.textTheme,
          fontFamily,
        ),
      ),

      /// ✅ Dark Theme
      darkTheme: AppTheme.darkTheme.copyWith(
        textTheme: applyFont(
          AppTheme.darkTheme.textTheme,
          fontFamily,
        ),
      ),

      /// ✅ التحكم في الوضع (دارك / لايت)
      themeMode: themeMode,

      routerConfig: router,
      locale: locale,

      /// ✅ اللغات
      supportedLocales: AppLocalizations.supportedLocales,

      /// ✅ الترجمة
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}