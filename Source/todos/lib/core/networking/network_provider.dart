/// If you are using an Android emulator then localhost on the emulator is not 127.0.0.0 it is 10.0.2.2,
/// so, on Android emulator you need to write https://10.0.2.2:8000,
/// the https://127.0.0.1:8000 will not work on real device too.
/// because localhost means something different on real device.
///
/// For more information on how to connect a Flutter app to localhost on emulator or
/// on a real device click on the link Connecting Flutter application to Localhost
/// https://stackoverflow.com/questions/47372568/how-to-point-to-localhost8000-with-the-dart-http-package-in-flutter
/// https://www.flutterclutter.dev/flutter/tutorials/how-to-detect-what-platform-a-flutter-app-is-running-on/2020/127/
/// import 'dart:io';
/// import 'package:flutter/foundation.dart' show kIsWeb;
/// class PlatformInfo {
///   bool isDesktopOS() {
///     return Platform.isMacOS || Platform.isLinux || Platform.isWindows;
///   }
///   bool isAppOS() {
///     return Platform.isMacOS || Platform.isAndroid;
///   }
///   bool isWeb() {
///     return kIsWeb;
///   }
///   PlatformType getCurrentPlatformType() {
///     if (kIsWeb) {
///       return PlatformType.Web;
///     }
///     if (Platform.isMacOS) {
///       return PlatformType.MacOS;
///     }
///     if (Platform.isFuchsia) {
///       return PlatformType.Fuchsia;
///     }
///     if (Platform.isLinux) {
///       return PlatformType.Linux;
///     }
///     if (Platform.isWindows) {
///       return PlatformType.Windows;
///     }
///     if (Platform.isIOS) {
///       return PlatformType.iOS;
///     }
///     if (Platform.isAndroid) {
///       return PlatformType.Android;
///     }
///     return PlatformType.Unknown;
///   }
/// }
/// enum PlatformType {
///   Web,
///   iOS,
///   Android,
///   MacOS,
///   Fuchsia,
///   Linux,
///   Windows,
///   Unknown
/// }
///
/// https://stackoverflow.com/questions/56740793/using-interceptor-in-dio-for-flutter-to-refresh-token

import 'dart:io';

import 'package:dio/dio.dart';

import '../caches/caches.dart';
import '../models/models.dart';
import '../../macros/macros.dart';

class RequestPath {
  static final String base = Platform.isAndroid ? 'http://10.0.2.2:8000' : 'http://localhost:8000';
}

class NetworkProvider {
  static BaseOptions _backendOptions = BaseOptions(
    baseUrl: RequestPath.base,
    connectTimeout: 5 * 60 * 1000, // Timeout in milliseconds for opening url
    receiveTimeout: 5 * 60 * 1000, // Timeout in milliseconds for opening url
  );

  static Dio _backend = Dio(_backendOptions);

  /// MARK: - Getter/Setter
  Dio get backend => _backend;

  /// Singleton
  NetworkProvider._() {
    // You can set LogInterceptor to print request/response log automaticlly.
    _backend.interceptors.add(LogInterceptor(responseBody: true));
    _backend.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioError error, handler) {
        return handler.next(error);
      },
    ));
  }

  static final NetworkProvider instance = NetworkProvider._();
}
