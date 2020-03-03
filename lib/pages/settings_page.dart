import 'package:flutter/material.dart';
import 'package:my_travel_wallet/widgets/settings_card.dart';
import 'package:my_travel_wallet/main.dart';
class SettingsPage extends StatefulWidget {
  SettingsPage({this.key});

  final Key key;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _themeSwitchValue;

  @override
  void initState() {
    _themeSwitchValue = mySharedPreferences.getSwitchThemeValue();
    mySharedPreferences.addListener(() {
      if (this.mounted) setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    mySharedPreferences.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mySharedPreferences.getSecondaryThemeColor(),
      appBar: AppBar(
        title: Text(
          "Настройки",
          style: mySharedPreferences.getMainTextStyle(),
        ),
        backgroundColor: mySharedPreferences.getMainThemeColor(),
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
            },
          ),
          SettingsCard(
            title: "Версия приложения",
            subTitle: "1.0.0",
          )
        ],
      ),
    );
  }
}
