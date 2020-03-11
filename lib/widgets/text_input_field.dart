import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:my_travel_wallet/data/main_data.dart';

class TextInputField extends StatefulWidget {
  TextInputField({
    this.hintText,
    this.obscure = false,
    this.autoFocus = false,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.onChanged,
  });

  final String hintText;
  final bool obscure;
  final bool autoFocus;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Function onChanged;

  @override
  _TextInputFieldState createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  bool _isValid = true;

  @override
  void initState() {
    widget.controller.addListener(() {
      _isValid = ((double.tryParse(widget.controller.text) != null &&
              double.tryParse(widget.controller.text) > 0) || widget.controller.text == "")
          ? true
          : false;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        keyboardType: widget.keyboardType,
        onChanged: (text) => widget.onChanged(text),
        controller: widget.controller,
        autofocus: widget.autoFocus,
        textAlign: TextAlign.center,
        obscureText: widget.obscure,
        style: TextStyle(color: prefs.getThemeAccentColor()),
        cursorColor: prefs.getThemeAccentColor(),
        decoration: InputDecoration(
          helperText: _isValid ? null : "Поле заполнено неправильно. Введите число (может содержать точку)",
          helperMaxLines: 2,
          helperStyle: TextStyle(color: Colors.red,),
          hintText: widget.hintText,
          contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: _isValid ? kDarkThemeAccentColor : Colors.red,
                width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: _isValid ? kDarkThemeAccentColor : Colors.red,
                width: 2.0),
          ),
          hintStyle: TextStyle(
            color: prefs.getThirdThemeColor(),
          ),
//        kInputDecoration.copyWith(
//          hintText: widget.hintText,
//          hintStyle: TextStyle(
//            color: prefs.getThirdThemeColor(),
//          ),
        ),
      ),
    );
  }
}
