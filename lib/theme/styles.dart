import 'package:flutter/material.dart';

import 'colors.dart';

class MyStyles {
  MyStyles();

  static const kSpacingUnit = 10;
  static const double padding = 20;
  static const double avatarRadius = 80;

  static const _colorScheme = ColorScheme.light(
    primary: kMainColor,
    secondary: kWhiteColor,
    onPrimary: kTextColor,
    onSecondary: kIconColor,
    onBackground: kBackgroundColor,
  );

  static ThemeData themeData() {
    return ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        canvasColor: Colors.transparent,
        cardColor: cardColor,
        primaryColor: _colorScheme.primary,
        brightness: Brightness.dark,
        backgroundColor: kWhiteColor,
        scaffoldBackgroundColor: _colorScheme.onBackground);
  }

  static ThemeColor themeMode() {
    return ThemeColor(
      textColor: kTextColor,
      tileColor: kBackgroundColor,
      mainTextColor: kMainTextColor,
      cardColor: cardColor,
      hintTextColor: kHintColor,
      lightTextColor: kLightTextColor,
      itemTileColor: itemContainerColor,
      gradient: [
        kBackgroundColor,
        kMainColor,
      ],
      containerColor: containerColor,
      containerDescColor: containerDescriptionColor
    );
  }
}

class ThemeColor {
  ThemeColor({
    this.gradient,
    this.backgroundColor,
    this.textColor,
    this.mainTextColor,
    this.hintTextColor,
    this.lightTextColor,
    this.bottomNav,
    this.tileColor,
    this.cardColor,
    this.itemTileColor,
    this.containerColor,
    this.containerDescColor,
  });

  List<Color> gradient;
  Color backgroundColor;
  Color bottomNav;
  Color textColor;
  Color mainTextColor;
  Color hintTextColor;
  Color lightTextColor;
  Color tileColor;
  Color cardColor;
  Color itemTileColor;
  Color containerColor;
  Color containerDescColor;
}
