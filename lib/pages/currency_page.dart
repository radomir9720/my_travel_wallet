import 'package:flutter/material.dart';
import 'package:my_travel_wallet/main.dart';
import 'package:my_travel_wallet/widgets/content_wrapper.dart';


class CurrencyPage extends StatefulWidget {
  CurrencyPage({this.key});
  final Key key;

  @override
  _CurrencyPageState createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: prefs.getSecondaryThemeColor(),
      appBar: AppBar(
        backgroundColor: prefs.getMainThemeColor(),
        title: Text(
          "Конвертер валют",
          style: prefs.getMainTextStyle(),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            color: prefs.getMainThemeColor(),
            height: 100.0,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Выберите валюту и введите сумму",
                  style: prefs.getMainTextStyle(),
                ),
                Row(),
              ],
            ),
          ),
          Divider(
            color: prefs.getThemeAccentColor(),
            height: 0.0,
          )
        ],
      ),
    );
  }
}
