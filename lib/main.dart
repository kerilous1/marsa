import 'app_config.dart';
import 'main_common.dart';

/// Default entry point when running without `--target lib/main_*.dart`.
/// Defaults safely to Development flavor.
void main() {
  AppConfig.initialize(
    flavor: Flavor.dev,
    appName: 'MARSA Dev',
    packageSuffix: '.dev',
    databaseName: 'marsa_dev.sqlite',
  );

  mainCommon();
}
