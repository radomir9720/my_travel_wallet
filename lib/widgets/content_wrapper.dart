import 'package:flutter/material.dart';

import 'package:my_travel_wallet/data/main_data.dart';

class CustomPageContentWrapper extends StatelessWidget {
  CustomPageContentWrapper({this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: prefs.getSecondaryThemeColor(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          padding: EdgeInsets.all(10.0),
          color: prefs.getMainThemeColor(),
          child: child,
        ),
      ),
    );;
  }
}
