///

import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class Cache {
  /// MARK: - Getter/Setter
  Future<bool> set(String key, String value) async {
    final Completer<bool> completer = Completer<bool>();

    SharedPreferences.getInstance().then((preferences) {
      completer.complete(preferences.setString(key, value));
    });

    return completer.future;
  }

  /// Singleton
  Cache._();

  static final Cache instance = Cache._();

  /// MARK: - Public methods
  Future<dynamic> get(String key) async {
    final Completer<dynamic> completer = Completer<dynamic>();

    SharedPreferences.getInstance().then((preferences) {
      completer.complete(preferences.get(key));
    });

    return completer.future;
  }

  Future<bool> remove(String key) async {
    final Completer<bool> completer = Completer<bool>();

    SharedPreferences.getInstance().then((preferences) {
      completer.complete(preferences.remove(key));
    });

    return completer.future;
  }
}
