/// https://stackoverflow.com/questions/56253787/how-to-handle-textfield-validation-in-password-in-flutter
/// http://stackoverflow.com/questions/55552230/ddg#55552272
/// https://coflutter.com/how-to-validate-phone-number-in-dart-flutter/

import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class Formatters {
  static final MaskedInputFormatter phone = MaskedInputFormatter('#### ### ###', allowedCharMatcher: RegExp(r'[0-9]'));
  static final MaskedInputFormatter otp = MaskedInputFormatter('#', allowedCharMatcher: RegExp(r'[0-9]'));
}
