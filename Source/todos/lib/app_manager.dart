///

import 'dart:async';

import 'core/core.dart';

class AppManager {
  static Future<void> startup() async {
    /// Do all configurations here before starting up the application.
    await DatabaseManager.startup();
  }
}
