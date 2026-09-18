/// Enumeration of all supported application runtime flavors.
enum Flavor { dev, prod }

/// Global configuration singleton holding flavor-specific environment parameters.
///
/// Ensures strict separation of application identifiers, database instances,
/// and branding between development and production environments.
class AppConfig {
  final Flavor flavor;
  final String appName;
  final String packageSuffix;
  final String databaseName;

  static late final AppConfig instance;

  const AppConfig._({
    required this.flavor,
    required this.appName,
    required this.packageSuffix,
    required this.databaseName,
  });

  /// Initializes the singleton configuration before runApp is called.
  static void initialize({
    required Flavor flavor,
    required String appName,
    required String packageSuffix,
    required String databaseName,
  }) {
    instance = AppConfig._(
      flavor: flavor,
      appName: appName,
      packageSuffix: packageSuffix,
      databaseName: databaseName,
    );
  }

  /// Whether current running environment is development.
  bool get isDev => flavor == Flavor.dev;

  /// Whether current running environment is production.
  bool get isProd => flavor == Flavor.prod;
}
