/// https://pub.dev/packages/google_maps_flutter
/// https://cafedev.vn/tu-hoc-flutter-tim-hieu-ve-google-maps-trong-flutter/

import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../../base/base.dart';
import '../../core/core.dart';
import '../../extensions/extensions.dart';
import '../../macros/macros.dart';
import '../../utilities/utilities.dart';

import 'home_event.dart';

class HomeController extends BaseController implements DataObserver {
  /// MARK: - Local properties
  final TaskService _taskService = TaskService();

  final BehaviorSubject<List<Task>> _listSubject = BehaviorSubject<List<Task>>();

  List<Task> _tasks = [];

  /// MARK: - Public properties
  ValueStream<List<Task>> get listStream => _listSubject.stream;

  RxSink<List<Task>> get listSink => RxSink(_listSubject);

  /// MARK: - Constructors
  HomeController([BaseController? parent]) : super(parent) {
    _registerObserver();
    _fetchTasks();
  }

  /// MARK: - override methods
  @override
  void dispatchEvent(BaseEvent event) {
    // TODO: implement dispatchEvent
    super.dispatchEvent(event);

    if (event is HomeEvent) {
      final Task task = event.task;

      if (task.isDone) {
        _handleTaskUndone(task);
      } else {
        _handleTaskDone(task);
      }
    } else if (event is HomeDeleteEvent) {
      _handleTaskDeleted(event.task);
    }
  }

  @override
  void dispose() {
    super.dispose();

    DataObserverManager.unregister(this);
    _listSubject.close();
  }

  /// MARK: - DataObserver
  @override
  List<String> types() {
    return ['$Task'];
  }

  @override
  void dataObserverObjectDidInsert(object) {
    // TODO: implement dataObserverObjectDidInsert
    if (object is Task) {
      List<Task> duplicates = _tasks.filterBy((element) => (element == object)).toList();

      if (duplicates.length == 0) {
        _tasks.add(object);
        _tasks = _tasks.sortByDescending((element) => element.creationTime).toList();

        this.listSink.add(_tasks);
      }
    }
  }

  @override
  void dataObserverObjectDidUpdate(object, original) {
    // TODO: implement dataObserverObjectDidUpdate
    if ((object is Task) && (original is Task)) {
      List<Task> duplicates = _tasks.filterBy((element) => (element == object)).toList();

      if (duplicates.length > 0) {
        _tasks.replaceAt(_tasks.indexOf(original), object);
        _tasks = _tasks.sortByDescending((element) => element.creationTime).toList();

        this.listSink.add(_tasks);
      }
    }
  }

  @override
  void dataObservedObjectDidDelete(object) {
    // TODO: implement dataObservedObjectDidDelete
    if (object is Task) {
      List<Task> duplicates = _tasks.filterBy((element) => (element == object)).toList();

      if (duplicates.length > 0) {
        _tasks = _tasks.removeList(duplicates).toList();

        this.listSink.add(_tasks);
      }
    }
  }

  /// MARK: - Local methods
  void _registerObserver() {
    DataObserverManager.register(this);
  }

  void _fetchTasks() {
    Rx.fromCallable(() => _taskService.fetchTasks())
        .doOnError((error, stackTrace) => Stream.fromFuture(Future.value(<Task>[])))
        .listen((value) {
      _tasks = [...value];

      this.listSink.add(_tasks);
    });
  }

  void _handleTaskDone(Task task) {
    Rx.fromCallable(() => _taskService.doneTask(task))
        .doOnError((error, stackTrace) => Stream.fromFuture(Future.value(false)))
        .listen((value) {
      if (value) {
        this.listSink.add(_tasks);
      }
    });
  }

  void _handleTaskUndone(Task task) {
    Rx.fromCallable(() => _taskService.undoneTask(task))
        .doOnError((error, stackTrace) => Stream.fromFuture(Future.value(false)))
        .listen((value) {
      if (value) {
        this.listSink.add(_tasks);
      }
    });
  }

  void _handleTaskDeleted(Task task) {
    Rx.fromCallable(() => _taskService.deleteTask(task))
        .doOnError((error, stackTrace) => Stream.fromFuture(Future.value(false)))
        .listen((value) {
      if (value) {
        this.listSink.add(_tasks);
      }
    });
  }

  /// MARK: - Public methods
}
