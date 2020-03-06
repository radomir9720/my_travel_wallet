import 'package:flutter/material.dart';
import 'package:my_travel_wallet/data/main_data.dart';

class DialogWindowButton extends StatelessWidget {
  DialogWindowButton({
    @required this.buttonText,
    @required this.buttonTextStyle,
    this.function,
  });

  final String buttonText;
  final TextStyle buttonTextStyle;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
          side: BorderSide(color: prefs.getThemeAccentColor())),
      onPressed: () => function(),
      child: Text(
        buttonText,
        style: buttonTextStyle,
      ),
    );
  }
}
