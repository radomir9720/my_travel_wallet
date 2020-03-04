import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_travel_wallet/constants.dart';

class MySharedPreferences extends ChangeNotifier {
  // ====================== INIT ====================== \\

  SharedPreferences _prefs;

  Future<bool> init() async {
    _prefs = await SharedPreferences.getInstance();
    // По умолчанию тема будет светлой
    _switchThemeValue = await _prefs.getBool(kDarkThemeKey) ?? false;
    // По умолчанию базовой валютой будет USD
    _baseCurrency = await _prefs.getString(kBaseCurrencyKey) ?? "USD";
    return _switchThemeValue != null;
  }

  // ====================== Theme Mode(Light/Dark) ====================== \\

  bool _switchThemeValue;

  bool getSwitchThemeValue() => _switchThemeValue;

  void setSwitchThemeValue(bool value) {
    _switchThemeValue = value;
    notifyListeners();
//    saveSwitchThemeValue();
  }

  void dispose() async {
    await _prefs.setBool(kDarkThemeKey, _switchThemeValue);
  }

// ====================== Theme Colors and Text Style ====================== \\

  Color getMainThemeColor() =>
      _switchThemeValue ? kDarkThemeMainColor : kLightThemeMainColor;

  Color getSecondaryThemeColor() =>
      _switchThemeValue ? kDarkThemeSecondaryColor : kLightThemeSecondaryColor;

  Color getThirdThemeColor() =>
      _switchThemeValue ? kDarkThemeThirdColor : kLightThemeThirdColor;

  Color getThemeAccentColor() =>
      _switchThemeValue ? kDarkThemeAccentColor : kLightThemeAccentColor;

  TextStyle getMainTextStyle() =>
      _switchThemeValue ? kDarkThemeMainTextStyle : kLightThemeMainTextStyle;

  // ====================== Currency ====================== \\

  String _baseCurrency;

  String getBaseCurrency() => _baseCurrency;

  void setBaseCurrency(String value) {
    _baseCurrency = value;
    notifyListeners();
  }

}
