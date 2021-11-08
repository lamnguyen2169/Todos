///

import 'package:flutter/material.dart';

import '../components/components.dart';
import '../images.dart';
import '../../router_controller.dart';

class BarBackButton extends StatelessWidget {
  final String routeName;
  final VoidCallback? onPressed;

  const BarBackButton({
    Key? key,
    required this.routeName,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Button(
      icon: AppImages.ic_back_background,
      margin: EdgeInsets.only(left: 16),
      width: 32,
      height: 32,
      onPressed: (this.onPressed == null)
          ? () {
              RouterController.pop(this.routeName, context);
            }
          : this.onPressed,
    );
  }
}
