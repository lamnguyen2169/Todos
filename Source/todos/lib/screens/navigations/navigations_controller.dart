///

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../base/base.dart';
import '../../screens/screens.dart';
import '../../utilities/utilities.dart';

import 'navigations_event.dart';

class NavigationsController extends BaseController {
  /// MARK: - Local properties
  final BehaviorSubject<int> _itemSubject = BehaviorSubject<int>();

  final Map<dynamic, BaseScreen> _screensMap = <dynamic, BaseScreen>{
    0: HomeScreen(),
    1: TaskScreen(),
    2: DoneTaskScreen(),
  };

  late List<Widget> _screens = <Widget>[
    ChangeNotifierProvider<HomeController>(
      create: (_) => HomeController(),
      child: _screensMap[0],
    ),
    ChangeNotifierProvider<TaskController>(
      create: (_) => TaskController(),
      child: _screensMap[1],
    ),
    ChangeNotifierProvider<DoneTaskController>(
      create: (_) => DoneTaskController(),
      child: _screensMap[2],
    ),
  ];

  /// MARK: - Public properties
  List<Widget> get screens => _screens;

  ValueStream<int> get itemStream => _itemSubject.stream;

  RxSink<int> get itemSink => RxSink(_itemSubject);

  /// MARK: - Constructors
  NavigationsController([BaseController? parent]) : super(parent) {
    /// Setup initialize
  }

  /// MARK: - override methods
  @override
  void dispatchEvent(BaseEvent event) {
    // TODO: implement dispatchEvent
    super.dispatchEvent(event);

    if (event is SelectionEvent) {
      _selectItemAtIndex(event.index);
    } else if (event is DrawerEvent) {
      this.listenerSink.add(event);
    }
  }

  @override
  void dispose() {
    super.dispose();

    _itemSubject.close();
  }

  /// MARK: - Local methods
  void _selectItemAtIndex(int index) {
    if ((index >= 0) && (index < _screens.length)) {
      Widget? widget = _screens[index];

      if (widget is Widget) {
        _screensMap.forEach((key, value) {
          value.selectedNavigationRoute = (key == index) ? value.runtimeType.toString() : null;
        });

        this.itemSink.add(index);
      }
    }
  }

  /// MARK: - Public methods
  int indexOfItem(Widget widget) {
    return _screens.indexOf(widget);
  }

  Widget itemAtIndex(int index) {
    if ((index >= 0) && (index < _screens.length)) {
      return _screens[index];
    }

    return _screens[0];
  }
}
