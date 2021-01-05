import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:crypto_template/component/style.dart';

class DemoTheme {
  final String name;
  final ThemeData data;

  const DemoTheme(this.name, this.data);
}

class ThemeBloc {
  final Stream<ThemeData> themeDataStream;
  final Sink<DemoTheme> selectedTheme;

  factory ThemeBloc() {
    final selectedTheme = PublishSubject<DemoTheme>();
    final themeDataStream = selectedTheme.distinct().map((theme) => theme.data);
    return ThemeBloc._(themeDataStream, selectedTheme);
  }

  const ThemeBloc._(this.themeDataStream, this.selectedTheme);

  DemoTheme initialTheme() {
    return DemoTheme(
        'initial',
        ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: colorStyle.background,
            backgroundColor: colorStyle.blackBackground,
            dividerColor: colorStyle.iconColorDark,
            accentColor: colorStyle.primaryColor,
            primaryColor: colorStyle.primaryColor,
            hintColor: colorStyle.fontSecondaryColorDark,
            buttonColor: colorStyle.primaryColor,
            canvasColor: colorStyle.grayBackground,
            cardColor: colorStyle.grayBackground,
            textSelectionColor: colorStyle.fontColorDark,
            textSelectionHandleColor: colorStyle.fontColorDarkTitle));
  }
}

class Themes {
  static final darkTheme = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: colorStyle.background,
      backgroundColor: colorStyle.blackBackground,
      dividerColor: colorStyle.iconColorDark,
      accentColor: colorStyle.secondaryColor,
      primaryColor: colorStyle.secondaryColor,
      hintColor: colorStyle.fontSecondaryColorDark,
      buttonColor: colorStyle.primaryColor,
      canvasColor: colorStyle.grayBackground,
      cardColor: colorStyle.grayBackground,
      textSelectionColor: colorStyle.fontColorDark,
      textSelectionHandleColor: colorStyle.fontColorDarkTitle);

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    accentColor: colorStyle.secondaryColor,
    primaryColor: colorStyle.primaryColor,
    buttonColor: colorStyle.primaryColor,
    cardColor: colorStyle.cardColorLight,
    textSelectionColor: colorStyle.fontColorLight,
    // scaffoldBackgroundColor: Color(0xFFFDFDFD),
    scaffoldBackgroundColor: Colors.white,
    canvasColor: colorStyle.whiteBacground,
    dividerColor: colorStyle.iconColorLight,
    hintColor: colorStyle.fontSecondaryColorLight,
  );
}
