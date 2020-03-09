import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_travel_wallet/constants.dart';

class MySharedPreferences extends ChangeNotifier {
  // ====================== INIT ====================== \\

  SharedPreferences _prefs;

  void init() async {
    _prefs = await SharedPreferences.getInstance();
    // По умолчанию тема будет светлой
    _switchThemeValue = await _prefs.getBool(kDarkThemeKey) ?? false;
    // По умолчанию базовой валютой будет USD
    _baseCurrency = await _prefs.getString(kBaseCurrencyKey) ?? "USD";
    // Если данных нет по авторизации -> пользователь не авторизован.
    _isAuthorized = await _prefs.getBool(kIsAuthorizedStatusKey) ?? false;
    // TODO Хотелось в идеале в SharedPreferences писать размеры экрана, однако, метод, описанный ниже(Хотел прокинуть context из main.dart через main_data.dart сюда, а дальше у этого контекста взять ширину и высоту), не работает. Поискать другие варианты.
//    _screenWidth = await _prefs.getDouble(kScreenWidthKey) ?? MediaQuery.of(context).size.width;
//        _screenHeight = await _prefs.getDouble(kScreenHeightKey) ?? MediaQuery.of(context).size.height;

  }

  // ====================== Theme Mode(Light/Dark) ====================== \\

  bool _switchThemeValue;

  bool getSwitchThemeValue() => _switchThemeValue;

  void setSwitchThemeValue(bool value) {
    _switchThemeValue = value;
    notifyListeners();
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



  // ====================== Screen size ====================== \\

  double _screenWidth;
  double _screenHeight;

  double getScreenWidth() => _screenWidth;
  double getScreenHeight() => _screenHeight;

  // ====================== Google auth ====================== \\

  bool _isAuthorized;

  bool getAuthorizedStatus() => _isAuthorized;
  void setAuthorizedStatus(bool value) async {
    _isAuthorized = value;
    _prefs.setBool(kIsAuthorizedStatusKey, value);
  }

  // ====================== Dispose ====================== \\

  void dispose() async {
    await _prefs.setBool(kDarkThemeKey, _switchThemeValue);
  }
}
