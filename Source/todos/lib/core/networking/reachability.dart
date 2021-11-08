/// https://stackoverflow.com/questions/55016701/flutter-how-to-check-for-internet-connection#55016840
/// https://medium.com/flutter-community/checking-network-connectivity-in-flutter-7985659d6e06
/// https://pub.dev/packages/connectivity/install

import 'package:connectivity/connectivity.dart';

class Reachability {
  /// MARK: - Constructors

  /// MARK: - Local methods

  /// MARK: - Public methods
  static Future<bool> reachable() async {
    final ConnectivityResult result = await Connectivity().checkConnectivity();

    if (result == ConnectivityResult.mobile) {
      return true;
    } else if (result == ConnectivityResult.wifi) {
      return true;
    }

    return false;
  }
}
