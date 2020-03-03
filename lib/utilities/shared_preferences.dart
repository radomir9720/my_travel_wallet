import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_travel_wallet/constants.dart';


class MySharedPreferences extends ChangeNotifier {
  SharedPreferences _prefs;

  Future<bool> init() async {
    _prefs = await SharedPreferences.getInstance();
    _switchThemeValue = await _prefs.getBool(kDarkThemeKey) ?? false;
    return _switchThemeValue != null;
  }

  bool _switchThemeValue;

  bool getSwitchThemeValue() {
    return _switchThemeValue;
  }

  void setSwitchThemeValue(bool value) {
    _switchThemeValue = value;
    notifyListeners();
  }

  Color getMainThemeColor() => _switchThemeValue ? kDarkThemeMainColor : kLightThemeMainColor;

  Color getSecondaryThemeColor() => _switchThemeValue ? kDarkThemeSecondaryColor : kLightThemeSecondaryColor;

  Color getThirdThemeColor() => _switchThemeValue ? kDarkThemeThirdColor : kLightThemeThirdColor;

  Color getThemeAccentColor() => _switchThemeValue ? kDarkThemeAccentColor : kLightThemeAccentColor;

  TextStyle getMainTextStyle() => _switchThemeValue ? kDarkThemeMainTextStyle : kLightThemeMainTextStyle;

  void dispose() async {
    await _prefs.setBool(kDarkThemeKey, _switchThemeValue);
  }
}

