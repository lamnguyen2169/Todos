///

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class RxSink<T> extends ChangeNotifier {
  BehaviorSubject<T> subject;
  bool isPaused;

  /// MARK: - Getter/Setter
  StreamSink<T> get sink => this.subject.sink;

  /// MARK: - Constructors
  RxSink(BehaviorSubject<T> subject)
      : this.subject = subject,
        this.isPaused = false;

  /// MARK: - override properties
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  /// MARK: - Local methods

  /// MARK: - Public methods
  void add(T data, [bool forcesUpdate = false]) {
    if (!this.subject.isClosed && (!this.isPaused || forcesUpdate)) {
      this.sink.add(data);
    }
  }

  void pause() {
    this.isPaused = true;
  }

  void resume() {
    this.isPaused = false;
  }
}
