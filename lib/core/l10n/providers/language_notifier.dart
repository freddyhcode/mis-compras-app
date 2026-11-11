part of 'language_provider.dart';

class LanguageNotifier extends Notifier<LanguageState> {
  final WrapperSecureStorage _storage = WrapperSecureStorageImpl();
  static const String _key = 'language';

  @override
  LanguageState build() {
    _loadLanguage();
    return LanguageState(languageCode: _deviceLanguageCode());
  }

  String _deviceLanguageCode() {
    final code = PlatformDispatcher.instance.locale.languageCode;
    return code == 'es' ? 'es' : 'en';
  }

  Future<void> _loadLanguage() async {
    final saved = await _storage.getKeyValue<String>(_key);
    if (saved == 'en' || saved == 'es') {
      state = state.copyWith(languageCode: saved);
    }
  }

  Future<void> setLanguage(String languageCode) async {
    state = state.copyWith(languageCode: languageCode);
    try {
      await _storage.setKeyValue<String>(_key, languageCode);
    } catch (_) {
      // La UI cambia igual; solo falla la persistencia.
    }
  }

  Future<void> reset() async {
    state = LanguageState(languageCode: _deviceLanguageCode());
    await _storage.removeKey(_key);
  }
}
