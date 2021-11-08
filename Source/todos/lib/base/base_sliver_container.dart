/// https://stackoverflow.com/questions/53080186/make-appbar-transparent-and-show-background-image-which-is-set-to-whole-screen
/// https://flutter.dev/docs/cookbook/lists/floating-app-bar
/// https://github.com/flutter/flutter/issues/14203

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class BaseSliverContainer extends StatelessWidget {
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

  /// Whether the app bar should become visible as soon as the user scrolls
  /// towards the app bar.
  ///
  /// Otherwise, the user will need to scroll near the top of the scroll view to
  /// reveal the app bar.
  final bool floating;

  /// Whether the app bar should remain visible at the start of the scroll view.
  ///
  /// The app bar can still expand and contract as the user scrolls, but it will
  /// remain visible rather than being scrolled out of view.
  final bool pinned;

  /// If [snap] and [floating] are true then the floating app bar will "snap"
  /// into view.
  final bool snap;

  /// Whether the app bar should stretch to fill the over-scroll area.
  ///
  /// The app bar can still expand and contract as the user scrolls, but it will
  /// also stretch when the user over-scrolls.
  final bool stretch;

  final Widget? leadingWidget;
  final double? leadingWidth;
  final Widget? title;
  final double? titleSpacing;
  final bool centerTitle;
  final List<Widget>? trailingWidgets;

  final SystemUiOverlayStyle systemOverlayStyle;

  /// navigationBarColor: The fill color to use for an app bar's. If null, then the clear color [Colors.transparent] is used.
  final Color? navigationBarColor;

  /// {@macro flutter.material.appbar.flexibleSpace}
  ///
  /// This property is used to configure an [AppBar].
  final Widget? flexibleSpace;

  final double? elevation;

  final Color? backgroundColor;

  /// Defines the height of the app bar when it is collapsed.
  ///
  /// By default, the collapsed height is [toolbarHeight]. If [bottom] widget is
  /// specified, then its height from [PreferredSizeWidget.preferredSize] is
  /// added to the height. If [primary] is true, then the [MediaQuery] top
  /// padding, [EdgeInsets.top] of [MediaQueryData.padding], is added as well.
  ///
  /// If [pinned] and [floating] are true, with [bottom] set, the default
  /// collapsed height is only the height of [PreferredSizeWidget.preferredSize]
  /// with the [MediaQuery] top padding.
  final double? collapsedHeight;

  /// The size of the app bar when it is fully expanded.
  ///
  /// By default, the total height of the toolbar and the bottom widget (if
  /// any). If a [flexibleSpace] widget is specified this height should be big
  /// enough to accommodate whatever that widget contains.
  ///
  /// This does not include the status bar height (which will be automatically
  /// included if [primary] is true).
  final double? expandedHeight;

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
  final Widget child;
  final Widget? loading;

  /// MARK: - Constructors
  const BaseSliverContainer({
    Key? key,
    this.onWillPop,
    this.showsAppBar = true,
    this.top = false,
    this.left = false,
    this.bottom = false,
    this.right = false,
    this.floating = false,
    this.pinned = false,
    this.snap = false,
    this.stretch = false,
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
    this.flexibleSpace,
    this.collapsedHeight,
    this.expandedHeight,
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
    required this.child,
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
        child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: this.backgroundColor ?? Colors.white,
          // No appbar provided to the Scaffold, only a body with a
          // CustomScrollView.
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
                      child: CustomScrollView(
                        slivers: [
                          // Add the app bar to the CustomScrollView.
                          SliverAppBar(
                            leading: this.leadingWidget,
                            leadingWidth: this.leadingWidth,
                            // This will hide Drawer hamburger icon
                            automaticallyImplyLeading: false,
                            // Allows the user to reveal the app bar if they begin scrolling
                            // back up the list of items.
                            floating: this.floating,
                            pinned: this.pinned,
                            snap: this.snap,
                            stretch: this.stretch,
                            title: this.title,
                            titleSpacing: this.titleSpacing,
                            centerTitle: this.centerTitle,
                            actions: this.trailingWidgets,
                            systemOverlayStyle: this.systemOverlayStyle,
                            backgroundColor: this.navigationBarColor ?? Colors.transparent,
                            elevation: this.elevation,
                            // Display a placeholder widget to visualize the shrinking size.
                            flexibleSpace: this.flexibleSpace,
                            collapsedHeight: this.collapsedHeight,
                            // Make the initial height of the SliverAppBar larger than normal.
                            expandedHeight: this.expandedHeight,
                          ),
                          // // Next, create a SliverList
                          SliverList(
                            // Use a delegate to build items as they're scrolled on screen.
                            delegate: SliverChildBuilderDelegate(
                              // The builder function returns a ListTile with a title that
                              // displays the index of the current item.
                              (context, index) {
                                return this.child;
                              },
                              childCount: 1,
                            ),
                          ),
                        ],
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
    );
  }
}
