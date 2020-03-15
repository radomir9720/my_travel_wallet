import 'package:flutter/material.dart';
import 'package:my_travel_wallet/data/main_data.dart';
import 'package:my_travel_wallet/widgets/round_country_flag_image.dart';
import 'package:my_travel_wallet/widgets/title_text_widget.dart';

import '../constants.dart';

class TravelExpensesCard extends StatelessWidget {
  TravelExpensesCard({
    this.expenseImageName,
    this.toConvertImageName,
    this.expenseName,
    this.expenseSum,
    this.expenseCurrency,
    this.convertedSum,
    this.convertedCurrency,
  });
  final String expenseImageName;
  final String toConvertImageName;
  final String expenseName;
  final String expenseSum;
  final String expenseCurrency;
  final String convertedSum;
  final String convertedCurrency;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Row(
              children: <Widget>[
                Flexible(
                  flex: 4,
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 25.0),
                        child: RoundCountryFlagImage(
                          imageName: expenseImageName,
                        )
                      ),
                      RoundCountryFlagImage(
                        imageName: toConvertImageName,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8, top: 24.0),
                        child: Material(
                          elevation: 10.0,
                          borderRadius: BorderRadius.all(Radius.circular(100.0)),
                          child: Container(
                            decoration: BoxDecoration(
                                color: prefs.getThemeAccentColor(),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100.0))),
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              color: prefs.getThirdThemeColor(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              SizedBox(
                width: 5.0,
              ),
                Flexible(flex: 10,child: TitleText(text: expenseName,center: false,)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TitleText(text: "$expenseSum $expenseCurrency"),
              TitleText(text: "$convertedSum $convertedCurrency"),
            ],
          ),
        ],
      ),
    );
  }
}
