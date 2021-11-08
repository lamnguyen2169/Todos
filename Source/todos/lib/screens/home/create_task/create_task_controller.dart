/// https://stackoverflow.com/questions/55552230/flutter-validate-a-phone-number-using-regex

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../../base/base.dart';
import '../../../core/core.dart';
import '../../../utilities/utilities.dart';

import 'create_task_event.dart';

class CreateTaskController extends BaseController {
  /// MARK: - Local properties
  final TaskService _taskService = TaskService();

  final BehaviorSubject<String> _inputSubject = BehaviorSubject<String>();
  final BehaviorSubject<DateTime?> _dateSubject = BehaviorSubject<DateTime?>();
  final BehaviorSubject<bool> _validationSubject = BehaviorSubject<bool>();

  StreamTransformer<String, bool> _inputValidation = StreamTransformer<String, bool>.fromHandlers(handleData: (value, sink) {
    sink.add(value.trim().length > 0);
  });

  /// MARK: - Public properties
  final TextEditingController inputController = TextEditingController();

  Stream<bool> get inputStream => _inputSubject.transform(_inputValidation);

  RxSink<String> get inputSink => RxSink(_inputSubject);

  ValueStream<DateTime?> get dateStream => _dateSubject.stream;

  RxSink<DateTime?> get dateSink => RxSink(_dateSubject);

  ValueStream<bool> get validationStream => _validationSubject.stream;

  RxSink<bool> get validationSink => RxSink(_validationSubject);

  /// MARK: - Constructors
  CreateTaskController([BaseController? parent]) : super(parent) {
    _registerObserver();
  }

  /// MARK: - override methods
  @override
  void dispatchEvent(BaseEvent event) {
    // TODO: implement dispatchEvent
    super.dispatchEvent(event);

    if (event is CreateTaskEvent) {
      _createTask(event.title, event.endTime);
    }
  }

  @override
  void dispose() {
    super.dispose();

    _inputSubject.close();
    _dateSubject.close();
    _validationSubject.close();
  }

  /// MARK: - Local methods
  void _registerObserver() {
    Rx.combineLatest([_inputSubject], (List<String> values) {
      return (values.first.trim().length > 0);
    }).listen((isEnabled) {
      this.validationSink.add(isEnabled);
    });
  }

  void _createTask(String title, [DateTime? endTime]) {
    title = title.trim();

    if (title.length > 0) {
      final DateTime creationTime = DateTime.now();
      final Task task = Task(
        title: title,
        creationTime: creationTime,
        updateTime: creationTime,
        endTime: endTime,
      );

      Rx.fromCallable(() => _taskService.insertTask(task))
          .doOnError((error, stackTrace) => Stream.fromFuture(Future.value(null)))
          .listen((value) {
        if (value != null) {
          if (this.parent != null) {
            this.parent!.reloadData(ReloadEvent());
          }

          this.listenerSink.add(CreateTaskSuccessEvent());
        } else {
          this.listenerSink.add(CreateTaskFailureEvent(APPError.withMessage('Create task failed!')));
        }
      });
    } else {
      this.listenerSink.add(CreateTaskFailureEvent(APPError.withMessage('Create task failed!')));
    }
  }

  /// MARK: - Public methods
}
