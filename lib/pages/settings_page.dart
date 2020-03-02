import 'package:flutter/material.dart';
import 'package:my_travel_wallet/constants.dart';
import 'package:my_travel_wallet/widgets/settings_card.dart';
import 'package:my_travel_wallet/utilities/singleton.dart';
import 'package:my_travel_wallet/tabs/main_navigation_view.dart';
import 'package:my_travel_wallet/utilities/shared_preferences.dart';

class SettingsPage extends StatefulWidget {

  SettingsPage({this.key});

  final Key key;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

//  MySharedPreferences _mySharedPreferences = MySharedPreferences();
  bool _themeSwitchValue;

  @override
  void initState() {
    _themeSwitchValue = mySharedPreferences.getSwitchThemeValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _themeSwitchValue ? kLightThemeMainColor : kLightThemeSecondaryColor.withOpacity(0.5),
      appBar: AppBar(
        title: Text(
          "Настройки",
          style: TextStyle(color: kLightThemeSecondaryColor),
        ),
        backgroundColor: kLightThemeMainColor,
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          SettingsCard(
            title: "Темная тема",
            value: _themeSwitchValue,
            function: () async {
              _themeSwitchValue = !_themeSwitchValue;
              mySharedPreferences.setSwitchThemeValue(_themeSwitchValue);
              print(mySharedPreferences.getSwitchThemeValue());
            },
          ),
          SettingsCard(title: "Версия приложения", subTitle: "1.0.0",)
        ],
      ),
    );
  }
}
