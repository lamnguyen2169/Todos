///

import '../data_observer/data_observer.dart';

abstract class Repository {
  /// MARK: - abstract methods
  void objectDidInsert(dynamic object) {
    DataObserverManager.notify(ObserverType.insert, object);
  }

  void objectDidUpdate(dynamic object, [dynamic original]) {
    DataObserverManager.notify(ObserverType.update, object, original);
  }

  void objectDidDelete(dynamic object) {
    DataObserverManager.notify(ObserverType.delete, object);
  }
}
