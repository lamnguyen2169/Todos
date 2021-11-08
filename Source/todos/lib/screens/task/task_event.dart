///

import '../../../base/base.dart';
import '../../../core/core.dart';

class TaskEvent extends BaseEvent {
  Task task;

  TaskEvent(Task task) : this.task = task;
}

class TaskDeleteEvent extends BaseEvent {
  Task task;

  TaskDeleteEvent(Task task) : this.task = task;
}

class TaskSuccessEvent extends BaseEvent {
  TaskSuccessEvent();
}

class TaskFailureEvent extends BaseEvent {
  APPError error;

  TaskFailureEvent(this.error);
}
