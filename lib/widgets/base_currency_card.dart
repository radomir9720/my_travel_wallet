import 'package:flutter/material.dart';
import 'package:my_travel_wallet/constants.dart';
import 'package:my_travel_wallet/data/main_data.dart';
import 'package:my_travel_wallet/widgets/round_country_flag_image.dart';

class BaseCurrencyCard extends StatefulWidget {
  BaseCurrencyCard({
    this.imgName,
    this.currencyCode,
    this.currencyName,
    this.currencySymbol,
    @required this.onPressed,
//    this.currencyValue,
  });

  final String imgName;
  final String currencyCode;
  final String currencyName;
  final String currencySymbol;
  final Function onPressed;
//  final String currencyValue;

  @override
  _BaseCurrencyCardState createState() => _BaseCurrencyCardState();
}

class _BaseCurrencyCardState extends State<BaseCurrencyCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kPadding,
      child: Material(
        elevation: kElevationDouble,
        child: Stack(alignment: AlignmentDirectional.center, children: <Widget>[
          Container(
            padding: EdgeInsets.all(5.0),
            color: prefs.getMainThemeColor(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
//              SizedBox(width: 2.0,),
                Padding(
                  padding: EdgeInsets.only(left: 4.0),
                  child: RoundCountryFlagImage(
                    imageName: widget.imgName,
                    imageSize: 50.0,
                  ),
                ),
//              Material(
//                elevation: 10.0,
//                child: Image(
//                  fit: BoxFit.fill,
//                  image: AssetImage(kPathToImages + widget.imgName),
//                  height: 35.0,
//                  width: 60.0,
//                ),
//              ),
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
                Icon(
                  Icons.keyboard_arrow_down,
                  color: prefs.getThemeAccentColor(),
                )
              ],
            ),
          ),
          MaterialButton(
            minWidth: double.infinity,
            height: 60.0,
            onPressed: () => widget.onPressed(),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kBorderRadiusDouble),
                side: BorderSide(color: prefs.getThemeAccentColor(), width: kBorderWidth)),
          ),
        ]),
      ),
    );
  }
}
