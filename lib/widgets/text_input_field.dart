import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:my_travel_wallet/data/main_data.dart';

class TextInputField extends StatelessWidget {
  TextInputField({
    this.hintText,
    this.obscure = false,
    this.autoFocus = false,
    this.controller,
  });

  final String hintText;
  final bool obscure;
  final bool autoFocus;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        autofocus: autoFocus,
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
