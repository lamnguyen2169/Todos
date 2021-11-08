///

import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../../../base/base.dart';
import '../../../core/core.dart';
import '../../../utilities/utilities.dart';

import 'task_card_event.dart';

class TaskCardController extends BaseController {
  /// MARK: - Local properties
  final BehaviorSubject<Task> _taskSubject = BehaviorSubject<Task>();

  /// MARK: - Public properties
  late Task task;

  ValueStream<Task> get taskStream => _taskSubject.stream;

  RxSink<Task> get taskSink => RxSink(_taskSubject);

  /// MARK: - Constructors
  TaskCardController(Task task, [BaseController? parent]) : super(parent) {
    if (task is Task) {
      this.task = task;
    }
  }

  /// MARK: - override methods
  @override
  void dispatchEvent(BaseEvent event) {
    // TODO: implement dispatchEvent
    super.dispatchEvent(event);

    if (event is TaskCardEvent) {
      //
    }
  }

  @override
  void dispose() {
    super.dispose();

    _taskSubject.close();
  }

  /// MARK: - Local methods

  /// MARK: - Public methods
}
