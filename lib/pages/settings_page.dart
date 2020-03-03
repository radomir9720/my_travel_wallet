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
    _themeSwitchValue = prefs.getSwitchThemeValue();
    prefs.addListener(() {
      if (this.mounted) setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    prefs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: prefs.getSecondaryThemeColor(),
      appBar: AppBar(
        title: Text(
          "Настройки",
          style: prefs.getMainTextStyle(),
        ),
        backgroundColor: prefs.getMainThemeColor(),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          SettingsCard(
            title: "Темная тема",
            value: _themeSwitchValue,
            function: () async {
              _themeSwitchValue = !_themeSwitchValue;
              prefs.setSwitchThemeValue(_themeSwitchValue);
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
