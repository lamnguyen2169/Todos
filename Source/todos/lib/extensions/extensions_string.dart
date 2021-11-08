/// https://stackoverflow.com/questions/53547997/sort-a-list-of-objects-in-flutter-dart-by-property-value
/// https://stackoverflow.com/questions/64663441/is-there-a-way-to-calculate-text-width-before-it-render

import 'package:flutter/material.dart';

extension StringExtensions on String {
  /// MARK: - Getter/Setter
  String? get first {
    if (this.length > 0) {
      return this[0];
    }

    return null;
  }

  String? get last {
    if (this.length > 0) {
      return this[this.length - 1];
    }

    return null;
  }

  /// MARK: - Public methods
  String? letter(int index) {
    assert(index >= 0);

    if ((index >= 0) && (index < this.length)) {
      return this[index];
    }

    return null;
  }

  bool operator >(String other) {
    if (this.compareTo(other) > 0) {
      return true;
    }

    return false;
  }

  bool operator <(String other) {
    if (this.compareTo(other) < 0) {
      return true;
    }

    return false;
  }

  Size sizeWithStyle(
    TextStyle style, [
    double minWidth = 0,
    double maxWidth = double.infinity,
  ]) {
    final double textScaleFactor = WidgetsBinding.instance?.window.textScaleFactor ?? 1;
    final TextPainter timePainter = TextPainter()
      ..text = TextSpan(text: this, style: style)
      ..textDirection = TextDirection.ltr
      ..textScaleFactor = textScaleFactor
      ..layout(minWidth: minWidth, maxWidth: maxWidth);

    return timePainter.size;
  }
}
