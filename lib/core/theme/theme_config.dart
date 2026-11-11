import 'package:flutter/material.dart';
import 'package:mis_compras_app/core/theme/app_tokens.dart';

enum AppAccent { lavanda, menta, durazno, rosa, cielo }

class _Tone {
  const _Tone({
    required this.primary,
    required this.primaryDark,
    required this.primarySoft,
    required this.onPrimary,
    required this.background,
  });

  final Color primary;
  final Color primaryDark;
  final Color primarySoft;
  final Color onPrimary;
  final Color background;

  static const lavanda = _Tone(
    primary: Color(0xFF8B6FAF),
    primaryDark: Color(0xFF6F568F),
    primarySoft: Color(0xFFF0EAF7),
    onPrimary: Color(0xFFFFFFFF),
    background: Color(0xFFFAF9FC),
  );

  static const menta = _Tone(
    primary: Color(0xFF5F9E8A),
    primaryDark: Color(0xFF477A6A),
    primarySoft: Color(0xFFE8F4EE),
    onPrimary: Color(0xFFFFFFFF),
    background: Color(0xFFF8FBF9),
  );

  static const durazno = _Tone(
    primary: Color(0xFFC98A6B),
    primaryDark: Color(0xFFA66C51),
    primarySoft: Color(0xFFFBEDE6),
    onPrimary: Color(0xFFFFFFFF),
    background: Color(0xFFFCFAF8),
  );

  static const rosa = _Tone(
    primary: Color(0xFFB9768E),
    primaryDark: Color(0xFF965A70),
    primarySoft: Color(0xFFF9EAF0),
    onPrimary: Color(0xFFFFFFFF),
    background: Color(0xFFFCF9FA),
  );

  static const cielo = _Tone(
    primary: Color(0xFF6E93B8),
    primaryDark: Color(0xFF537596),
    primarySoft: Color(0xFFEAF2FA),
    onPrimary: Color(0xFFFFFFFF),
    background: Color(0xFFF8FAFC),
  );
}

class ThemeConfig {
  const ThemeConfig._();

  static ThemeData getTheme({
    required bool isDarkMode,
    AppAccent accent = AppAccent.lavanda,
  }) {
    final tone = _toneFor(accent);
    final background = isDarkMode
        ? const Color(0xFF1A181D)
        : const Color(0xFFFFFFFF);
    final surface = isDarkMode
        ? const Color(0xFF26222D)
        : const Color(0xFFFFFFFF);
    final text = isDarkMode ? const Color(0xFFF4EFF8) : const Color(0xFF2F2A36);
    final textMuted = isDarkMode
        ? const Color(0xFFB7AEC4)
        : const Color(0xFF7C7487);
    final border = isDarkMode
        ? const Color(0xFF3E3748)
        : const Color(0xFFE2DDE8);

    final primary = isDarkMode ? _darkPrimary(accent) : tone.primary;
    final onPrimary = isDarkMode ? const Color(0xFF221E28) : tone.onPrimary;
    final primarySoft = isDarkMode ? const Color(0xFF3A3247) : tone.primarySoft;

    final scheme = ColorScheme(
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primarySoft,
      onPrimaryContainer: primary,
      secondary: isDarkMode ? _darkPrimary(accent) : tone.primaryDark,
      onSecondary: onPrimary,
      error: isDarkMode ? const Color(0xFFE08A8A) : const Color(0xFFC06464),
      onError: isDarkMode ? const Color(0xFF221E28) : const Color(0xFFFFFFFF),
      errorContainer: isDarkMode
          ? const Color(0xFF3A2323)
          : const Color(0xFFFBE9E9),
      onErrorContainer: isDarkMode
          ? const Color(0xFFE08A8A)
          : const Color(0xFFC06464),
      surface: surface,
      onSurface: text,
      outline: border,
      outlineVariant: border,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      appBarTheme: AppBarTheme(
        backgroundColor: surface,
        foregroundColor: text,
        centerTitle: true,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: BorderSide(color: primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: BorderSide(color: scheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: BorderSide(color: scheme.error),
        ),
      ),
      textTheme: ThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ).textTheme.apply(bodyColor: text, displayColor: text),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onPrimary,
          minimumSize: const Size(48, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surface,
        indicatorColor: isDarkMode ? const Color(0xFF3A3247) : tone.primarySoft,
        labelTextStyle: WidgetStatePropertyAll(
          TextStyle(
            color: textMuted,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  static Color accentColor({
    required AppAccent accent,
    required bool isDarkMode,
  }) {
    return isDarkMode ? _darkPrimary(accent) : _toneFor(accent).primary;
  }

  static _Tone _toneFor(AppAccent accent) {
    return switch (accent) {
      AppAccent.lavanda => _Tone.lavanda,
      AppAccent.menta => _Tone.menta,
      AppAccent.durazno => _Tone.durazno,
      AppAccent.rosa => _Tone.rosa,
      AppAccent.cielo => _Tone.cielo,
    };
  }

  static Color _darkPrimary(AppAccent accent) {
    return switch (accent) {
      AppAccent.lavanda => const Color(0xFFC4B0E6),
      AppAccent.menta => const Color(0xFF9FD9C4),
      AppAccent.durazno => const Color(0xFFF0B79A),
      AppAccent.rosa => const Color(0xFFE8AFC2),
      AppAccent.cielo => const Color(0xFFA9CBE8),
    };
  }
}
