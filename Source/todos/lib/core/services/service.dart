///

import 'dart:async';

import 'package:dio/dio.dart';

import '../models/models.dart';
import '../networking/networking.dart';

abstract class Service {
  /// MARK: - Public methods
  static Future<T> request<T extends dynamic>({
    required FutureOr<T> Function() builder,
    required void Function(Completer<T> completer, T value) onValue,
    void Function(Completer<T> completer, APPError error)? onError,
  }) async {
    final Completer<T> completer = Completer<T>();

    Reachability.reachable().then((isReachable) async {
      if (isReachable) {
        dynamic value;
        APPError error = APPError.unknown();

        try {
          value = await builder();
        } on DioError catch (dioError) {
          if (dioError.response != null) {
            final Response response = dioError.response!;

            if (APPError.validated(response.data)) {
              error = APPError.fromJson(response.data);
            } else if ((response.statusCode != null) && (response.statusMessage != null)) {
              error = APPError(code: response.statusCode!, message: response.statusMessage!);
            }
          } else if (dioError.error != null) {
            print('dioError.error=${dioError.error}');

            error = APPError.internalServerError();
          }
        } catch (exception) {
          print('exception=$exception');
          error = APPError.withMessage(exception.toString());
        }

        if (value != null) {
          onValue(completer, value);
        } else if (onError != null) {
          onError(completer, error);
        }
      } else {
        if (onError != null) {
          onError(completer, APPError.notReachable());
        }
      }
    });

    return completer.future;
  }
}
