/// https://flutter.dev/docs/cookbook/persistence/sqlite
/// https://stackoverflow.com/questions/43928702/how-to-change-the-application-launcher-icon-on-flutter
/// https://stackoverflow.com/questions/65438033/flutter-splash-flicker-issue
/// https://flutter.dev/docs/development/add-to-app/ios/project-setup#local-network-privacy-permissions

import 'package:flutter/material.dart';

import 'app.dart';
import 'app_manager.dart';

void main() {
  // Avoid errors caused by flutter upgrade (before starting up database).
  // Importing 'package:flutter/widgets.dart' is required.
  // https://flutter.dev/docs/cookbook/persistence/sqlite
  WidgetsFlutterBinding.ensureInitialized();

  AppManager.startup().then((value) {
    App.launch();
  });
}
