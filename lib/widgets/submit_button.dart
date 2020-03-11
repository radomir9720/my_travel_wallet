import 'package:flutter/material.dart';
import 'package:my_travel_wallet/constants.dart';
import 'package:my_travel_wallet/data/main_data.dart';

class SubmitButton extends StatelessWidget {
  SubmitButton({this.buttonTitle, this.onPressed});
  final String buttonTitle;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kPadding,
      child: MaterialButton(
        color: prefs.getThemeAccentColor(),
        height: 50.0,
        minWidth: double.infinity,
        onPressed: onPressed,
        child: Text(
          buttonTitle,
          style: prefs.getMainTextStyle().copyWith(fontSize: 15.0),
        ),
      ),
    );
  }
}
