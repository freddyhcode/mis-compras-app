part of 'theme_provider.dart';

class ThemeNotifier extends Notifier<ThemeState> {
  final WrapperSecureStorage _storage = WrapperSecureStorageImpl();
  static const String _darkKey = 'is_dark_mode';
  static const String _accentKey = 'accent';

  @override
  ThemeState build() {
    _loadTheme();
    return const ThemeState();
  }

  Future<void> _loadTheme() async {
    final isDark = await _storage.getKeyValue<bool>(_darkKey);
    final accentName = await _storage.getKeyValue<String>(_accentKey);
    final accent = AppAccent.values.firstWhere(
      (value) => value.name == accentName,
      orElse: () => AppAccent.lavanda,
    );

    state = state.copyWith(isDarkMode: isDark ?? false, accent: accent);
  }

  Future<void> toggleDarkMode(bool value) async {
    state = state.copyWith(isDarkMode: value);
    try {
      await _storage.setKeyValue<bool>(_darkKey, value);
    } catch (_) {
      // La UI cambia igual; solo falla la persistencia.
    }
  }

  Future<void> setAccent(AppAccent value) async {
    state = state.copyWith(accent: value);
    try {
      await _storage.setKeyValue<String>(_accentKey, value.name);
    } catch (_) {
      // La UI cambia igual; solo falla la persistencia.
    }
  }

  Future<void> reset() async {
    state = const ThemeState();
    await _storage.removeKey(_darkKey);
    await _storage.removeKey(_accentKey);
  }
}
