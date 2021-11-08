/// https://stackoverflow.com/questions/50081213/how-do-i-use-hexadecimal-color-strings-in-flutter
/// https://stackoverflow.com/questions/50549539/how-to-add-custom-color-to-flutter
/// https://stackoverflow.com/questions/5445085/understanding-colors-on-android-six-characters/11019879#11019879
/// <!--Percent to hex conversion table-->
/// <!--%  0  1  2  3  4  5  6  7  8  9-->
/// <!--0 00 03 05 08 0A 0D 0F 12 14 17-->
/// <!--1 1A 1C 1F 21 24 26 29 2B 2E 30-->
/// <!--2 33 36 38 3B 3D 40 42 45 47 4A-->
/// <!--3 4D 4F 52 54 57 59 5C 5E 61 63-->
/// <!--4 66 69 6B 6E 70 73 75 78 7A 7D-->
/// <!--5 80 82 85 87 8A 8C 8F 91 94 96-->
/// <!--6 99 9C 9E A1 A3 A6 A8 AB AD B0-->
/// <!--7 B3 B5 B8 BA BD BF C2 C4 C7 C9-->
/// <!--8 CC CF D1 D4 D6 D9 DB DE E0 E3-->
/// <!--9 E6 E8 EB ED F0 F2 F5 F7 FA FC-->

import 'package:flutter/material.dart';

class AppColors {
  static const MaterialColor clear = MaterialColor(0x00FFFFFF, <int, Color>{
    50: Color(0x0DFFFFFF),
    100: Color(0x1AFFFFFF),
    200: Color(0x33FFFFFF),
    300: Color(0x4DFFFFFF),
    400: Color(0x66FFFFFF),
    500: Color(0x80FFFFFF),
    600: Color(0x99FFFFFF),
    700: Color(0xB3FFFFFF),
    800: Color(0xCCFFFFFF),
    900: Color(0xE6FFFFFF),
  });

  static const MaterialColor black = MaterialColor(0xFF000000, <int, Color>{
    50: Color(0x0D000000),
    100: Color(0x1A000000),
    200: Color(0x33000000),
    300: Color(0x4D000000),
    400: Color(0x66000000),
    500: Color(0x80000000),
    600: Color(0x99000000),
    700: Color(0xB3000000),
    800: Color(0xCC000000),
    900: Color(0xE6000000),
  });

  static const MaterialColor white = MaterialColor(0xFFFFFFFF, <int, Color>{
    50: Color(0x0DFFFFFF),
    100: Color(0x1AFFFFFF),
    200: Color(0x33FFFFFF),
    300: Color(0x4DFFFFFF),
    400: Color(0x66FFFFFF),
    500: Color(0x80FFFFFF),
    600: Color(0x99FFFFFF),
    700: Color(0xB3FFFFFF),
    800: Color(0xCCFFFFFF),
    900: Color(0xE6FFFFFF),
  });

  static const MaterialColor main = MaterialColor(0xFF0A0434, <int, Color>{
    50: Color(0x0D0A0434),
    100: Color(0x1A0A0434),
    200: Color(0x330A0434),
    300: Color(0x4D0A0434),
    400: Color(0x660A0434),
    500: Color(0x800A0434),
    600: Color(0x990A0434),
    700: Color(0xB30A0434),
    800: Color(0xCC0A0434),
    900: Color(0xE60A0434),
  });

  static const MaterialColor background = MaterialColor(0xFFF4F6F8, <int, Color>{
    50: Color(0x0DF4F6F8),
    100: Color(0x1AF4F6F8),
    200: Color(0x33F4F6F8),
    300: Color(0x4DF4F6F8),
    400: Color(0x66F4F6F8),
    500: Color(0x80F4F6F8),
    600: Color(0x99F4F6F8),
    700: Color(0xB3F4F6F8),
    800: Color(0xCCF4F6F8),
    900: Color(0xE6F4F6F8),
  });

  static const MaterialColor text = MaterialColor(0xFF162940, <int, Color>{
    50: Color(0x0D162940),
    100: Color(0x1A162940),
    200: Color(0x33162940),
    300: Color(0x4D162940),
    400: Color(0x66162940),
    500: Color(0x80162940),
    600: Color(0x99162940),
    700: Color(0xB3162940),
    800: Color(0xCC162940),
    900: Color(0xE6162940),
  });

  static const MaterialColor greyText = MaterialColor(0xFFA8AAB3, <int, Color>{
    50: Color(0x0DA8AAB3),
    100: Color(0x1AA8AAB3),
    200: Color(0x33A8AAB3),
    300: Color(0x4DA8AAB3),
    400: Color(0x66A8AAB3),
    500: Color(0x80A8AAB3),
    600: Color(0x99A8AAB3),
    700: Color(0xB3A8AAB3),
    800: Color(0xCCA8AAB3),
    900: Color(0xE6A8AAB3),
  });

  static const MaterialColor blueText = MaterialColor(0xFF079DD9, <int, Color>{
    50: Color(0x0D079DD9),
    100: Color(0x1A079DD9),
    200: Color(0x33079DD9),
    300: Color(0x4D079DD9),
    400: Color(0x66079DD9),
    500: Color(0x80079DD9),
    600: Color(0x99079DD9),
    700: Color(0xB3079DD9),
    800: Color(0xCC079DD9),
    900: Color(0xE6079DD9),
  });

  static const MaterialColor greenText = MaterialColor(0xFF1DAA40, <int, Color>{
    50: Color(0x0D1DAA40),
    100: Color(0x1A1DAA40),
    200: Color(0x331DAA40),
    300: Color(0x4D1DAA40),
    400: Color(0x661DAA40),
    500: Color(0x801DAA40),
    600: Color(0x991DAA40),
    700: Color(0xB31DAA40),
    800: Color(0xCC1DAA40),
    900: Color(0xE61DAA40),
  });

  static const MaterialColor disable = MaterialColor(0xFFD1D2DB, <int, Color>{
    50: Color(0x0DD1D2DB),
    100: Color(0x1AD1D2DB),
    200: Color(0x33D1D2DB),
    300: Color(0x4DD1D2DB),
    400: Color(0x66D1D2DB),
    500: Color(0x80D1D2DB),
    600: Color(0x99D1D2DB),
    700: Color(0xB3D1D2DB),
    800: Color(0xCCD1D2DB),
    900: Color(0xE6D1D2DB),
  });

  static const MaterialColor error = MaterialColor(0xFFFFCFDA, <int, Color>{
    50: Color(0x0DFFCFDA),
    100: Color(0x1AFFCFDA),
    200: Color(0x33FFCFDA),
    300: Color(0x4DFFCFDA),
    400: Color(0x66FFCFDA),
    500: Color(0x80FFCFDA),
    600: Color(0x99FFCFDA),
    700: Color(0xB3FFCFDA),
    800: Color(0xCCFFCFDA),
    900: Color(0xE6FFCFDA),
  });

  static const MaterialColor cancel = MaterialColor(0xFFFF323D, <int, Color>{
    50: Color(0x0DFF323D),
    100: Color(0x1AFF323D),
    200: Color(0x33FF323D),
    300: Color(0x4DFF323D),
    400: Color(0x66FF323D),
    500: Color(0x80FF323D),
    600: Color(0x99FF323D),
    700: Color(0xB3FF323D),
    800: Color(0xCCFF323D),
    900: Color(0xE6FF323D),
  });

  static const MaterialColor border = MaterialColor(0xFFC4E7FF, <int, Color>{
    50: Color(0x0DC4E7FF),
    100: Color(0x1AC4E7FF),
    200: Color(0x33C4E7FF),
    300: Color(0x4DC4E7FF),
    400: Color(0x66C4E7FF),
    500: Color(0x80C4E7FF),
    600: Color(0x99C4E7FF),
    700: Color(0xB3C4E7FF),
    800: Color(0xCCC4E7FF),
    900: Color(0xE6C4E7FF),
  });

  static const MaterialColor borderLight = MaterialColor(0xFFF3F9FF, <int, Color>{
    50: Color(0x0DF3F9FF),
    100: Color(0x1AF3F9FF),
    200: Color(0x33F3F9FF),
    300: Color(0x4DF3F9FF),
    400: Color(0x66F3F9FF),
    500: Color(0x80F3F9FF),
    600: Color(0x99F3F9FF),
    700: Color(0xB3F3F9FF),
    800: Color(0xCCF3F9FF),
    900: Color(0xE6F3F9FF),
  });

  static const MaterialColor placeholder = MaterialColor(0xFFC4C4C4, <int, Color>{
    50: Color(0x0DC4C4C4),
    100: Color(0x1AC4C4C4),
    200: Color(0x33C4C4C4),
    300: Color(0x4DC4C4C4),
    400: Color(0x66C4C4C4),
    500: Color(0x80C4C4C4),
    600: Color(0x99C4C4C4),
    700: Color(0xB3C4C4C4),
    800: Color(0xCCC4C4C4),
    900: Color(0xE6C4C4C4),
  });

  static final Color barrier = AppColors.main.withOpacity(0.5);

  // #022A46
  static final Color shadow = Color.fromRGBO(2, 42, 70, 0.06);
}
