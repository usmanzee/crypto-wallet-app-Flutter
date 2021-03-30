import 'package:flutter/material.dart';
import 'package:b4u_wallet/component/style.dart';

class Themes {
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: ColorStyle.background,
    backgroundColor: ColorStyle.blackBackground,
    dividerColor: ColorStyle.iconColorDark,
    accentColor: ColorStyle.secondaryColor,
    primaryColor: ColorStyle.secondaryColor,
    hintColor: ColorStyle.fontSecondaryColorDark,
    buttonColor: ColorStyle.secondaryColor,
    canvasColor: ColorStyle.grayBackground,
    cardColor: ColorStyle.grayBackground,
    textSelectionTheme: TextSelectionThemeData(
        selectionColor: ColorStyle.fontColorDark,
        selectionHandleColor: ColorStyle.fontColorDarkTitle),
  );

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    accentColor: ColorStyle.primaryColor,
    primaryColor: ColorStyle.primaryColor,
    buttonColor: ColorStyle.primaryColor,
    cardColor: ColorStyle.cardColorLight,
    textSelectionTheme: TextSelectionThemeData(
        selectionColor: ColorStyle.fontColorLight,
        selectionHandleColor: ColorStyle.fontColorDarkTitle),
    scaffoldBackgroundColor: Colors.white,
    canvasColor: ColorStyle.whiteBacground,
    dividerColor: ColorStyle.iconColorLight,
    hintColor: ColorStyle.fontSecondaryColorLight,
  );
}
