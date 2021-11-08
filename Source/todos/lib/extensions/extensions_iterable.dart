/// https://stackoverflow.com/questions/53547997/sort-a-list-of-objects-in-flutter-dart-by-property-value

extension IterableExtensions<T> on List<T> {
  Iterable<T> sortBy<TSelected extends Comparable<TSelected>>(TSelected Function(T) selector) =>
      toList()..sort((a, b) => selector(a).compareTo(selector(b)));

  Iterable<T> sortByDescending<TSelected extends Comparable<TSelected>>(TSelected Function(T) selector) =>
      sortBy(selector).toList().reversed;

  Iterable<T> filterBy(bool Function(T) selector) => toList().where((element) => selector(element));

  Iterable<T> removeList(Iterable<T> list) => toList().filterBy((element) => !list.contains(element));

  void replaceAt(int index, T object) {
    removeAt(index);
    insert(index, object);
  }
}
