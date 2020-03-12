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
    this.errorText,
    this.checkIfIsValid,
  });

  final String hintText;
  final bool obscure;
  final bool autoFocus;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Function onChanged;
  final String errorText;
  final Function checkIfIsValid;

  @override
  _TextInputFieldState createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  bool _isValid = true;

  @override
  void initState() {
    if (widget.controller != null && widget.errorText != null) {
      widget.controller.addListener(() {
        _isValid = widget.checkIfIsValid(widget.controller) ? true : false;
        setState(() {});
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kPadding,
      child: TextField(
        key: widget.key,
        keyboardType: widget.keyboardType,
        onChanged: (text) => widget.onChanged(text),
        controller: widget.controller,
        autofocus: widget.autoFocus,
        textAlign: TextAlign.center,
        obscureText: widget.obscure,
        style: TextStyle(color: prefs.getThemeAccentColor()),
        cursorColor: prefs.getThemeAccentColor(),
        decoration: InputDecoration(
          helperText: _isValid ? null : widget.errorText,
          helperMaxLines: 3,
          helperStyle: TextStyle(
            color: Colors.red,
          ),
          hintText: widget.hintText,
          contentPadding: EdgeInsets.all(0.0),
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
        ),
      ),
    );
  }
}
