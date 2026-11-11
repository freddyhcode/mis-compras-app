enum AppMode { development, demo, production }

class AppConfig {
  const AppConfig._();

  static const String _mode = String.fromEnvironment(
    'APP_MODE',
    defaultValue: 'production',
  );

  static AppMode mode() {
    return switch (_mode) {
      'development' => AppMode.development,
      'demo' => AppMode.demo,
      _ => AppMode.production,
    };
  }

  static bool isDevelopment() => mode() == AppMode.development;
}
