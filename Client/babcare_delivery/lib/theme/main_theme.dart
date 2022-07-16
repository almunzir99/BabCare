import 'package:babcare_delivery/theme/style.dart';
import 'package:flutter/material.dart';

final mainTheme = ThemeData(
    primaryColor: primaryColor,
    backgroundColor: backgroundColor,
    accentColor: accentColor,
    splashFactory: InkRipple.splashFactory,
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(primary: primaryColor, secondary: accentColor),
    fontFamily: "RB");
