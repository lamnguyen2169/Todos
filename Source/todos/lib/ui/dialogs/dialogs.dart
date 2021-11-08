/// https://stackoverflow.com/questions/57549859/is-it-possible-to-change-the-default-animation-of-showgeneralDialogs-in-flutter
/// https://flutter.dev/docs/development/ui/animations/tutorial
/// https://stackoverflow.com/questions/50683524/how-to-dismiss-flutter-dialog
///
/// import 'package:flutter/material.dart';
///
/// Future<T> showNewDialogs<T>({
///   @required BuildContext context,
///   bool barrierDismissible = true,
///   Widget child,
///   WidgetBuilder builder,
/// }) {
///   assert(child == null || builder == null);
///   assert(debugCheckHasMaterialLocalizations(context));
///
///   final ThemeData theme = Theme.of(context, shadowThemeOnly: true);
///   return showGeneralDialogs(
///     context: context,
///     pageBuilder: (BuildContext buildContext, Animation<double> animation,
///         Animation<double> secondaryAnimation) {
///       final Widget pageChild = child ?? Builder(builder: builder);
///       return Builder(builder: (BuildContext context) {
///         return theme != null ? Theme(data: theme, child: pageChild) : pageChild;
///       });
///     },
///     barrierDismissible: barrierDismissible,
///     barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
///     barrierColor: Colors.black54,
///     transitionDuration: const Duration(milliseconds: 400),
///     transitionBuilder: _buildNewTransition,
///   );
/// }
///
/// Widget _buildNewTransition(
///   BuildContext context,
///   Animation<double> animation,
///   Animation<double> secondaryAnimation,
///   Widget child,
/// ) {
///   return ScaleTransition(
///     scale: CurvedAnimation(
///       parent: animation,
///       curve: Curves.bounceIn,
///       reverseCurve: Curves.bounceIn,
///     ),
///     child: child,
///   );
/// }
///
///
/// --------------------------------------------------------------------------------
/// SAMPLE CODE
/// --------------------------------------------------------------------------------
/// Dialogs.show(
///   context: context,
///   type: DialogsType.slideFromBottom,
///   barrierDismissible: false,
///   // barrierColor: Colors.transparent,
///   child: Align(
///     alignment: Alignment.bottomCenter,
///     child: Container(
///       height: 400,
///       child: SizedBox.expand(
///         child: Column(
///           children: <Widget>[
///             Expanded(
///               child: FlutterLogo(),
///             ),
///             Button(
///               icon: Icons.close,
///               color: Colors.white,
///               width: 49,
///               height: 49,
///               iconSize: Size(49, 49),
///               onPressed: () {
///                 Navigator.pop(context, true);
///               },
///             ),
///             SizedBox(
///               height: 27,
///             ),
///           ],
///         ),
///       ),
///       margin: EdgeInsets.only(left: 0, right: 0),
///       decoration: BoxDecoration(
///         color: AppColors.main,
///         borderRadius: BorderRadius.only(
///             topLeft:Radius.circular(40) ,
///             topRight: Radius.circular(40)
///         ),
///       ),
///     ),
///   ),
/// );

import 'dart:async';

import 'package:flutter/material.dart';

import '../../macros/macros.dart';
import '../../ui/ui.dart';
import '../../utilities/utilities.dart';
import '../../router_controller.dart';

enum DialogsType {
  none,
  scaleEaseInOut,
  slideFromBottom,
}

class Dialogs {
  final DialogsType type;
  final bool barrierDismissible;
  final Color barrierColor;
  final int duration;
  final Widget child;

  /// Constructors
  Dialogs(
    this.type,
    this.barrierDismissible,
    this.barrierColor,
    this.duration,
    this.child,
  );

  /// duration: int milliseconds
  factory Dialogs.show({
    required BuildContext context,
    DialogsType type = DialogsType.none,
    bool barrierDismissible = false,
    Color barrierColor = Colors.transparent,
    int duration = 300,
    required Widget child,
  }) {
    final Dialogs instance = Dialogs(type, barrierDismissible, barrierColor, duration, child);

    showGeneralDialog(
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierDismissible: instance.barrierDismissible,
      barrierColor: instance.barrierColor,
      transitionDuration: Duration(milliseconds: instance.duration),
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Scaffold(
          backgroundColor: AppColors.clear,
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SafeArea(
              top: false,
              left: false,
              bottom: false,
              right: false,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    left: 0,
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: (instance.barrierDismissible)
                          ? () {
                              Dialogs.pop(context);
                            }
                          : null,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    bottom: 0,
                    right: 0,
                    child: SafeArea(
                      top: false,
                      left: false,
                      bottom: false,
                      right: false,
                      child: Center(
                        child: instance.child,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (instance.type != DialogsType.none)
          ? (context, animation, secondaryAnimation, child) {
              switch (instance.type) {
                case DialogsType.scaleEaseInOut:
                  return ScaleTransition(
                    scale: CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeInOutExpo,
                      reverseCurve: Curves.easeInOutExpo,
                    ),
                    child: child,
                  );
                default:
                  return SlideTransition(
                    position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(animation),
                    child: child,
                  );
              }
            }
          : null,
    );

    return instance;
  }

  /// MARK: - Public methods
  static Future<Dialogs> showDelayed({
    Duration duration = Duration.zero,
    required BuildContext context,
    DialogsType type = DialogsType.none,
    bool barrierDismissible = false,
    Color barrierColor = Colors.transparent,
    int transitionDuration = 300,
    required Widget child,
  }) {
    final Completer<Dialogs> completer = Completer<Dialogs>();

    Block.performSelector(() async {
      final Dialogs instance = Dialogs.show(
        context: context,
        type: type,
        barrierDismissible: barrierDismissible,
        barrierColor: barrierColor,
        duration: transitionDuration,
        child: child,
      );

      completer.complete(instance);
    }, afterDelay: duration);

    return completer.future;
  }

  static Future<Dialogs> showDelayedWidget(
    BuildContext context,
    Widget content, [
    bool barrierDismissible = false,
    Duration duration = Duration.zero,
  ]) {
    return Dialogs.showDelayed(
      duration: duration,
      context: context,
      type: DialogsType.scaleEaseInOut,
      barrierDismissible: barrierDismissible,
      barrierColor: AppColors.barrier,
      child: content,
    );
  }

  static Future<void> pop(BuildContext context) {
    return RouterController.pop(Constants.dialogs, context);
  }

  static Widget messageWidget(BuildContext context, String message) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(Constants.margin),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.warning_amber_rounded,
                          size: 60,
                          color: AppColors.error,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          '$message',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.text,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Button(
              icon: Icons.close,
              color: Colors.white,
              backgroundColor: AppColors.white,
              borderRadius: 10,
              width: 32,
              height: 32,
              iconSize: Size(32, 32),
              onPressed: () {
                Dialogs.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
