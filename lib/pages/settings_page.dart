import 'package:flutter/material.dart';
import 'package:my_travel_wallet/constants.dart';
import 'package:my_travel_wallet/widgets/settings_card.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          )
        ],
      ),
    );
  }
}
