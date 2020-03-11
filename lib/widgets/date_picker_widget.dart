import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_travel_wallet/data/main_data.dart';
import '../constants.dart';

class DatePickerWidget extends StatelessWidget {
  DatePickerWidget({
    this.format,
//    this.initialValue,
    this.controller,
    this.hintText,
  });
  final String format;
//  final DateTime initialValue;
  final TextEditingController controller;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: DateTimeField(
          controller: controller,
          style: TextStyle(color: prefs.getThemeAccentColor()),
          textAlign: TextAlign.center,
          resetIcon: Icon(
            Icons.clear,
            color: prefs.getThirdThemeColor(),
          ),
//          initialValue: initialValue ?? DateTime.now(),
          decoration: kInputDecoration.copyWith(
              contentPadding: EdgeInsets.all(5.0),
              hintText: hintText,
              hintStyle: prefs.getMainTextStyle()),
          format: DateFormat(format),
          onShowPicker: (context, currentValue) {
            return showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                initialDate: currentValue ?? DateTime.now(),
                lastDate: DateTime(2100));
          },
        ),
      ),
    );
  }
}
