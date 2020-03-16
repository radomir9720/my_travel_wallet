import 'package:flutter/material.dart';
import 'package:my_travel_wallet/data/main_data.dart';

class SmallButton extends StatelessWidget {
  SmallButton({this.buttonTitle, this.onPressed, this.height});
  final String buttonTitle;
  final Function onPressed;
  final double height;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => onPressed(),
      height: height,
      child: Text(
        buttonTitle,
        style: prefs.getMainTextStyle(),
      ),
      color: prefs.getThemeAccentColor(),
    );
  }
}
