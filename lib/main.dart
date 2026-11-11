import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:mis_compras_app/core/config/branding.dart';
import 'package:mis_compras_app/core/l10n/app_localizations.dart';
import 'package:mis_compras_app/core/l10n/providers/language_provider.dart';
import 'package:mis_compras_app/core/router/app_router.dart';
import 'package:mis_compras_app/core/theme/providers/theme_provider.dart';
import 'package:mis_compras_app/core/theme/theme_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  runApp(const ProviderScope(child: MisComprasApp()));
}

class MisComprasApp extends ConsumerWidget {
  const MisComprasApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final theme = ref.watch(themeProvider);
    final language = ref.watch(languageProvider);

    return MaterialApp.router(
      title: Branding.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeConfig.getTheme(isDarkMode: false, accent: theme.accent),
      darkTheme: ThemeConfig.getTheme(isDarkMode: true, accent: theme.accent),
      themeMode: theme.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      locale: Locale(language.languageCode),
      localizationsDelegates: [
        AppLocalizations.delegate,
        ...GlobalMaterialLocalizations.delegates,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    );
  }
}
