///

import '../../base/base.dart';
import '../../core/core.dart';

class HomeEvent extends BaseEvent {
  Task task;

  HomeEvent(Task task) : this.task = task;
}

class HomeDeleteEvent extends BaseEvent {
  Task task;

  HomeDeleteEvent(Task task) : this.task = task;
}

class HomeSuccessEvent extends BaseEvent {
  HomeSuccessEvent();
}

class HomeFailureEvent extends BaseEvent {
  APPError error;

  HomeFailureEvent(this.error);
}
