part of 'language_provider.dart';

class LanguageState {
  const LanguageState({this.languageCode = 'en'});

  final String languageCode;

  LanguageState copyWith({String? languageCode}) {
    return LanguageState(languageCode: languageCode ?? this.languageCode);
  }
}
