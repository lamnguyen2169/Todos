///

import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../../../base/base.dart';
import '../../../core/core.dart';
import '../../../extensions/extensions.dart';
import '../../../utilities/utilities.dart';

import 'task_event.dart';

class TaskController extends BaseController implements DataObserver {
  /// MARK: - Local properties
  final TaskService _taskService = TaskService();

  final BehaviorSubject<List<Task>> _listSubject = BehaviorSubject<List<Task>>();

  List<Task> _tasks = [];

  /// MARK: - Public properties
  ValueStream<List<Task>> get listStream => _listSubject.stream;

  RxSink<List<Task>> get listSink => RxSink(_listSubject);

  /// MARK: - Constructors
  TaskController([BaseController? parent]) : super(parent) {
    _registerObserver();
    _fetchTasks();
  }

  /// MARK: - override methods
  @override
  void dispatchEvent(BaseEvent event) {
    // TODO: implement dispatchEvent
    super.dispatchEvent(event);

    if (event is TaskEvent) {
      _handleTaskDone(event.task);
    } else if (event is TaskDeleteEvent) {
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

      if (!object.isDone && (duplicates.length == 0)) {
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
      List<Task> duplicates = _tasks.filterBy((element) => (element == original)).toList();

      if (!object.isDone && (duplicates.length == 0)) {
        _tasks.add(object);
      } else {
        _tasks = _tasks.removeList(duplicates).toList();
      }

      _tasks = _tasks.sortByDescending((element) => element.creationTime).toList();

      this.listSink.add(_tasks);
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
    Rx.fromCallable(() => _taskService.fetchUndoneTasks())
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
        _tasks.remove(task);

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
