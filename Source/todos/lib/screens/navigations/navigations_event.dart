///

import '../../base/base.dart';

class SelectionEvent extends BaseEvent {
  int index;

  SelectionEvent(int index) : this.index = index;
}
