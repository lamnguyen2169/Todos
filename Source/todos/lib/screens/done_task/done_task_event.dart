///

import '../../../base/base.dart';
import '../../../core/core.dart';

class DoneTaskEvent extends BaseEvent {
  Task task;

  DoneTaskEvent(Task task) : this.task = task;
}

class DoneTaskDeleteEvent extends BaseEvent {
  Task task;

  DoneTaskDeleteEvent(Task task) : this.task = task;
}

class DoneTaskSuccessEvent extends BaseEvent {
  DoneTaskSuccessEvent();
}

class DoneTaskFailureEvent extends BaseEvent {
  APPError error;

  DoneTaskFailureEvent(this.error);
}
