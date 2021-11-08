///

abstract class BaseEvent {
  String get description => this.runtimeType.toString();
}

class AnimatedEvent extends BaseEvent {
  dynamic data;

  AnimatedEvent([dynamic data]) : this.data = data;
}

class DrawerEvent extends BaseEvent {
  dynamic data;

  DrawerEvent([dynamic data]) : this.data = data;
}

class ReloadEvent extends BaseEvent {
  dynamic data;

  ReloadEvent([dynamic data]) : this.data = data;
}
