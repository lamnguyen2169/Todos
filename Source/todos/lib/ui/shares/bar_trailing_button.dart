///

import 'package:flutter/material.dart';

import '../components/components.dart';

class BarTrailingButton extends StatelessWidget {
  final String icon;
  final VoidCallback? onPressed;

  const BarTrailingButton({
    Key? key,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Button(
      icon: icon,
      margin: EdgeInsets.only(right: 16),
      width: 32,
      height: 32,
      onPressed: this.onPressed,
    );
  }
}
