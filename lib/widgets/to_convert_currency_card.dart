import 'package:flutter/material.dart';
import 'package:my_travel_wallet/data/main_data.dart';

class ToConvertCurrencyCard extends StatefulWidget {

  ToConvertCurrencyCard({this.currencyName, this.currencyValue, this.currencySymbol, this.imgName});

  final String currencyName;
  final String currencyValue;
  final String currencySymbol;
  final String imgName;

  @override
  _ToConvertCurrencyCardState createState() => _ToConvertCurrencyCardState();
}

class _ToConvertCurrencyCardState extends State<ToConvertCurrencyCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(alignment: AlignmentDirectional.center, children: <Widget>[
        Container(
          padding: EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image(
                image: AssetImage("assets/images/flags/" + widget.imgName),
                height: 35.0,
                width: 60.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width *0.4,
                child: Text(
                  widget.currencyName,
                  style: prefs.getMainTextStyle(),
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
              ),
              widget.currencyValue == null
                  ? Icon(
                Icons.keyboard_arrow_down,
                color: prefs.getThemeAccentColor(),
              )
                  : Container(
                  padding: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: prefs.getThemeAccentColor(),
                    borderRadius: BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                  ),
                  child: Text(
                    widget.currencyValue + " " + widget.currencySymbol,
                    style: TextStyle(
                        fontSize: 20.0, color: prefs.getMainThemeColor()),
                  )),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 51.0,
          decoration: BoxDecoration(
            border: Border.all(color: prefs.getThemeAccentColor()),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
        ),
      ]),
    );
  }
}
