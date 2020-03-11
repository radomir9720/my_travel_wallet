import 'package:flutter/material.dart';
import 'package:my_travel_wallet/data/main_data.dart';

class BaseCurrencyCard extends StatefulWidget {
  BaseCurrencyCard({
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
  _BaseCurrencyCardState createState() => _BaseCurrencyCardState();
}

class _BaseCurrencyCardState extends State<BaseCurrencyCard> {
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
              Material(
                elevation: 10.0,
                child: Image(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/flags/" + widget.imgName),
                  height: 35.0,
                width: 60.0,
                ),
              ),
              Text(
                widget.currencyCode,
                style: prefs.getMainTextStyle(),
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
              widget.currencyValue == null ? Text(widget.currencySymbol, style: prefs.getMainTextStyle()) : SizedBox(),
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
                        widget.currencyValue + (widget.currencySymbol == "" ? "" : " " + widget.currencySymbol),
                        style: TextStyle(
                            fontSize: 20.0, color: prefs.getMainThemeColor()),
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
