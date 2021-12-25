import 'package:babcare/theme/style.dart';
import 'package:flutter/material.dart';

final mainTheme = ThemeData(
    primaryColor: primaryColor,
    backgroundColor: backgroundColor,
    accentColor: accentColor,
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(primary: primaryColor, secondary: accentColor),
    fontFamily: "RB");
