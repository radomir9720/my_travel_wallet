import 'package:flutter/material.dart';
import 'package:my_travel_wallet/main.dart';

class CurrencyPage extends StatelessWidget {
  CurrencyPage({this.key});
  final Key key;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: prefs.getSecondaryThemeColor(),
    );
  }
}
