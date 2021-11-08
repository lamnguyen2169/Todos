/// https://medium.com/flutter-community/navigate-without-a-buildcontext-in-flutter-code-guide-2d344ee0e4d6
/// https://stackoverflow.com/questions/46483949/how-to-get-current-route-path-in-flutter

import 'dart:io';

import 'package:flutter/material.dart';

import '../router_controller.dart';

class DeviceUtility {
  /// MARK: - Getter/Setter
  static double get devicePixelRatio {
    final BuildContext? context = RouterController.currentContext;

    if (Platform.isAndroid && (context != null)) {
      return MediaQuery.of(context).devicePixelRatio;
    }

    return 1;
  }

  /// Singleton
  DeviceUtility._();

  static final DeviceUtility instance = DeviceUtility._();
}
