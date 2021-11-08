///

enum ObserverType { insert, update, delete }

abstract class DataObserver<T> {
  /// MARK: - abstract methods
  List<String> types();

  void dataObserverObjectDidInsert(T object);

  void dataObserverObjectDidUpdate(T object, T? original);

  void dataObservedObjectDidDelete(T object);
}

class DataObserverManager<T> {
  final Map<String, List<DataObserver>> observers = <String, List<DataObserver>>{};

  /// Singleton
  DataObserverManager._();

  static final DataObserverManager instance = DataObserverManager._();

  /// MARK: - Getter/Setter

  /// MARK: - Local methods

  /// MARK: - Public methods
  static void register(DataObserver observer) {
    final DataObserverManager instance = DataObserverManager.instance;
    final List<String> types = observer.types();

    if (types.length > 0) {
      for (String type in types) {
        final List<DataObserver> observers = instance.observers[type] ?? <DataObserver>[];

        if (!observers.contains(observer)) {
          observers.add(observer);
        }

        instance.observers[type] = observers;
      }
    }
  }

  static void unregister(DataObserver observer) {
    final DataObserverManager instance = DataObserverManager.instance;

    instance.observers.forEach((key, value) {
      if (value.contains(observer)) {
        value.remove(observer);
      }
    });
  }

  static void notify(ObserverType type, dynamic object, [dynamic original]) {
    if ((object is List) || (object is Set)) {
      final List<dynamic> objects = object.toList();
      final List<dynamic>? originals = original?.toList();

      for (int index = 0; index < objects.length; ++index) {
        final dynamic object = objects[index];
        final dynamic original = originals?[index];

        notify(type, object, original);
      }
    } else if (object is Map) {
      final Map<dynamic, dynamic> objects = object;
      final Map<dynamic, dynamic>? originals = original;

      objects.forEach((key, value) {
        final dynamic object = objects[key];
        final dynamic original = originals?[key];

        notify(type, object, original);
      });
    } else {
      final DataObserverManager instance = DataObserverManager.instance;
      final List<DataObserver> observers = instance.observers[object.runtimeType.toString()] ?? <DataObserver>[];

      for (DataObserver observer in observers) {
        if (type == ObserverType.insert) {
          observer.dataObserverObjectDidInsert(object);
        } else if (type == ObserverType.update) {
          observer.dataObserverObjectDidUpdate(object, original);
        } else if (type == ObserverType.delete) {
          observer.dataObservedObjectDidDelete(object);
        }
      }
    }
  }
}
