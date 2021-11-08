/// https://stackoverflow.com/questions/17552757/is-there-any-way-to-cancel-a-dart-future

import 'dart:async';

import 'package:async/async.dart';

typedef SEL = void Function();

class Block {
  static Map<dynamic, Map<String, CancelableOperation>> _operations = Map<dynamic, Map<String, CancelableOperation>>();

  /// MARK: - Constructors

  /// MARK: - Local methods
  static void _setOperation(CancelableOperation operation, dynamic target, String key) {
    Map<String, CancelableOperation>? dictionary = _operations[target];

    if (dictionary == null) {
      dictionary = Map<String, CancelableOperation>();
      _operations[target] = dictionary;
    }

    dictionary[key] = operation;
  }

  static void _removeOperation(dynamic target, [String? key]) {
    if (key != null) {
      final Map<String, CancelableOperation>? dictionary = _operations[target];

      if (dictionary != null) {
        dictionary[key]?.cancel();
        dictionary.remove(key);
      }
    } else {
      _operations.remove(target);
    }
  }

  /// MARK: - Public methods
  static void performSelector(
    SEL selector, {
    Duration afterDelay = Duration.zero,
  }) {
    Future.delayed(afterDelay, () async {
      selector();
    });
  }

  static void performSelectorWithTarget(
    SEL selector, {
    required dynamic target,
    required String key,
    Duration afterDelay = Duration.zero,
  }) {
    Block.performOperationWithTarget(
      Future.delayed(afterDelay),
      target: target,
      key: key,
      onValue: (value) {
        selector();
      },
      onCancel: () {},
    );
  }

  static void cancelSelectorWithTarget(dynamic target, {String? key}) {
    Block.cancelOperationWithTarget(target, key: key);
  }

  static void performOperationWithTarget<T>(
    Future<T> future, {
    required dynamic target,
    required String key,
    required FutureOr Function(T value) onValue,
    FutureOr Function()? onCancel,
  }) {
    final CancelableOperation<T> operation = CancelableOperation<T>.fromFuture(
      future,
      onCancel: onCancel,
    );

    Block._removeOperation(target, key);
    Block._setOperation(operation, target, key);

    operation.then((value) {
      onValue(value);
      Block._removeOperation(target, key);
    });
  }

  static void cancelOperationWithTarget(dynamic target, {String? key}) {
    Block._removeOperation(target, key);
  }
}
