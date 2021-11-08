/// https://stackoverflow.com/questions/56381937/how-to-disable-a-linting-rule-inline-in-flutter#56382232
/// https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// This class (or a class that this class inherits from) is marked as ‘@immutable’,
/// but one or more of its instance fields aren’t final
/// ignore: must_be_immutable
abstract class BaseScreen extends StatefulWidget {
  /// MARK: - Public properties
  final SystemUiOverlayStyle systemOverlayStyle;
  final bool isNavigationChild;
  String? selectedNavigationRoute;

  /// MARK: - Constructors
  BaseScreen({
    Key? key,
    this.systemOverlayStyle = SystemUiOverlayStyle.light,
    this.isNavigationChild = false,
  }) : super(key: key);
}

extension Screen on BaseScreen {
  static void endEditing(BuildContext context) {
    final FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
