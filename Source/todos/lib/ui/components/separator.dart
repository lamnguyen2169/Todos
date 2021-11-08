///

import 'package:flutter/material.dart';

import '../colors.dart';

class Separator extends StatelessWidget {
  final double height;
  final Color color;

  const Separator({
    Key? key,
    this.height = 1,
    this.color = AppColors.background,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: this.height,
      thickness: this.height,
      color: this.color,
    );
  }
}
