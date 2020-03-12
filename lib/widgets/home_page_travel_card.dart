import 'package:flutter/material.dart';
import 'package:my_travel_wallet/data/main_data.dart';
import 'package:my_travel_wallet/widgets/small_button.dart';
import 'package:my_travel_wallet/widgets/travel_page_detail.dart';

import '../constants.dart';

class HomePageTravelCard extends StatefulWidget {
  HomePageTravelCard(
      {this.travelName,
      this.travelDates,
      this.travelAmount,
      this.travelCurrencyCode,
      @required this.arguments});

  final String travelName;
  final String travelDates;
  final String travelAmount;
  final String travelCurrencyCode;
  final Map arguments;

  @override
  _HomePageTravelCardState createState() => _HomePageTravelCardState();
}

class _HomePageTravelCardState extends State<HomePageTravelCard> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.all(0.0),
      onPressed: () => Navigator.of(context)
          .pushNamed(TravelPageDetail.id, arguments: widget.arguments),
      child: Padding(
        padding: kPadding,
        child: Container(
          padding: kPadding,
//        height: 100.0,
          decoration: BoxDecoration(
            color: prefs.getMainThemeColor(),
            borderRadius: BorderRadius.all(
              kBorderRadius,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      widget.travelName,
                      overflow: TextOverflow.ellipsis,
                      style: prefs.getMainTextStyle().copyWith(fontSize: 20.0),
                    ),
                  ),
                  Text(
                    widget.travelDates,
                    style: prefs.getMainTextStyle(),
                  ),
                ],
              ),
              Divider(
                color: prefs.getThemeAccentColor(),
              ),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(kBorderRadius),
                            color: prefs.getThemeAccentColor(),
                          ),
                          child: Text(
                            "${widget.travelAmount} ${widget.travelCurrencyCode}",
                            style: prefs.getMainTextStyle().copyWith(
                                  fontSize: 18.0,
                                ),
                          ),
                        ),
                        Text(
                          "Итого",
                          style:
                              prefs.getMainTextStyle().copyWith(fontSize: 15.0),
                        ),
                      ],
                    ),
                    SmallButton(
                      buttonTitle: "Добавить расход",
                      onPressed: () => print("Home Page small button"),
                      height: 40.0,
                    ),
                  ])
            ],
          ),
        ),
      ),
    );
  }
}
