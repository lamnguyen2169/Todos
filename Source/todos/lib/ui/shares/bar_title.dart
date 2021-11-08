///

import 'package:flutter/material.dart';

import '../colors.dart';

class BarTitle extends StatelessWidget {
  final String? title;
  final double fontSize;
  final FontWeight? fontWeight;
  final Color color;
  final TextAlign titleAlignment;

  const BarTitle({
    Key? key,
    this.title,
    this.fontSize = 18,
    this.fontWeight = FontWeight.bold,
    this.color = AppColors.main,
    this.titleAlignment = TextAlign.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '${this.title ?? ''}',
      textAlign: this.titleAlignment,
      style: TextStyle(
        fontSize: this.fontSize,
        fontWeight: this.fontWeight,
        color: this.color,
      ),
    );
  }
}
