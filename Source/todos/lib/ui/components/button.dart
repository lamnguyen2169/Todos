/// https://stackoverflow.com/questions/52227846/how-can-i-add-shadow-to-the-widget-in-flutter

import 'package:flutter/material.dart';

enum ButtonIconPosition { left, right, above, below }

class Button extends StatelessWidget {
  /// public properties
  final String? title;
  final Object? icon;
  final double fontSize;
  final FontWeight? fontWeight;
  final Color color;
  final Color backgroundColor;
  final double borderRadius;
  final double borderWidth;
  final Color borderColor;
  final BorderStyle borderStyle;
  final List<BoxShadow>? shadow;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry contentInsets;
  final MainAxisAlignment contentAlignment;
  final double? width;
  final double? height;
  final ButtonIconPosition? iconPosition;
  final Size iconSize;
  final EdgeInsetsGeometry? iconMargin;

  /// Constructor
  Button(
      {Key? key,
      this.title,
      this.icon,
      this.fontSize = 8,
      this.fontWeight,
      this.color = Colors.white,
      this.backgroundColor = Colors.transparent,
      this.borderRadius = 8,
      this.borderWidth = 0,
      this.borderColor = Colors.transparent,
      this.borderStyle = BorderStyle.solid,
      this.shadow,
      required this.onPressed,
      this.onLongPress,
      this.margin,
      this.contentInsets = EdgeInsets.zero,
      this.contentAlignment = MainAxisAlignment.center,
      this.width,
      this.height,
      this.iconPosition = ButtonIconPosition.left,
      this.iconSize = Size.zero,
      this.iconMargin})
      : super(key: key);

  /// MARK: - Local methods
  Widget? iconWidget() {
    Widget? widget;

    if (this.icon is String) {
      if ((this.iconSize.width != 0) && (this.iconSize.height != 0)) {
        widget = Image.asset(
          this.icon! as String,
          width: this.iconSize.width,
          height: this.iconSize.height,
        );
      } else {
        widget = Image.asset(this.icon! as String);
      }
    } else if (this.icon is IconData) {
      if ((this.iconSize.width != 0) && (this.iconSize.height != 0)) {
        widget = Icon(
          this.icon as IconData,
          size: this.iconSize.width,
          color: this.color,
        );
      } else {
        widget = Icon(
          this.icon as IconData,
          color: this.color,
        );
      }
    }

    return widget;
  }

  /// MARK: - Layout methods
  @override
  Widget build(BuildContext context) {
    final Button button;

    if ((this.title != null) && (this.icon != null)) {
      switch (this.iconPosition) {
        case ButtonIconPosition.above:
          button = _AboveIconButton(
              title: this.title,
              icon: this.icon,
              fontSize: this.fontSize,
              fontWeight: this.fontWeight,
              color: this.color,
              backgroundColor: this.backgroundColor,
              borderRadius: this.borderRadius,
              borderWidth: this.borderWidth,
              borderColor: this.borderColor,
              borderStyle: this.borderStyle,
              shadow: this.shadow,
              onPressed: this.onPressed,
              onLongPress: this.onLongPress,
              margin: this.margin,
              contentInsets: this.contentInsets,
              contentAlignment: this.contentAlignment,
              width: this.width,
              height: this.height,
              iconSize: this.iconSize,
              iconMargin: this.iconMargin);
          break;
        case ButtonIconPosition.below:
          button = _BelowIconButton(
              title: this.title,
              icon: this.icon,
              fontSize: this.fontSize,
              fontWeight: this.fontWeight,
              color: this.color,
              backgroundColor: this.backgroundColor,
              borderRadius: this.borderRadius,
              borderWidth: this.borderWidth,
              borderColor: this.borderColor,
              borderStyle: this.borderStyle,
              shadow: this.shadow,
              onPressed: this.onPressed,
              onLongPress: this.onLongPress,
              margin: this.margin,
              contentInsets: this.contentInsets,
              contentAlignment: this.contentAlignment,
              width: this.width,
              height: this.height,
              iconSize: this.iconSize,
              iconMargin: this.iconMargin);
          break;
        case ButtonIconPosition.right:
          button = _RightIconButton(
              title: this.title,
              icon: this.icon,
              fontSize: this.fontSize,
              fontWeight: this.fontWeight,
              color: this.color,
              backgroundColor: this.backgroundColor,
              borderRadius: this.borderRadius,
              borderWidth: this.borderWidth,
              borderColor: this.borderColor,
              borderStyle: this.borderStyle,
              shadow: this.shadow,
              onPressed: this.onPressed,
              onLongPress: this.onLongPress,
              margin: this.margin,
              contentInsets: this.contentInsets,
              contentAlignment: this.contentAlignment,
              width: this.width,
              height: this.height,
              iconSize: this.iconSize,
              iconMargin: this.iconMargin);
          break;
        default:
          button = _LeftIconButton(
              title: this.title,
              icon: this.icon,
              fontSize: this.fontSize,
              fontWeight: this.fontWeight,
              color: this.color,
              backgroundColor: this.backgroundColor,
              borderRadius: this.borderRadius,
              borderWidth: this.borderWidth,
              borderColor: this.borderColor,
              borderStyle: this.borderStyle,
              shadow: this.shadow,
              onPressed: this.onPressed,
              onLongPress: this.onLongPress,
              margin: this.margin,
              contentInsets: this.contentInsets,
              contentAlignment: this.contentAlignment,
              width: this.width,
              height: this.height,
              iconSize: this.iconSize,
              iconMargin: this.iconMargin);
      }
    } else if (this.icon != null) {
      button = _IconButton(
          icon: this.icon,
          color: this.color,
          backgroundColor: this.backgroundColor,
          borderRadius: this.borderRadius,
          borderWidth: this.borderWidth,
          borderColor: this.borderColor,
          borderStyle: this.borderStyle,
          shadow: this.shadow,
          onPressed: this.onPressed,
          onLongPress: this.onLongPress,
          margin: this.margin,
          contentInsets: this.contentInsets,
          contentAlignment: this.contentAlignment,
          width: this.width,
          height: this.height,
          iconSize: this.iconSize);
    } else {
      button = _TitleButton(
          title: this.title,
          fontSize: this.fontSize,
          fontWeight: this.fontWeight,
          color: this.color,
          backgroundColor: this.backgroundColor,
          borderRadius: this.borderRadius,
          borderWidth: this.borderWidth,
          borderColor: this.borderColor,
          borderStyle: this.borderStyle,
          shadow: this.shadow,
          onPressed: this.onPressed,
          onLongPress: this.onLongPress,
          margin: this.margin,
          contentInsets: this.contentInsets,
          contentAlignment: this.contentAlignment,
          width: this.width,
          height: this.height);
    }

    return button;
  }
}

/// MARK: - This type of Button has title only.
class _TitleButton extends Button {
  /// Constructor
  _TitleButton(
      {Key? key,
      String? title,
      double fontSize = 8,
      FontWeight? fontWeight,
      Color color = Colors.white,
      Color backgroundColor = Colors.transparent,
      double borderRadius = 8,
      double borderWidth = 0,
      Color borderColor = Colors.transparent,
      BorderStyle borderStyle = BorderStyle.solid,
      List<BoxShadow>? shadow,
      required VoidCallback? onPressed,
      VoidCallback? onLongPress,
      EdgeInsetsGeometry? margin,
      EdgeInsetsGeometry contentInsets = EdgeInsets.zero,
      MainAxisAlignment contentAlignment = MainAxisAlignment.center,
      double? width,
      double? height})
      : super(
            title: title,
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color,
            backgroundColor: backgroundColor,
            borderRadius: borderRadius,
            borderWidth: borderWidth,
            borderColor: borderColor,
            borderStyle: borderStyle,
            shadow: shadow,
            onPressed: onPressed,
            onLongPress: onLongPress,
            margin: margin,
            contentInsets: contentInsets,
            contentAlignment: contentAlignment,
            width: width,
            height: height);

  /// MARK: - Layout methods
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onPressed,
      onLongPress: this.onLongPress,
      child: Container(
        width: this.width,
        height: this.height,
        margin: this.margin,
        padding: this.contentInsets,
        decoration: BoxDecoration(
          color: this.backgroundColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(this.borderRadius)),
          border: Border.all(width: this.borderWidth, color: this.borderColor, style: this.borderStyle),
          boxShadow: this.shadow,
        ),
        child: Row(
          mainAxisAlignment: this.contentAlignment,
          children: <Widget>[
            Text(
              '${this.title ?? ''}',
              style: TextStyle(
                fontSize: this.fontSize,
                fontWeight: this.fontWeight,
                color: this.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// MARK: - This type of Button has icon only.
class _IconButton extends Button {
  /// Constructor
  _IconButton(
      {Key? key,
      Object? icon,
      Color color = Colors.white,
      Color backgroundColor = Colors.transparent,
      double borderRadius = 8,
      double borderWidth = 0,
      Color borderColor = Colors.transparent,
      BorderStyle borderStyle = BorderStyle.solid,
      List<BoxShadow>? shadow,
      required VoidCallback? onPressed,
      VoidCallback? onLongPress,
      EdgeInsetsGeometry? margin,
      EdgeInsetsGeometry contentInsets = EdgeInsets.zero,
      MainAxisAlignment contentAlignment = MainAxisAlignment.center,
      double? width,
      double? height,
      Size iconSize = Size.zero})
      : super(
            icon: icon,
            color: color,
            backgroundColor: backgroundColor,
            borderRadius: borderRadius,
            borderWidth: borderWidth,
            borderColor: borderColor,
            borderStyle: borderStyle,
            shadow: shadow,
            onPressed: onPressed,
            onLongPress: onLongPress,
            margin: margin,
            contentInsets: contentInsets,
            contentAlignment: contentAlignment,
            width: width,
            height: height,
            iconSize: iconSize);

  /// MARK: - Layout methods
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onPressed,
      onLongPress: this.onLongPress,
      child: Container(
        width: this.width,
        height: this.height,
        margin: this.margin,
        padding: this.contentInsets,
        decoration: BoxDecoration(
          color: this.backgroundColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(this.borderRadius)),
          border: Border.all(width: this.borderWidth, color: this.borderColor, style: this.borderStyle),
          boxShadow: this.shadow,
        ),
        child: Row(
          mainAxisAlignment: this.contentAlignment,
          children: <Widget>[
            Container(
              width: (this.iconSize.width > 0) ? this.iconSize.width : null,
              height: (this.iconSize.height > 0) ? this.iconSize.height : null,
              margin: this.iconMargin,
              child: this.iconWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

/// MARK: - This type of Button has title, icon with icon stays on left side of the Button title.
class _LeftIconButton extends Button {
  /// Constructor
  _LeftIconButton(
      {Key? key,
      String? title,
      Object? icon,
      double fontSize = 8,
      FontWeight? fontWeight,
      Color color = Colors.white,
      Color backgroundColor = Colors.transparent,
      double borderRadius = 8,
      double borderWidth = 0,
      Color borderColor = Colors.transparent,
      BorderStyle borderStyle = BorderStyle.solid,
      List<BoxShadow>? shadow,
      required VoidCallback? onPressed,
      VoidCallback? onLongPress,
      EdgeInsetsGeometry? margin,
      EdgeInsetsGeometry contentInsets = EdgeInsets.zero,
      MainAxisAlignment contentAlignment = MainAxisAlignment.center,
      double? width,
      double? height,
      Size iconSize = Size.zero,
      EdgeInsetsGeometry? iconMargin})
      : super(
            title: title,
            icon: icon,
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color,
            backgroundColor: backgroundColor,
            borderRadius: borderRadius,
            borderWidth: borderWidth,
            borderColor: borderColor,
            borderStyle: borderStyle,
            shadow: shadow,
            onPressed: onPressed,
            onLongPress: onLongPress,
            margin: margin,
            contentInsets: contentInsets,
            contentAlignment: contentAlignment,
            width: width,
            height: height,
            iconSize: iconSize,
            iconMargin: iconMargin);

  /// MARK: - Layout methods
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onPressed,
      onLongPress: this.onLongPress,
      child: Container(
        width: this.width,
        height: this.height,
        margin: this.margin,
        padding: this.contentInsets,
        decoration: BoxDecoration(
          color: this.backgroundColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(this.borderRadius)),
          border: Border.all(width: this.borderWidth, color: this.borderColor, style: this.borderStyle),
          boxShadow: this.shadow,
        ),
        child: Row(
          mainAxisAlignment: this.contentAlignment,
          children: <Widget>[
            Container(
              width: (this.iconSize.width > 0) ? this.iconSize.width : null,
              height: (this.iconSize.height > 0) ? this.iconSize.height : null,
              margin: this.iconMargin ?? EdgeInsets.only(right: 8),
              child: this.iconWidget(),
            ),
            Text(
              '${this.title ?? ''}',
              style: TextStyle(
                fontSize: this.fontSize,
                fontWeight: this.fontWeight,
                color: this.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// MARK: - This type of Button has title, icon with icon stays on right side of the Button title.
class _RightIconButton extends Button {
  /// Constructor
  _RightIconButton(
      {Key? key,
      String? title,
      Object? icon,
      double fontSize = 8,
      FontWeight? fontWeight,
      Color color = Colors.white,
      Color backgroundColor = Colors.transparent,
      double borderRadius = 8,
      double borderWidth = 0,
      Color borderColor = Colors.transparent,
      BorderStyle borderStyle = BorderStyle.solid,
      List<BoxShadow>? shadow,
      required VoidCallback? onPressed,
      VoidCallback? onLongPress,
      EdgeInsetsGeometry? margin,
      EdgeInsetsGeometry contentInsets = EdgeInsets.zero,
      MainAxisAlignment contentAlignment = MainAxisAlignment.center,
      double? width,
      double? height,
      Size iconSize = Size.zero,
      EdgeInsetsGeometry? iconMargin})
      : super(
            title: title,
            icon: icon,
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color,
            backgroundColor: backgroundColor,
            borderRadius: borderRadius,
            borderWidth: borderWidth,
            borderColor: borderColor,
            borderStyle: borderStyle,
            shadow: shadow,
            onPressed: onPressed,
            onLongPress: onLongPress,
            margin: margin,
            contentInsets: contentInsets,
            contentAlignment: contentAlignment,
            width: width,
            height: height,
            iconSize: iconSize,
            iconMargin: iconMargin);

  /// MARK: - Layout methods
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onPressed,
      onLongPress: this.onLongPress,
      child: Container(
        width: this.width,
        height: this.height,
        margin: this.margin,
        padding: this.contentInsets,
        decoration: BoxDecoration(
          color: this.backgroundColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(this.borderRadius)),
          border: Border.all(width: this.borderWidth, color: this.borderColor, style: this.borderStyle),
          boxShadow: this.shadow,
        ),
        child: Row(
          mainAxisAlignment: this.contentAlignment,
          children: <Widget>[
            Text(
              '${this.title ?? ''}',
              style: TextStyle(
                fontSize: this.fontSize,
                fontWeight: this.fontWeight,
                color: this.color,
              ),
            ),
            Container(
              width: (this.iconSize.width > 0) ? this.iconSize.width : null,
              height: (this.iconSize.height > 0) ? this.iconSize.height : null,
              margin: this.iconMargin ?? EdgeInsets.only(left: 8),
              child: this.iconWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

/// MARK: - This type of Button has title, icon with icon stays above of the Button title.
class _AboveIconButton extends Button {
  /// Constructor
  _AboveIconButton(
      {Key? key,
      String? title,
      Object? icon,
      double fontSize = 8,
      FontWeight? fontWeight,
      Color color = Colors.white,
      Color backgroundColor = Colors.transparent,
      double borderRadius = 8,
      double borderWidth = 0,
      Color borderColor = Colors.transparent,
      BorderStyle borderStyle = BorderStyle.solid,
      List<BoxShadow>? shadow,
      required VoidCallback? onPressed,
      VoidCallback? onLongPress,
      EdgeInsetsGeometry? margin,
      EdgeInsetsGeometry contentInsets = EdgeInsets.zero,
      MainAxisAlignment contentAlignment = MainAxisAlignment.center,
      double? width,
      double? height,
      Size iconSize = Size.zero,
      EdgeInsetsGeometry? iconMargin})
      : super(
            title: title,
            icon: icon,
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color,
            backgroundColor: backgroundColor,
            borderRadius: borderRadius,
            borderWidth: borderWidth,
            borderColor: borderColor,
            borderStyle: borderStyle,
            shadow: shadow,
            onPressed: onPressed,
            onLongPress: onLongPress,
            margin: margin,
            contentInsets: contentInsets,
            contentAlignment: contentAlignment,
            width: width,
            height: height,
            iconSize: iconSize,
            iconMargin: iconMargin);

  /// MARK: - Layout methods
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onPressed,
      onLongPress: this.onLongPress,
      child: Container(
        width: this.width,
        height: this.height,
        margin: this.margin,
        padding: this.contentInsets,
        decoration: BoxDecoration(
          color: this.backgroundColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(this.borderRadius)),
          border: Border.all(width: this.borderWidth, color: this.borderColor, style: this.borderStyle),
          boxShadow: this.shadow,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: this.contentAlignment,
          children: <Widget>[
            Container(
              width: (this.iconSize.width > 0) ? this.iconSize.width : null,
              height: (this.iconSize.height > 0) ? this.iconSize.height : null,
              margin: this.iconMargin ?? EdgeInsets.only(bottom: 8),
              child: this.iconWidget(),
            ),
            Text(
              '${this.title ?? ''}',
              style: TextStyle(
                fontSize: this.fontSize,
                fontWeight: this.fontWeight,
                color: this.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// MARK: - This type of Button has title, icon with icon stays below of the Button title.
class _BelowIconButton extends Button {
  /// Constructor
  _BelowIconButton(
      {Key? key,
      String? title,
      Object? icon,
      double fontSize = 8,
      FontWeight? fontWeight,
      Color color = Colors.white,
      Color backgroundColor = Colors.transparent,
      double borderRadius = 8,
      double borderWidth = 0,
      Color borderColor = Colors.transparent,
      BorderStyle borderStyle = BorderStyle.solid,
      List<BoxShadow>? shadow,
      required VoidCallback? onPressed,
      VoidCallback? onLongPress,
      EdgeInsetsGeometry? margin,
      EdgeInsetsGeometry contentInsets = EdgeInsets.zero,
      MainAxisAlignment contentAlignment = MainAxisAlignment.center,
      double? width,
      double? height,
      Size iconSize = Size.zero,
      EdgeInsetsGeometry? iconMargin})
      : super(
            title: title,
            icon: icon,
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color,
            backgroundColor: backgroundColor,
            borderRadius: borderRadius,
            borderWidth: borderWidth,
            borderColor: borderColor,
            borderStyle: borderStyle,
            shadow: shadow,
            onPressed: onPressed,
            onLongPress: onLongPress,
            margin: margin,
            contentInsets: contentInsets,
            contentAlignment: contentAlignment,
            width: width,
            height: height,
            iconSize: iconSize,
            iconMargin: iconMargin);

  /// MARK: - Layout methods
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onPressed,
      onLongPress: this.onLongPress,
      child: Container(
        width: this.width,
        height: this.height,
        margin: this.margin,
        padding: this.contentInsets,
        decoration: BoxDecoration(
          color: this.backgroundColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(this.borderRadius)),
          border: Border.all(width: this.borderWidth, color: this.borderColor, style: this.borderStyle),
          boxShadow: this.shadow,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: this.contentAlignment,
          children: <Widget>[
            Text(
              '${this.title ?? ''}',
              style: TextStyle(
                fontSize: this.fontSize,
                fontWeight: this.fontWeight,
                color: this.color,
              ),
            ),
            Container(
              width: (this.iconSize.width > 0) ? this.iconSize.width : null,
              height: (this.iconSize.height > 0) ? this.iconSize.height : null,
              margin: this.iconMargin ?? EdgeInsets.only(top: 8),
              child: this.iconWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
