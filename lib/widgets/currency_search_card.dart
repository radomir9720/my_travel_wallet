import 'package:flutter/material.dart';
import 'package:my_travel_wallet/data/main_data.dart';

class CurrencySearchResultCard extends StatelessWidget {
  CurrencySearchResultCard({this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            textAlign: TextAlign.left,
            style: prefs.getMainTextStyle().copyWith(fontSize: 18.0),
          ),
          Divider(color: prefs.getThemeAccentColor(), height: 0.0,),
        ],
      ),
    );
  }
}
