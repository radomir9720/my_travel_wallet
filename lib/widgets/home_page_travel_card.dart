import 'package:flutter/material.dart';
import 'package:my_travel_wallet/data/main_data.dart';
import 'package:my_travel_wallet/functions/get_currency_value_with_fixed_length.dart';
import 'package:my_travel_wallet/utilities/currencies.dart';
import 'package:my_travel_wallet/widgets/round_country_flag_image.dart';
import 'package:my_travel_wallet/widgets/small_button.dart';
import 'package:my_travel_wallet/widgets/travel_page_detail.dart';

import '../constants.dart';
import '../pages/home_page/add_new_expense_view.dart';

class HomePageTravelCard extends StatefulWidget {
  HomePageTravelCard(
      {this.travelName,
      this.travelDates,
      this.travelAmount,
      this.travelCurrencySymbol,
      this.baseCurrencyCode,
      this.toConvertCurrencyCode,
      @required this.arguments});

  final String travelName;
  final String travelDates;
  final String travelAmount;
  final String travelCurrencySymbol;
  final String baseCurrencyCode;
  final String toConvertCurrencyCode;
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
        child: Material(
          elevation: kElevationDouble,
          borderRadius: BorderRadius.all(kBorderRadius),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        widget.travelName,
                        overflow: TextOverflow.ellipsis,
                        style:
                            prefs.getMainTextStyle().copyWith(fontSize: 22.0),
                      ),
                    ),
                    Stack(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: RoundCountryFlagImage(
                            imageName: currencies[widget.toConvertCurrencyCode]
                                ["img_name"],
                            imageSize: 35.0,
                          ),
                        ),
                        RoundCountryFlagImage(
                          imageName: currencies[widget.baseCurrencyCode]
                              ["img_name"],
                          imageSize: 35.0,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 19.0, top: 6.0),
                          child: Material(
                            elevation: kElevationDouble,
                            borderRadius:
                                BorderRadius.all(Radius.circular(100.0)),
                            child: Container(
                                padding: EdgeInsets.all(kPaddingDouble / 2),
                                decoration: BoxDecoration(
                                    color: prefs.getThemeAccentColor(),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(100.0))),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 13.0,
                                )),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Text(
                  widget.travelDates,
                  style: prefs.getMainTextStyle().copyWith(fontSize: 12.0),
                ),
                Divider(
                  color: prefs.getThemeAccentColor(),
                ),
                Row(
//                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(kPaddingDouble / 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(kBorderRadius),
                              color: prefs.getThemeAccentColor(),
                            ),
                            child: Text(
                              getCurrencyValueWithFixedLength(
                                  double.tryParse(widget.travelAmount),
                                  widget.travelCurrencySymbol),
                              style: prefs.getMainTextStyle().copyWith(
                                    fontSize: 18.0,
                                  ),
                            ),
                          ),
                          Text(
                            "Итого",
                            style: prefs
                                .getMainTextStyle()
                                .copyWith(fontSize: 15.0),
                          ),
                        ],
                      ),
                      SmallButton(
                        buttonTitle: "Добавить расход",
                        onPressed: () {
//                        print(widget.arguments);
                          showDialog(
                            context: context,
                            child: Scaffold(
                              backgroundColor: Colors.black.withOpacity(0.1),
                              body: AddNewExpenseView(
                                defaultBaseCurrency: widget.arguments.values
                                    .first["defaultExpensesCurrencyCode"],
                                travelCardKey: widget.arguments.keys.first,
                                toConvertCurrencyCode: widget.arguments.values
                                    .first["toConvertCurrencyCode"],
                              ),
                            ),
                          );
                        },
                        height: 46.0,
                      ),
                    ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
