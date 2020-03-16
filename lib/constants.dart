import 'package:flutter/material.dart';

// ===================== CustomBottomNavigationBarButton =====================
const double kCustomBottomNavigationBarButtonHeight = 47.0;
const double kCustomBottomNavigationBarButtonWidth = 47.0;

// ===================== CustomBottomNavigationBar =====================
const double kCustomBottomNavigationBarElevation = 8.0;
const double kCustomBottomNavigationBarBorderHeight = 1.0;
const double kCustomBottomNavigationBarPadding = 2.0;

// ===================== Theme Colors ===================== \\

// Light Theme
const Color kLightThemeMainColor = Color(0xffF3F3F6);
const Color kLightThemeSecondaryColor = Colors.white;
const Color kLightThemeThirdColor = Colors.black;
const Color kLightThemeAccentColor = Colors.blue;
//const Color kLightThemeAccentColor = Colors.indigo;
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
    borderSide: BorderSide(color: kDarkThemeAccentColor, width: kBorderWidth),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kDarkThemeAccentColor, width: 2.0),
  ),
);

// ===================== Other Constants ===================== \\

const double kBorderRadiusDouble = 4.0;
const Radius kBorderRadius = Radius.circular(kBorderRadiusDouble);
const double kPaddingDouble = 8.0;
const EdgeInsets kPadding = EdgeInsets.all(kPaddingDouble);
const double kTitleTextFontSize = 20.0;
const String kPathToImages = "assets/images/flags/";
const double kElevationDouble = 10.0;
const double kBorderWidth = 1.5;

// ===================== Keys ===================== \\

const String kBaseCurrencyKey = "baseCurrency";
const String kDarkThemeKey = 'darkMode';
const String kScreenWidthKey = 'screenWidth';
const String kScreenHeightKey = 'screenHeight';
const String kIsAuthorizedStatusKey = 'isAuthorized';
const String kCurrencyPageDataKey = 'currencyPageData';
const String kCurrencyPageToConvertCardKey = 'toConvert';
const String kCurrencyPageValueKey = 'currencyValue';
const String kCurrenciesUpdateTimeKey = 'updatedAt';
const String kCurrencyPageEnterSumFieldKey = 'enterSum';
const String kHomePageTravelCardKey = 'travelCard';
const String kHomePageTravelExpensesKey = 'travelCardExpenses';

// ===================== DateTime ===================== \\

const Map<int, Map<String, String>> months = {
  1: {"fullDeclination": "января", "short": "янв"},
  2: {"fullDeclination": "февраля", "short": "фев"},
  3: {"fullDeclination": "марта", "short": "мар"},
  4: {"fullDeclination": "апреля", "short": "апр"},
  5: {"fullDeclination": "мая", "short": "май"},
  6: {"fullDeclination": "июня", "short": "июнь"},
  7: {"fullDeclination": "июля", "short": "июль"},
  8: {"fullDeclination": "августа", "short": "авг"},
  9: {"fullDeclination": "сентября", "short": "сен"},
  10: {"fullDeclination": "октября", "short": "окт"},
  11: {"fullDeclination": "ноября", "short": "ноя"},
  12: {"fullDeclination": "декабря", "short": "дек"},
};