///

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../base/base.dart';
import '../../utilities/utilities.dart';

abstract class LifecycleState<T extends StatefulWidget> extends State<T> with WidgetsBindingObserver {
  /// MARK: - override methods
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addObserver(this);
    WidgetsBinding.instance!.addPostFrameCallback((_) => componentDidLayout());
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      componentDidResume();
    } else if (state == AppLifecycleState.inactive) {
      componentDidInactive();
    } else if (state == AppLifecycleState.paused) {
      componentDidPause();
    } else if (state == AppLifecycleState.detached) {
      componentDidDetache();
    }
  }

  ///
  @mustCallSuper
  void componentDidLayout() {
    _setSystemUIOverlayStyle();
  }

  @mustCallSuper
  void componentDidResume() {
    _setSystemUIOverlayStyle();
  }

  @mustCallSuper
  void componentDidInactive() {}

  @mustCallSuper
  void componentDidPause() {}

  @mustCallSuper
  void componentDidDetache() {}

  /// MARK: - Local methods
  void _setSystemUIOverlayStyle() {
    if (this.mounted) {
      final ModalRoute? route = ModalRoute.of(this.context);

      if ((this.widget is BaseScreen) && (route is ModalRoute) && route.isActive && route.isCurrent) {
        final BaseScreen screen = this.widget as BaseScreen;

        if (!screen.isNavigationChild ||
            (screen.isNavigationChild && (screen.selectedNavigationRoute == screen.runtimeType.toString()))) {
          Block.performSelector(() async {
            SystemChrome.setSystemUIOverlayStyle(
              screen.systemOverlayStyle,
            );
          }, afterDelay: Duration(milliseconds: 100));
        }
      }
    }
  }
}
