import 'package:flutter/material.dart';
import 'package:my_travel_wallet/data/main_data.dart';

import '../constants.dart';

Widget stackBehindDismiss() {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: kPaddingDouble,
      vertical: kPaddingDouble / 2,
    ),
    child: Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      color: prefs.getThemeAccentColor(),
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    ),
  );
}
