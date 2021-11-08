/// https://tobiasahlin.com/spinkit/
/// https://github.com/raymondjavaxx/SpinKit-ObjC/blob/master/SpinKit/Animations/RTSpinKitWaveAnimation.m
/// https://flutter.dev/docs/development/ui/animations/staggered-animations

import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../base/base.dart';
import '../dialogs/dialogs.dart';
import '../colors.dart';

import 'component_lifecycle.dart';

/// The usage of this loading widget MUST BE CONFORM TO the generic type T (extends BaseController).
/// For example:
///       LoadingWidget<DefinedController>(
///         animationWidget: ...,
///       ),
/// Otherwise, it will throw an exception by the [assert(T != dynamic)] when compiles.
class LoadingWidget<T extends BaseController> extends StatefulWidget {
  final Widget? animationWidget;

  LoadingWidget({
    Key? key,
    this.animationWidget,
  })  : assert(T != dynamic),
        super(key: key);

  @override
  _LoadingWidgetState createState() => _LoadingWidgetState<T>();
}

class _LoadingWidgetState<T> extends LifecycleState<LoadingWidget> {
  Dialogs? _dialogs;

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

    if (this.mounted) {
      /// These codes are ONLY EXECUTED ONCE when the widget is loaded (did mount).
      final BaseController controller = Provider.of<T>(this.context, listen: false) as BaseController;

      controller.loadingStream.listen((isLoading) async {
        _handleLoadingListened(isLoading);
      });
    }
  }

  /// MARK: - Local methods
  void _handleLoadingListened(bool isLoading) async {
    if (isLoading) {
      if (_dialogs == null) {
        _dialogs = await Dialogs.showDelayed(
          context: this.context,
          barrierDismissible: false,
          barrierColor: AppColors.barrier,
          child: (this.widget.animationWidget != null)
              ? this.widget.animationWidget!
              : Center(
                  child: SpinKitWave(
                    color: Colors.white,
                  ),
                ),
        );
      }
    } else {
      if (_dialogs != null) {
        _dialogs = null;
        Navigator.pop(this.context);
      }
    }
  }

  /// MARK: - Layout methods
  @override
  Widget build(BuildContext context) {
    return StreamProvider<bool>.value(
      value: (Provider.of<T>(context) as BaseController).loadingStream,
      initialData: false,
      updateShouldNotify: (previous, current) => false,
      child: Consumer<bool>(
        builder: (context, isLoading, child) {
          return Container();
        },
      ),
    );
  }
}

class DelayTween extends Tween<double> {
  final double delay;

  DelayTween({
    double? begin,
    double? end,
    required this.delay,
  }) : super(begin: begin, end: end);

  @override
  double lerp(double t) => super.lerp((sin((t - delay) * 2 * pi) + 1) / 2);

  @override
  double evaluate(Animation<double> animation) => lerp(animation.value);
}

class SpinKitWave extends StatefulWidget {
  final Color? color;
  final double itemWidth;
  final double height;
  final double spacing;
  final IndexedWidgetBuilder? itemBuilder;
  final Duration duration;
  final AnimationController? controller;

  const SpinKitWave({
    Key? key,
    this.color,
    this.height = 30.0,
    this.itemBuilder,
    this.itemWidth = 6,
    this.spacing = 5,
    this.duration = const Duration(milliseconds: 1200),
    this.controller,
  })  : assert(!(itemBuilder is IndexedWidgetBuilder && color is Color) && !(itemBuilder == null && color == null),
            'You should specify either a itemBuilder or a color'),
        super(key: key);

  @override
  _SpinKitWaveState createState() => _SpinKitWaveState();
}

class _SpinKitWaveState extends State<SpinKitWave> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  /// MARK: - override methods
  @override
  void initState() {
    super.initState();

    _controller = (widget.controller ??
        AnimationController(
          vsync: this,
          duration: widget.duration,
        ))
      ..repeat();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }

    super.dispose();
  }

  /// MARK: - Local methods
  Widget _itemBuilder(int index) => (widget.itemBuilder != null)
      ? widget.itemBuilder!(context, index)
      : DecoratedBox(decoration: BoxDecoration(color: widget.color));

  /// MARK: - Layout methods
  @override
  Widget build(BuildContext context) {
    final int itemCount = 5;
    final double width = itemCount * widget.itemWidth + (itemCount - 1) * widget.spacing;

    return Center(
      child: SizedBox.fromSize(
        size: Size(width, widget.height),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(itemCount, (index) {
            final double beginTime = 0.1 * index;
            final double endTime = 0.4 + beginTime;

            // Zoom range: [1.0, 2.0]
            // -1.2, -1.1, -1.0, -0.9, -0.8
            return ScaleYWidget(
              scaleY: DelayTween(begin: 1.0, end: 2.0, delay: -0.8).animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: Interval(beginTime, endTime, curve: Curves.linear),
                ),
              ),
              child: SizedBox.fromSize(size: Size(widget.itemWidth, widget.height), child: _itemBuilder(index)),
            );
          }),
        ),
      ),
    );
  }
}

class ScaleYWidget extends AnimatedWidget {
  const ScaleYWidget({
    Key? key,
    required Animation<double> scaleY,
    required this.child,
    this.alignment = Alignment.center,
  }) : super(key: key, listenable: scaleY);

  final Widget child;
  final Alignment alignment;

  Animation<double> get scale => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()..scale(1.0, scale.value, 1.0),
      alignment: alignment,
      child: child,
    );
  }
}
