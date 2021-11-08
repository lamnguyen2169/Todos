/// https://stackoverflow.com/questions/51535621/using-navigator-popuntil-and-route-without-fixed-name
/// https://flutter.dev/docs/cookbook/navigation/named-routes
/// https://flutter.dev/docs/cookbook/navigation/navigate-with-arguments
/// https://stackoverflow.com/a/55946547/7510477
/// https://medium.com/flutter-community/navigate-without-a-buildcontext-in-flutter-code-guide-2d344ee0e4d6
/// https://stackoverflow.com/questions/46483949/how-to-get-current-route-path-in-flutter
/// Push the given route onto the navigator that most tightly encloses the given context,
/// and then remove all the previous routes until the predicate returns true.
/// To remove all the routes below the pushed route, use a [RoutePredicate] that always returns false
/// (e.g. (Route<dynamic> route) => false).
/// Navigator.pushAndRemoveUntil(
///   context,
///   MaterialPageRoute(builder: (context) => MainPage()),
///   (Route<dynamic> route) => false,
/// );

import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'base/base.dart';
import 'utilities/utilities.dart';

enum RouterType { none, pushAndRemoveUntil, popUntil }

class RouterController extends BaseController {
  /// MARK: - Local properties
  final BehaviorSubject<BaseEvent> _routerSubject = BehaviorSubject<BaseEvent>();

  List<String> _routeStack = <String>[];

  /// MARK: - Public properties
  late final BaseEvent initialEvent;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  ValueStream<BaseEvent> get routerStream => _routerSubject.stream;

  RxSink<BaseEvent> get routerSink => RxSink(_routerSubject);

  static BuildContext? get currentContext => RouterController.instance.navigatorKey.currentContext;

  static List<String> get routeStack => RouterController.instance._routeStack;

  // Singleton
  RouterController._();

  static final RouterController instance = RouterController._();

  /// MARK: - Constructors
  RouterController([BaseController? parent]) : super(parent) {
    // setup initialize
  }

  /// MARK: - override methods
  @override
  void dispatchEvent(BaseEvent event) {
    // TODO: implement dispatchEvent
    super.dispatchEvent(event);
  }

  @override
  void dispose() {
    super.dispose();

    _routerSubject.close();
  }

  /// MARK: - Local methods

  /// MARK: - Public methods
  static bool containsRoute(String? route) {
    final RouterController controller = RouterController.instance;

    return controller._routeStack.contains(route);
  }

  static void resetRouteStacks() {
    final RouterController controller = RouterController.instance;

    controller._routeStack = <String>[];
  }

  static bool addRoute(String? route) {
    final RouterController controller = RouterController.instance;

    if ((route is String) && !RouterController.containsRoute(route)) {
      controller._routeStack.add(route);

      return true;
    }

    return false;
  }

  static bool removeRoute(String? route) {
    final RouterController controller = RouterController.instance;

    if (RouterController.containsRoute(route)) {
      controller._routeStack.remove(route);

      return true;
    }

    return false;
  }

  static Future<void> navigate(BaseEvent event) async {
    Block.performSelector(() async {
      RouterController.instance.addEvent(event);
    });
  }

  static Future<T?> push<T extends Object?>({
    required String routeName,
    required BuildContext context,
    WidgetBuilder? builder,
    RoutePageBuilder? pageBuilder,
    Duration transitionDuration = const Duration(milliseconds: 350),
    Duration reverseTransitionDuration = const Duration(milliseconds: 350),
    SystemUiOverlayStyle systemOverlayStyle = SystemUiOverlayStyle.dark,
    bool fullscreenDialog = false,
  }) async {
    final Completer<T?> completer = Completer<T?>();
    T? result;

    if (!RouterController.containsRoute(routeName)) {
      RouterController.addRoute(routeName);

      Block.performSelector(() async {
        result = await Navigator.push(
          context,
          (builder != null)
              ? CupertinoPageRoute(
                  settings: RouteSettings(name: routeName),
                  fullscreenDialog: fullscreenDialog,
                  builder: builder,
                )
              : PageRouteBuilder(
                  settings: RouteSettings(name: routeName),
                  fullscreenDialog: fullscreenDialog,
                  transitionDuration: transitionDuration,
                  reverseTransitionDuration: reverseTransitionDuration,
                  pageBuilder: pageBuilder!,
                ),
        );

        RouterController.removeRoute(routeName);

        Block.performSelector(() async {
          SystemChrome.setSystemUIOverlayStyle(
            systemOverlayStyle,
          );
        }, afterDelay: const Duration(milliseconds: 100));

        completer.complete(result);
      });
    }

    return completer.future;
  }

  static Future<T?> pushAndRemoveUntil<T extends Object?>({
    required String routeName,
    required BuildContext context,
    WidgetBuilder? builder,
    RoutePageBuilder? pageBuilder,
    Duration transitionDuration = const Duration(milliseconds: 350),
    Duration reverseTransitionDuration = const Duration(milliseconds: 350),
    bool fullscreenDialog = false,
  }) async {
    final Completer<T?> completer = Completer<T?>();
    T? result;

    if (!RouterController.containsRoute(routeName)) {
      RouterController.resetRouteStacks();
      RouterController.addRoute(routeName);

      Block.performSelector(() async {
        result = await Navigator.pushAndRemoveUntil(
          context,
          (builder != null)
              ? CupertinoPageRoute(
                  settings: RouteSettings(name: routeName),
                  fullscreenDialog: fullscreenDialog,
                  builder: builder,
                )
              : PageRouteBuilder(
                  settings: RouteSettings(name: routeName),
                  fullscreenDialog: fullscreenDialog,
                  transitionDuration: transitionDuration,
                  reverseTransitionDuration: reverseTransitionDuration,
                  pageBuilder: pageBuilder!,
                ),
          // To remove all the routes below the pushed route, use a RoutePredicate that always returns false
          (Route<dynamic> route) => false,
        );

        completer.complete(result);
      });
    }

    return completer.future;
  }

  static Future<void> pop<T extends Object?>(String routeName, BuildContext context, [T? result]) async {
    Block.performSelector(() async {
      RouterController.removeRoute(routeName);
      Navigator.pop(context, result);
    });
  }

  static Future<void> popUntil(BuildContext context, String screen) async {
    Block.performSelector(() async {
      Navigator.popUntil(context, (route) {
        String? routeName = route.settings.name;

        if (screen != routeName) {
          RouterController.removeRoute(routeName);
        }

        return (screen == routeName);
      });
    });
  }

  static Future<void> popToRoot(BuildContext context) async {
    Block.performSelector(() async {
      Navigator.popUntil(context, (route) {
        bool isFirst = route.isFirst;
        String? routeName = route.settings.name;

        if (!isFirst) {
          RouterController.removeRoute(routeName);
        }

        return isFirst;
      });
    });
  }
}
