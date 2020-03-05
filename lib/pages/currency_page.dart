import 'package:flutter/material.dart';
import 'package:my_travel_wallet/data/main_data.dart';
import 'package:my_travel_wallet/utilities/currencies.dart';
import 'package:my_travel_wallet/widgets/currency_card.dart';
import 'package:my_travel_wallet/widgets/currency_search_view.dart';
import 'package:my_travel_wallet/widgets/text_input_field.dart';

class CurrencyPage extends StatefulWidget {
  CurrencyPage({this.key});
  final Key key;

  @override
  _CurrencyPageState createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: prefs.getSecondaryThemeColor(),
      appBar: AppBar(
        backgroundColor: prefs.getMainThemeColor(),
        title: Text(
          "Конвертер валют",
          style: prefs.getMainTextStyle(),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: prefs.getMainThemeColor(),
            height: 300.0,
            child: Column(
              children: <Widget>[
                CurrencyCard(
                  imgName: baseCurrencyCardData.getCurrencyImageName(),
                  currencyCode: baseCurrencyCardData.getCurrencyCode(),
                  currencyName: baseCurrencyCardData.getCurrencyName(),
                  currencySymbol: baseCurrencyCardData.getCurrencySymbol(),
                  onPressed: () {
                    showDialog(
                      context: context,
                      child: CurrencySearchView(),
                    ).then((valueFromDialog) {
                      baseCurrencyCardData.updateValues(
                        imageName:
                            currencies[currencyNameAndCode[valueFromDialog]]
                                ["img_name"],
                        currencyCode:
                            currencies[currencyNameAndCode[valueFromDialog]]
                                ["cur_code"],
                        currencyName:
                            currencies[currencyNameAndCode[valueFromDialog]]
                                ["cur_name"],
                        currencySymbol:
                            currencies[currencyNameAndCode[valueFromDialog]]
                                ["cur_symbol"],
                      );
                        setState(() {});
                    });
                  },
                ),
                TextInputField(
                  hintText: "Введите сумму",
                ),
                Text(
                  "Выберите валюту и введите сумму",
                  style: prefs.getMainTextStyle(),
                ),
                Row(),
              ],
            ),
          ),
          Divider(
            color: prefs.getThemeAccentColor(),
            height: 0.0,
          ),
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              Text("eeee"),
            ],
          ),
        ],
      ),
    );
  }
}
