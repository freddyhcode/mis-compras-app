import 'package:mis_compras_app/core/l10n/app_localizations.dart';
import 'package:mis_compras_app/core/theme/theme_config.dart';

String themeLabel(AppLocalizations l10n, bool isDarkMode) {
  return isDarkMode ? l10n.settingsDark : l10n.settingsLight;
}

String accentLabel(AppLocalizations l10n, AppAccent accent) {
  return switch (accent) {
    AppAccent.lavanda => l10n.accentLavanda,
    AppAccent.menta => l10n.accentMenta,
    AppAccent.durazno => l10n.accentDurazno,
    AppAccent.rosa => l10n.accentRosa,
    AppAccent.cielo => l10n.accentCielo,
  };
}
