///

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../utilities/utilities.dart';

import 'base_event.dart';

abstract class BaseController with ChangeNotifier {
  /// MARK: - Local properties
  final BehaviorSubject<BaseEvent?> _eventSubject = BehaviorSubject<BaseEvent?>();
  final BehaviorSubject<bool> _loadingSubject = BehaviorSubject<bool>();
  final BehaviorSubject<BaseEvent> _listenerSubject = BehaviorSubject<BaseEvent>();

  BaseController? _parent;
  StreamSubscription<BaseEvent?>? _eventSubscription;

  /// MARK: - Public properties
  BaseController? get parent => _parent;

  BaseEvent? get latestEvent => _eventSubject.stream.hasValue ? _eventSubject.stream.value : null;

  /// When pass null event to the stream, it means that the previous tasks are doned.
  /// We want to 'clean up' the stream by flushing it.
  RxSink<BaseEvent?> get event => RxSink(_eventSubject);

  ValueStream<bool> get loadingStream => _loadingSubject.stream;

  RxSink<bool> get loadingSink => RxSink(_loadingSubject);

  ValueStream<BaseEvent> get listenerStream => _listenerSubject.stream;

  RxSink<BaseEvent> get listenerSink => RxSink(_listenerSubject);

  /// MARK: - Getter/Setter
  bool get isDisposed => (_eventSubject.isClosed || _loadingSubject.isClosed || _listenerSubject.isClosed);

  /// MARK: - abstract methods

  /// MARK: - Constructors
  @mustCallSuper
  BaseController([BaseController? parent]) {
    _parent = parent;

    _registerEventListener();
  }

  /// MARK: - Local methods
  void _registerEventListener() {
    _eventSubscription = _eventSubject.stream.listen((event) {
      if (event is BaseEvent) {
        dispatchEvent(event);
      }
    });
  }

  /// MARK: - Public methods
  @mustCallSuper
  void dispatchEvent(BaseEvent event) {
    ///
  }

  @mustCallSuper
  void dispose() {
    super.dispose();

    _eventSubject.close();
    _loadingSubject.close();
    _listenerSubject.close();
    _eventSubscription?.cancel();

    Block.cancelOperationWithTarget(this);
  }

  void reloadData(ReloadEvent event) {}

  void addEvent(BaseEvent? event) {
    if (event is ReloadEvent) {
      reloadData(event);
    } else {
      this.event.add(event);
    }
  }

  void flushEvent() {
    /// When pass null event to the stream, it means that the previous tasks are doned.
    /// We want to 'clean up' the stream by flushing it.
    addEvent(null);
  }

  void addEventDelayed(
    BaseEvent? event, [
    Duration duration = Duration.zero,
  ]) {
    Block.performSelectorWithTarget(
      () {
        addEvent(event);
      },
      target: this,
      key: 'addEventDelayed',
      afterDelay: duration,
    );
  }

  void cancelDelayedEvent() {
    Block.cancelSelectorWithTarget(this, key: 'addEventDelayed');
  }
}
