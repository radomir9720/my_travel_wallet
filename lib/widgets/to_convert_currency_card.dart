import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_travel_wallet/constants.dart';
import 'package:my_travel_wallet/data/main_data.dart';

class ToConvertCurrencyCard extends StatefulWidget {
  ToConvertCurrencyCard(
      {this.currencyName,
      this.currencyValue,
      this.currencySymbol,
      this.currencyCode,
      this.imgName,
      this.baseCurrencyCode,
      this.enteredSum});

  final String currencyName;
  final String currencyValue;
  final String currencySymbol;
  final String imgName;
  final String baseCurrencyCode;
  final String currencyCode;
  final String enteredSum;

  @override
  _ToConvertCurrencyCardState createState() => _ToConvertCurrencyCardState();
}

class _ToConvertCurrencyCardState extends State<ToConvertCurrencyCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kPadding,
      child: Stack(alignment: AlignmentDirectional.center, children: <Widget>[
        Container(
          padding: EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 3.0,
                      ),
                      Material(
                        elevation: 10.0,
                        child: Image(
                          fit: BoxFit.fill,
                          image: AssetImage(
                              kPathToImages + widget.imgName),
                          height: 35.0,
                          width: 60.0,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Text(
                          widget.currencyName,
                          style: prefs.getMainTextStyle(),
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: prefs.getThemeAccentColor(),
                        borderRadius: BorderRadius.all(
                          kBorderRadius,
                        ),
                      ),
                      child: Text(
                        getCurrencyValueWithFixedLength(widget.currencyValue,
                            widget.enteredSum, widget.currencySymbol),
                        style: TextStyle(
                          fontSize: 17.0,
                          color: prefs.getMainThemeColor(),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                    Text(
                      "1 ${widget.baseCurrencyCode} = ${double.tryParse(widget.currencyValue).toStringAsFixed(2)} ${widget.currencyCode}",
                      style: prefs.getMainTextStyle().copyWith(fontSize: 12.0),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 55.0,
          decoration: BoxDecoration(
            border: Border.all(color: prefs.getThemeAccentColor()),
            borderRadius: BorderRadius.all(kBorderRadius),
          ),
        ),
      ]),
    );
  }

  String getCurrencyValueWithFixedLength(
      String currencyValue, String enteredSum, String currencySymbol) {
    double doubleValue =
        (double.tryParse(currencyValue) * (double.tryParse(enteredSum) ?? 1));
    String retValue;
    if (doubleValue > 1000000000000) {
      retValue =
          (doubleValue / 1000000000000).toStringAsFixed(2) + " трлн $currencySymbol";
    }
    else if (doubleValue > 1000000000) {
      retValue =
          (doubleValue / 1000000000).toStringAsFixed(2) + " млрд $currencySymbol";
    } else if (doubleValue > 1000000) {
      retValue =
          (doubleValue / 1000000).toStringAsFixed(2) + " млн $currencySymbol";
    } else if (doubleValue > 100000) {
      retValue =
          (doubleValue / 1000).toStringAsFixed(2) + " тыс $currencySymbol";
    } else {
      retValue = doubleValue.toStringAsFixed(2) + " $currencySymbol";
    }
    return retValue;
  }
}
