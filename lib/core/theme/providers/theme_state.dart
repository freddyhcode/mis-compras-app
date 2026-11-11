part of 'theme_provider.dart';

class ThemeState {
  const ThemeState({this.isDarkMode = false, this.accent = AppAccent.lavanda});

  final bool isDarkMode;
  final AppAccent accent;

  ThemeState copyWith({bool? isDarkMode, AppAccent? accent}) {
    return ThemeState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      accent: accent ?? this.accent,
    );
  }
}
