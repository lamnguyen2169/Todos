///

import '../../../base/base.dart';
import '../../../core/core.dart';

class TaskCardEvent extends BaseEvent {
  Task task;

  TaskCardEvent(Task task) : this.task = task;
}
