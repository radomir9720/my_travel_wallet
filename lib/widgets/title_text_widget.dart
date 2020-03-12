import 'package:flutter/material.dart';
import 'package:my_travel_wallet/constants.dart';
import 'package:my_travel_wallet/data/main_data.dart';

class TitleText extends StatelessWidget {
  TitleText({
    @required this.text,
    this.fontSize = kTitleTextFontSize,
    this.center = true,
  });

  final double fontSize;
  final String text;
  final bool center;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(kPaddingDouble/2),
      child: Text(
        text,
        style: prefs.getMainTextStyle().copyWith(fontSize: fontSize),
        textAlign: center ? TextAlign.center : TextAlign.start,
      ),
    );
  }
}
