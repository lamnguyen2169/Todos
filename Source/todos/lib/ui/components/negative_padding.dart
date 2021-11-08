/// https://stackoverflow.com/a/64949857/7510477

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NegativePadding extends SingleChildRenderObjectWidget {
  /// The amount of space by which to inset the child.
  final EdgeInsetsGeometry padding;

  NegativePadding({
    Key? key,
    this.padding = EdgeInsets.zero,
    Widget? child,
  }) : super(key: key, child: child);

  @override
  RenderNegativePadding createRenderObject(BuildContext context) {
    return RenderNegativePadding(
      padding: padding,
      textDirection: Directionality.of(context),
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderNegativePadding renderObject) {
    renderObject
      ..padding = padding
      ..textDirection = Directionality.of(context);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    properties.add(DiagnosticsProperty<EdgeInsetsGeometry>('padding', padding));
  }
}

class RenderNegativePadding extends RenderShiftedBox {
  RenderNegativePadding({
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    TextDirection textDirection = TextDirection.ltr,
    RenderBox? child,
  })  : _textDirection = textDirection,
        _padding = padding,
        super(child);

  EdgeInsets get resolvedPadding => _resolvedPadding ?? EdgeInsets.zero;
  EdgeInsets? _resolvedPadding;

  void _resolve() {
    if (_resolvedPadding != null) return;

    _resolvedPadding = padding.resolve(textDirection);
  }

  void _markNeedResolution() {
    _resolvedPadding = null;
    markNeedsLayout();
  }

  /// The amount to pad the child in each dimension.
  ///
  /// If this is set to an [EdgeInsetsDirectional] object, then [textDirection]
  /// must not be null.
  EdgeInsetsGeometry get padding => _padding ?? EdgeInsets.zero;
  EdgeInsetsGeometry? _padding;

  set padding(EdgeInsetsGeometry value) {
    if (_padding == value) return;

    _padding = value;
    _markNeedResolution();
  }

  /// The text direction with which to resolve [padding].
  ///
  /// This may be changed to null, but only after the [padding] has been changed
  /// to a value that does not depend on the direction.
  TextDirection get textDirection => _textDirection ?? TextDirection.ltr;
  TextDirection? _textDirection;

  set textDirection(TextDirection value) {
    if (_textDirection == value) return;

    _textDirection = value;
    _markNeedResolution();
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    _resolve();
    final double totalHorizontalPadding = resolvedPadding.left + resolvedPadding.right;
    final double totalVerticalPadding = resolvedPadding.top + resolvedPadding.bottom;

    if (child != null) // next line relies on double.infinity absorption
      return child!.getMinIntrinsicWidth(max(0.0, height - totalVerticalPadding)) + totalHorizontalPadding;

    return totalHorizontalPadding;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    _resolve();
    final double totalHorizontalPadding = resolvedPadding.left + resolvedPadding.right;
    final double totalVerticalPadding = resolvedPadding.top + resolvedPadding.bottom;

    if (child != null) // next line relies on double.infinity absorption
      return child!.getMaxIntrinsicWidth(max(0.0, height - totalVerticalPadding)) + totalHorizontalPadding;

    return totalHorizontalPadding;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    _resolve();

    final double totalHorizontalPadding = resolvedPadding.left + resolvedPadding.right;
    final double totalVerticalPadding = resolvedPadding.top + resolvedPadding.bottom;

    if (child != null) // next line relies on double.infinity absorption
      return child!.getMinIntrinsicHeight(max(0.0, width - totalHorizontalPadding)) + totalVerticalPadding;

    return totalVerticalPadding;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    _resolve();

    final double totalHorizontalPadding = resolvedPadding.left + resolvedPadding.right;
    final double totalVerticalPadding = resolvedPadding.top + resolvedPadding.bottom;

    if (child != null) // next line relies on double.infinity absorption
      return child!.getMaxIntrinsicHeight(max(0.0, width - totalHorizontalPadding)) + totalVerticalPadding;

    return totalVerticalPadding;
  }

  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints;

    _resolve();

    assert(_resolvedPadding != null);

    if (child == null) {
      size = constraints.constrain(Size(
        resolvedPadding.left + resolvedPadding.right,
        resolvedPadding.top + resolvedPadding.bottom,
      ));

      return;
    }

    final BoxConstraints innerConstraints = constraints.deflate(resolvedPadding);

    child!.layout(innerConstraints, parentUsesSize: true);

    final BoxParentData childParentData = child!.parentData as BoxParentData;

    childParentData.offset = Offset(resolvedPadding.left, resolvedPadding.top);
    size = constraints.constrain(Size(
      resolvedPadding.left + child!.size.width + resolvedPadding.right,
      resolvedPadding.top + child!.size.height + resolvedPadding.bottom,
    ));
  }

  @override
  void debugPaintSize(PaintingContext context, Offset offset) {
    super.debugPaintSize(context, offset);

    assert(() {
      final Rect outerRect = offset & size;
      debugPaintPadding(context.canvas, outerRect, child != null ? resolvedPadding.deflateRect(outerRect) : null);
      return true;
    }());
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry>('padding', padding));
    properties.add(EnumProperty<TextDirection>('textDirection', textDirection, defaultValue: null));
  }
}
