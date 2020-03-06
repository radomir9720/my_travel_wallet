import 'package:flutter/material.dart';

// ===================== CustomBottomNavigationBarButton =====================
const double kCustomBottomNavigationBarButtonHeight = 50.0;
const double kCustomBottomNavigationBarButtonWidth = 10.0;

// ===================== CustomBottomNavigationBar =====================
const double kCustomBottomNavigationBarElevation = 8.0;
const double kCustomBottomNavigationBarBorderHeight = 1.0;

// ===================== Theme Colors ===================== \\

// Light Theme
const Color kLightThemeMainColor = Color(0xffF3F3F6);
const Color kLightThemeSecondaryColor = Colors.white70;
const Color kLightThemeThirdColor = Colors.black87;
//const Color kLightThemeAccentColor = Colors.black;
const Color kLightThemeAccentColor = Colors.indigo;
const TextStyle kLightThemeMainTextStyle = TextStyle(color: kLightThemeThirdColor);

// Dark Theme

const Color kDarkThemeMainColor = Color(0xFF1d1333);
const Color kDarkThemeSecondaryColor = Color(0xFF111328);
const Color kDarkThemeThirdColor = Color(0xFF8D8E98);
const Color kDarkThemeAccentColor = Colors.indigo;
const TextStyle kDarkThemeMainTextStyle = TextStyle(color: kDarkThemeThirdColor);

// ===================== Settings Page ===================== \\

// Settings card
const double kStartIndentDividerValue = 10.0;
const double kEndIndentDividerValue = 10.0;

// ===================== TextInputDecoration ===================== \\
const kInputDecoration = InputDecoration(
  hintText: 'Введите текст',
  contentPadding:
  EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kDarkThemeAccentColor, width: 1.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kDarkThemeAccentColor, width: 2.0),
  ),
);


// ===================== Keys ===================== \\

const String kBaseCurrencyKey = "baseCurrency";
const String kDarkThemeKey = 'darkMode';
const String kScreenWidthKey = 'screenWidth';
const String kScreenHeightKey = 'screenHeight';
const String kIsAuthorizedStatusKey = 'isAuthorized';