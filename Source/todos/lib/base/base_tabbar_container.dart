/// https://stackoverflow.com/questions/53080186/make-appbar-transparent-and-show-background-image-which-is-set-to-whole-screen
/// https://github.com/flutter/flutter/issues/14203

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class BaseTabBarContainer extends StatelessWidget {
  /// Called to veto attempts by the user to dismiss the enclosing [ModalRoute].
  ///
  /// If the callback returns a Future that resolves to false, the enclosing
  /// route will not be popped.
  /// TODO: WillPopScope doesn't override swipe gesture if onWillPop callback is null: [onWillPop: condition ? () async => false : null]
  /// https://github.com/flutter/flutter/issues/14203
  final WillPopCallback? onWillPop;

  final bool showsAppBar;

  /// Whether to avoid system intrusions at the top of the screen, typically the
  /// system status bar.
  final bool top;

  /// Whether to avoid system intrusions on the left.
  final bool left;

  /// Whether to avoid system intrusions on the bottom side of the screen.
  final bool bottom;

  /// Whether to avoid system intrusions on the right.
  final bool right;

  final Widget? leadingWidget;
  final double? leadingWidth;
  final Widget? title;
  final double? titleSpacing;
  final bool centerTitle;
  final List<Widget>? trailingWidgets;

  final SystemUiOverlayStyle systemOverlayStyle;

  /// navigationBarColor: The fill color to use for an app bar's. If null, then the clear color [Colors.transparent] is used.
  final Color? navigationBarColor;

  final double? elevation;

  final Color? backgroundColor;

  /// The total number of tabs.
  ///
  /// Typically greater than one. Must match [TabBar.tabs]'s and
  /// [TabBarView.children]'s length.
  final int tabsNumber;

  final PreferredSizeWidget? tabBars;

  final Drawer? drawer;

  /// Determines if the [Scaffold.drawer] can be opened with a drag
  /// gesture.
  ///
  /// By default, the drag gesture is enabled.
  final bool drawerEnableOpenDragGesture;

  /// Optional callback that is called when the [Scaffold.drawer] is opened or closed.
  final DrawerCallback? onDrawerChanged;

  final Drawer? endDrawer;

  /// Determines if the [Scaffold.endDrawer] can be opened with a
  /// drag gesture.
  ///
  /// By default, the drag gesture is enabled.
  final bool endDrawerEnableOpenDragGesture;

  /// Optional callback that is called when the [Scaffold.endDrawer] is opened or closed.
  final DrawerCallback? onEndDrawerChanged;

  /// The color to use for the scrim that obscures primary content while a drawer is open.
  ///
  /// By default, the color is [Colors.black54]
  final Color? drawerScrimColor;

  /// If true the [body] and the scaffold's floating widgets should size
  /// themselves to avoid the onscreen keyboard whose height is defined by the
  /// ambient [MediaQuery]'s [MediaQueryData.viewInsets] `bottom` property.
  ///
  /// For example, if there is an onscreen keyboard displayed above the
  /// scaffold, the body can be resized to avoid overlapping the keyboard, which
  /// prevents widgets inside the body from being obscured by the keyboard.
  ///
  /// Defaults to true.
  final bool resizeToAvoidBottomInset;

  final List<SingleChildWidget> dependencies;
  final List<SingleChildWidget> independences;
  final List<Widget> children;
  final Widget? loading;

  /// MARK: - Constructors
  const BaseTabBarContainer({
    Key? key,
    this.onWillPop,
    this.showsAppBar = true,
    this.top = true,
    this.left = true,
    this.bottom = true,
    this.right = true,
    this.leadingWidget,
    this.leadingWidth = 48,
    this.title,
    this.titleSpacing = 8,
    this.centerTitle = true,
    this.trailingWidgets,
    required this.systemOverlayStyle,
    this.navigationBarColor,
    this.elevation = 0,
    this.backgroundColor,
    this.tabsNumber = 2,
    this.tabBars,
    this.drawer,
    this.drawerEnableOpenDragGesture = false,
    this.onDrawerChanged,
    this.endDrawer,
    this.endDrawerEnableOpenDragGesture = false,
    this.onEndDrawerChanged,
    this.drawerScrimColor,
    this.resizeToAvoidBottomInset = false,
    required this.dependencies,
    required this.independences,
    required this.children,
    this.loading,
  }) : super(key: key);

  /// MARK: - Local methods
  void _endEditing(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  /// MARK: - Layout methods
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: this.onWillPop,
      child: GestureDetector(
        onTap: () => _endEditing(context),
        child: DefaultTabController(
          length: this.tabsNumber,
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: this.showsAppBar
                ? AppBar(
                    leading: this.leadingWidget,
                    leadingWidth: this.leadingWidth,
                    // This will hide Drawer hamburger icon
                    automaticallyImplyLeading: false,
                    title: this.title,
                    titleSpacing: this.titleSpacing,
                    centerTitle: this.centerTitle,
                    actions: this.trailingWidgets,
                    systemOverlayStyle: this.systemOverlayStyle,
                    backgroundColor: this.navigationBarColor ?? Colors.transparent,
                    elevation: this.elevation,
                    bottom: this.tabBars,
                  )
                : null,
            backgroundColor: this.backgroundColor ?? Colors.white,
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    left: 0,
                    bottom: 0,
                    right: 0,
                    child: SafeArea(
                      top: this.top,
                      left: this.left,
                      bottom: this.bottom,
                      right: this.right,
                      child: MultiProvider(
                        providers: [
                          ...this.dependencies,
                          ...this.independences,
                        ],
                        child: TabBarView(
                          children: this.children,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    bottom: 0,
                    right: 0,
                    child: this.loading ?? Container(),
                  ),
                ],
              ),
            ),
            drawer: this.drawer,
            onDrawerChanged: this.onDrawerChanged,
            drawerEnableOpenDragGesture: this.drawerEnableOpenDragGesture,
            endDrawer: this.endDrawer,
            endDrawerEnableOpenDragGesture: this.endDrawerEnableOpenDragGesture,
            onEndDrawerChanged: this.onEndDrawerChanged,
            drawerScrimColor: this.drawerScrimColor,
            resizeToAvoidBottomInset: this.resizeToAvoidBottomInset,
          ),
        ),
      ),
    );
  }
}
