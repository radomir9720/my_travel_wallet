import 'package:flutter/material.dart';
import 'package:my_travel_wallet/data/main_data.dart';

import '../constants.dart';

class HomePageTravelCard extends StatefulWidget {
  HomePageTravelCard({this.travelName, this.travelDates, this.travelAmount, this.travelCurrencyCode});

  final String travelName;
  final String travelDates;
  final String travelAmount;
  final String travelCurrencyCode;

  @override
  _HomePageTravelCardState createState() => _HomePageTravelCardState();
}

class _HomePageTravelCardState extends State<HomePageTravelCard> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.all(0.0),
      onPressed: () {
        print("All button");
      },
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
                  Text(
                    "Ямайка",
                    style: prefs.getMainTextStyle().copyWith(fontSize: 20.0),
                  ),
                  Text(
                    "10 мар 2020 - 25 мар 2020",
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
                          "123123.21 руб",
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
                  MaterialButton(
                      onPressed: () {
                        print("part");
                      },
                      height: 40.0,
                      child: Text(
                        "Добавить расход",
                        style: prefs.getMainTextStyle(),
                      ),
                      color: prefs.getThemeAccentColor())
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
