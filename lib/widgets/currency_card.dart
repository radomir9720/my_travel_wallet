import 'package:flutter/material.dart';
import 'package:my_travel_wallet/data/main_data.dart';

class CurrencyCard extends StatefulWidget {
  CurrencyCard({
    this.imgName,
    this.currencyCode,
    this.currencyName,
    this.currencySymbol,
    this.onPressed,
    this.currencyValue,
  });

  final String imgName;
  final String currencyCode;
  final String currencyName;
  final String currencySymbol;
  final Function onPressed;
  final String currencyValue;

  @override
  _CurrencyCardState createState() => _CurrencyCardState();
}

class _CurrencyCardState extends State<CurrencyCard> {
//  double screenWidth;

  @override
  void initState() {
    // TODO: убрать этот костыль. Вынести ширину и высоту экрана в другое место. По хорошему - сохранить в кэше где-то, либо в БД.
    super.initState();
//    screenWidth = MediaQuery.of(context).size.width * 0.4;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(alignment: AlignmentDirectional.center, children: <Widget>[
        Container(
//        height: 100.0,
          padding: EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image(
                image: AssetImage("assets/images/flags/" + widget.imgName),
                height: 35.0,
                width: 60.0,
              ),
              Text(
                widget.currencyCode,
                style: prefs.getMainTextStyle(),
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
              Text(widget.currencySymbol, style: prefs.getMainTextStyle()),
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
                        widget.currencyValue,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: prefs.getMainThemeColor()
                        ),
                      )),
            ],
          ),
        ),
        MaterialButton(
          minWidth: double.infinity,
          height: 51.0,
          onPressed: () => widget.onPressed(),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: BorderSide(color: prefs.getThemeAccentColor())),
        ),
      ]),
    );
  }
}
