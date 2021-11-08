///

import '../../../base/base.dart';
import '../../../core/core.dart';

class CreateTaskEvent extends BaseEvent {
  String title;
  DateTime? endTime;

  CreateTaskEvent(String title, [DateTime? endTime])
      : this.title = title,
        this.endTime = endTime;
}

class CreateTaskSuccessEvent extends BaseEvent {
  CreateTaskSuccessEvent();
}

class CreateTaskFailureEvent extends BaseEvent {
  APPError error;

  CreateTaskFailureEvent(this.error);
}
