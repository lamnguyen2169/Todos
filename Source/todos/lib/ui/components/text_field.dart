/// https://pub.dev/packages/mask_text_input_formatter/install
/// https://pub.dev/packages/flutter_multi_formatter#masked-formatter

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UITextField extends StatelessWidget {
  /// public properties
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final bool autofocus;
  final String obscuringCharacter;
  final bool obscureText;
  final String? text;
  final Color color;
  final Color? cursorColor;
  final String? placeholder;
  final Color? placeholderColor;
  final double fontSize;
  final double? placeholderFontSize;
  final FontWeight? fontWeight;
  final FontWeight? placeholderFontWeight;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final Color? backgroundColor;
  final double borderRadius;
  final double borderWidth;
  final Color borderColor;
  final BorderStyle borderStyle;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters;
  final TextOverflow? overflow;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;

  /// Constructor
  UITextField({
    Key? key,
    this.controller,
    this.focusNode,
    this.textAlign = TextAlign.start,
    this.textAlignVertical = TextAlignVertical.center,
    this.autofocus = false,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.text,
    this.color = Colors.white,
    this.cursorColor = Colors.black,
    this.placeholder,
    this.placeholderColor = Colors.grey,
    this.fontSize = 8,
    this.placeholderFontSize,
    this.fontWeight,
    this.placeholderFontWeight,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.backgroundColor = Colors.transparent,
    this.borderRadius = 8,
    this.borderWidth = 0,
    this.borderColor = Colors.transparent,
    this.borderStyle = BorderStyle.solid,
    this.margin,
    this.padding,
    this.width,
    this.height,
    this.enabled = true,
    this.inputFormatters,
    this.overflow,
    this.onTap,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
  }) : super(key: key);

  /// MARK: - Local methods

  /// MARK: - Layout methods
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        width: this.width,
        height: this.height ?? 35,
        margin: this.margin ?? EdgeInsets.zero,
        padding: this.padding ?? EdgeInsets.only(top: 0, left: 15, bottom: 0, right: 15),
        decoration: BoxDecoration(
          color: this.backgroundColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(this.borderRadius)),
          border: Border.all(width: this.borderWidth, color: this.borderColor, style: this.borderStyle),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: this.controller,
                focusNode: this.focusNode,
                keyboardType: this.keyboardType,
                textInputAction: this.textInputAction,
                autocorrect: false,
                textAlign: this.textAlign,
                textAlignVertical: this.textAlignVertical,
                autofocus: this.autofocus,
                obscuringCharacter: this.obscuringCharacter,
                obscureText: this.obscureText,
                cursorColor: this.cursorColor,
                decoration: InputDecoration(
                  isCollapsed: true,
                  hintText: this.placeholder,
                  hintStyle: TextStyle(
                    fontSize: this.placeholderFontSize ?? this.fontSize,
                    fontWeight: this.placeholderFontWeight ?? this.fontWeight,
                    color: this.placeholderColor,
                  ),
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  fontSize: this.fontSize,
                  fontWeight: this.fontWeight,
                  color: this.color,
                  overflow: this.overflow,
                ),
                enabled: this.enabled,
                inputFormatters: this.inputFormatters,
                onTap: this.onTap,
                onChanged: this.onChanged,
                onEditingComplete: this.onEditingComplete,
                onSubmitted: this.onSubmitted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
