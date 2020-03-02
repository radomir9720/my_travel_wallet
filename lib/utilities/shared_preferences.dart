import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {

  SharedPreferences _prefs;

  void init() async {
    _prefs = await SharedPreferences.getInstance();
    if (await _prefs.getBool('lightTheme') == null) await _prefs.setBool('lightTheme', true);
    _switchThemeValue = await _prefs.getBool('lightTheme');
    print(_switchThemeValue);
  }

  bool _switchThemeValue;

  bool getSwitchThemeValue() {
    return _switchThemeValue;
  }

  void setSwitchThemeValue(bool value) {
    _switchThemeValue = value;
  }

  void dispose() async {
    await _prefs.setBool('lightTheme', _switchThemeValue);

  }


}