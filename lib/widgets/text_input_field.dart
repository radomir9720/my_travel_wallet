import 'package:flutter/material.dart';

import '../constants.dart';
import '../main.dart';

class TextInputField extends StatelessWidget {

  TextInputField({this.hintText, this.obscure = false});

  final String hintText;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        textAlign: TextAlign.center,
        obscureText: obscure,
        style: TextStyle(color: prefs.getThemeAccentColor()),
        cursorColor: prefs.getThemeAccentColor(),
        decoration: kInputDecoration.copyWith(
          hintText: hintText,
          hintStyle: TextStyle(
            color: prefs.getThirdThemeColor(),
          ),
        ),
      ),
    );
  }
}
