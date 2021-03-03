import 'package:flutter/material.dart';
import 'package:crypto_template/component/style.dart';

class DemoTheme {
  final String name;
  final ThemeData data;

  const DemoTheme(this.name, this.data);
}

class ThemeBloc {
  DemoTheme initialTheme() {
    return DemoTheme(
        'initial',
        ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: ColorStyle.background,
            backgroundColor: ColorStyle.blackBackground,
            dividerColor: ColorStyle.iconColorDark,
            accentColor: ColorStyle.primaryColor,
            primaryColor: ColorStyle.primaryColor,
            hintColor: ColorStyle.fontSecondaryColorDark,
            buttonColor: ColorStyle.primaryColor,
            canvasColor: ColorStyle.grayBackground,
            cardColor: ColorStyle.grayBackground,
            textSelectionColor: ColorStyle.fontColorDark,
            textSelectionHandleColor: ColorStyle.fontColorDarkTitle));
  }
}

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
      textSelectionColor: ColorStyle.fontColorDark,
      textSelectionHandleColor: ColorStyle.fontColorDarkTitle);

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    accentColor: ColorStyle.primaryColor,
    primaryColor: ColorStyle.primaryColor,
    buttonColor: ColorStyle.primaryColor,
    cardColor: ColorStyle.cardColorLight,
    textSelectionColor: ColorStyle.fontColorLight,
    // scaffoldBackgroundColor: Color(0xFFFDFDFD),
    scaffoldBackgroundColor: Colors.white,
    canvasColor: ColorStyle.whiteBacground,
    dividerColor: ColorStyle.iconColorLight,
    hintColor: ColorStyle.fontSecondaryColorLight,
  );
}
