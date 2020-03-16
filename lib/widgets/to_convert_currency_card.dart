import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_travel_wallet/constants.dart';
import 'package:my_travel_wallet/data/main_data.dart';
import 'package:my_travel_wallet/functions/get_currency_value_with_fixed_length.dart';
import 'package:my_travel_wallet/widgets/round_country_flag_image.dart';

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
      padding: EdgeInsets.symmetric(
        horizontal: kPaddingDouble,
        vertical: kPaddingDouble / 2,
      ),
      child: Material(
        elevation: kElevationDouble / 2,
        borderRadius: BorderRadius.all(kBorderRadius),
        child: Stack(alignment: AlignmentDirectional.center, children: <Widget>[
          Container(
            padding: EdgeInsets.all(5.0),
            color: prefs.getMainThemeColor(),
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
                        RoundCountryFlagImage(
                          imageName: widget.imgName,
                          imageSize: 49.0,
                        ),
//                      Material(
//                        elevation: 10.0,
//                        child: Image(
//                          fit: BoxFit.fill,
//                          image: AssetImage(kPathToImages + widget.imgName),
//                          height: 35.0,
//                          width: 60.0,
//                        ),
//                      ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            widget.currencyName,
                            style: prefs
                                .getMainTextStyle()
                                .copyWith(fontSize: 16.0),
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
                          getCurrencyValueWithFixedLength(
                              getMultipliedValue(
                                  widget.currencyValue, widget.enteredSum),
                              widget.currencySymbol),
                          style:
                              prefs.getMainTextStyle().copyWith(fontSize: 17.0),
//                          TextStyle(
//                            fontSize: 17.0,
//                            color: prefs.getMainThemeColor(),
//                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        height: 2.0,
                      ),
                      Text(
                        "1 ${widget.baseCurrencyCode} = ${double.tryParse(widget.currencyValue)?.toStringAsFixed(2) ?? ""} ${widget.currencyCode}",
                        style:
                            prefs.getMainTextStyle().copyWith(fontSize: 12.0),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 60.0,
            decoration: BoxDecoration(
              border: Border.all(
                  color: prefs.getThemeAccentColor(), width: kBorderWidth),
              borderRadius: BorderRadius.all(kBorderRadius),
            ),
          ),
        ]),
      ),
    );
  }

  double getMultipliedValue(String enteredSum, String currencyValue) {
    return ((double.tryParse(currencyValue) ?? 1) *
        (double.tryParse(enteredSum) ?? 1));
  }

}
