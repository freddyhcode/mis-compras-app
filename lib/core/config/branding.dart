class Branding {
  const Branding._();

  static const String appName = String.fromEnvironment(
    'APP_NAME',
    defaultValue: 'Mis Compras',
  );
  static const String creator = String.fromEnvironment(
    'APP_CREATOR',
    defaultValue: '',
  );
  static const String contact = String.fromEnvironment(
    'APP_CONTACT',
    defaultValue: '',
  );
  static const String website = String.fromEnvironment(
    'APP_WEBSITE',
    defaultValue: '',
  );
  static const String github = String.fromEnvironment(
    'APP_GITHUB',
    defaultValue: '',
  );
  static const String support = String.fromEnvironment(
    'APP_SUPPORT',
    defaultValue: '',
  );
}
