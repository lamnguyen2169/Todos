///

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../base/base_event.dart';
import '../../base/base_controller.dart';

import 'component_lifecycle.dart';

/// The usage of this listener widget MUST BE CONFORM TO the generic type T (extends BaseController).
/// For example:
///       EventListener<DefinedController>(
///         listener: ...,
///         child: ...,
///       ),
/// Otherwise, it will throw an exception by the [assert(T != dynamic)] when compiles.
class EventListener<T extends BaseController> extends StatefulWidget {
  final void Function(BaseEvent event) listener;
  final Widget child;

  EventListener({
    Key? key,
    required this.listener,
    required this.child,
  })  : assert(T != dynamic),
        super(key: key);

  @override
  _EventListenerState createState() => _EventListenerState<T>();
}

class _EventListenerState<T> extends LifecycleState<EventListener> {
  /// MARK: - override methods
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void componentDidLayout() {
    // TODO: implement componentDidLayout
    super.componentDidLayout();

    /// These codes are ONLY EXECUTED ONCE when the widget is loaded (did mount).
    final BaseController controller = Provider.of<T>(context, listen: false) as BaseController;

    controller.listenerStream.listen(
      (event) {
        /// The code stay inside the listen block will be executed
        /// whenever the listenerSink add new event (multiple times).
        widget.listener(event);
      },
    );
  }

  /// MARK: - Layout methods
  @override
  Widget build(BuildContext context) {
    return StreamProvider<BaseEvent?>.value(
      value: (Provider.of<T>(context) as BaseController).listenerStream,
      initialData: null,
      updateShouldNotify: (previous, current) => false,
      child: Consumer<BaseEvent?>(
        builder: (context, event, child) {
          return widget.child;
        },
      ),
    );
  }
}
