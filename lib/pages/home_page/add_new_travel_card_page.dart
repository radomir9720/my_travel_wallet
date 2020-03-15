import 'package:flutter/material.dart';
import 'package:my_travel_wallet/constants.dart';
import 'package:my_travel_wallet/data/main_data.dart';
import 'package:my_travel_wallet/utilities/currencies.dart';
import 'package:my_travel_wallet/widgets/base_currency_card.dart';
import 'package:my_travel_wallet/widgets/currency_search_view.dart';
import 'package:my_travel_wallet/widgets/date_picker_widget.dart';
import 'package:my_travel_wallet/widgets/dialog_window.dart';
import 'package:my_travel_wallet/widgets/submit_button.dart';
import 'package:my_travel_wallet/widgets/text_input_field.dart';
import 'package:my_travel_wallet/widgets/title_text_widget.dart';

class AddNewTravelCardPage extends StatefulWidget {
  static String id = 'addNewTravelCard';

  @override
  _AddNewTravelCardPageState createState() => _AddNewTravelCardPageState();
}

class _AddNewTravelCardPageState extends State<AddNewTravelCardPage> {
  TextEditingController _travelNameController = TextEditingController();
  TextEditingController _dateFromController = TextEditingController();
  TextEditingController _dateToController = TextEditingController();
  String expensesCurrencyCode;
  String toConvertCurrencyCode;

  @override
  void initState() {
    expensesCurrencyCode = "USD";
    toConvertCurrencyCode = "RUB";
    _dateFromController.text = DateTime.now().toString().split(" ")[0];
    _dateToController.text =
        DateTime.now().add(Duration(days: 7)).toString().split(" ")[0];
    super.initState();
  }

  @override
  void dispose() {
    _travelNameController.dispose();
    _dateFromController.dispose();
    _dateToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20.0,
          ),
          onPressed: () => Navigator.of(context).pop(),
          color: prefs.getThirdThemeColor(),
        ),
        backgroundColor: prefs.getMainThemeColor(),
        title: Text(
          "Добавление путешествия",
          style: prefs.getMainTextStyle(),
        ),
      ),
      body: Container(
        width: double.infinity,
        color: prefs.getSecondaryThemeColor(),
        child: Padding(
          padding: kPadding,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(kBorderRadius),
              color: prefs.getMainThemeColor(),
            ),
            padding: kPadding,
            child: ListView(
//              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TitleText(text: "Куда собрались:"),
                TextInputField(
                  controller: _travelNameController,
                  checkIfIsValid: (controller) {
                    return controller.text.length <= 25;
                  },
                  errorText: "К-во символов должно быть не более 25.",
                  hintText: "Например: Ямайка :)",
                ),
                Divider(
                  color: prefs.getThemeAccentColor(),
                ),
                TitleText(
                  text: "Когда:",
                ),
                Row(
                  children: <Widget>[
                    DatePickerWidget(
                      controller: _dateFromController,
                      format: "yyyy-MM-dd",
                      hintText: "С какой даты",
                    ),
                    DatePickerWidget(
                      controller: _dateToController,
                      format: "yyyy-MM-dd",
                      hintText: "По какую дату",
                    ),
                  ],
                ),
                Divider(
                  color: prefs.getThemeAccentColor(),
                ),
                TitleText(
                  text: "Валюта расходов по умолчанию:",
                ),
                BaseCurrencyCard(
                  imgName: currencies[expensesCurrencyCode]["img_name"],
                  currencyName: currencies[expensesCurrencyCode]["cur_name"],
                  currencySymbol: currencies[expensesCurrencyCode]
                      ["cur_symbol"],
                  currencyCode: currencies[expensesCurrencyCode]["cur_code"],
                  onPressed: () {
                    showDialog(
                      context: context,
                      child: CurrencySearchView(
                        additionalFilter: currencies[toConvertCurrencyCode]
                            ["allowable_cur_list"],
                      ),
                    ).then(
                      (valueFromDialog) {
                        if (valueFromDialog != null) {
                          expensesCurrencyCode =
                              currencyNameAndCode[valueFromDialog];
                          setState(() {});
                        }
                      },
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TitleText(
                        text: "Валюта конвертации:",
                      ),
                      MaterialButton(
                        color: prefs.getSecondaryThemeColor(),
                        padding: EdgeInsets.all(0.0),
                        minWidth: 40.0,
                        height: 40.0,
                        elevation: kElevationDouble,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: prefs.getThemeAccentColor(),
                            ),
                            borderRadius: BorderRadius.circular(100.0)),
                        child: Icon(
                          Icons.import_export,
                          color: prefs.getThirdThemeColor(),
                        ),
                        onPressed: () {
                          String tempValue = expensesCurrencyCode;
                          expensesCurrencyCode = toConvertCurrencyCode;
                          toConvertCurrencyCode = tempValue;
                          setState(() {});
                        },
                      )
                    ],
                  ),
                ),
                BaseCurrencyCard(
                  imgName: currencies[toConvertCurrencyCode]["img_name"],
                  currencyName: currencies[toConvertCurrencyCode]["cur_name"],
                  currencySymbol: currencies[toConvertCurrencyCode]
                      ["cur_symbol"],
                  currencyCode: currencies[toConvertCurrencyCode]["cur_code"],
                  onPressed: () {
                    showDialog(
                      context: context,
                      child: CurrencySearchView(
                        additionalFilter: currencies[expensesCurrencyCode]
                            ["allowable_cur_list"],
                      ),
                    ).then(
                      (valueFromDialog) {
                        if (valueFromDialog != null) {
                          toConvertCurrencyCode =
                              currencyNameAndCode[valueFromDialog];
                          setState(() {});
                        }
                      },
                    );
                  },
                ),
                SubmitButton(
                  buttonTitle: "Добавить путешествие",
                  onPressed: () {
                    if (_travelNameController.text.length == 0 ||
                        _travelNameController.text.length > 25) {
                      showDialog(
                        context: context,
                        child: DialogWindow(
                          mainText: "Введите страну назначения!",
                          detailText:
                              "Поле с названием страны должно содержать от 1 до 25 символов",
                          neutralButtonText: "Понятно",
                          neutralButtonFunction: () =>
                              Navigator.of(context).pop(),
                        ),
                      );
                    } else {
                      DateTime dateFrom =
                          DateTime.parse(_dateFromController.text);
                      DateTime dateTo = DateTime.parse(_dateToController.text);
//                      print(months[dateFrom.month]["short"]);
                      Map<dynamic, dynamic> tempMap =
                          currencyPageDataBox.get(kHomePageTravelCardKey) ?? {};
                      tempMap[
                          DateTime.now().millisecondsSinceEpoch.toString()] = {
                        "travelName": _travelNameController.text.toString(),
                        "dateFrom":
                            "${dateFrom.day} ${months[dateFrom.month]["short"]} ${dateFrom.year}",
                        "dateTo":
                            "${dateTo.day} ${months[dateTo.month]["short"]} ${dateTo.year}",
                        "expensesAmount": 0,
                        "defaultExpensesCurrencyCode": expensesCurrencyCode,
                        "toConvertCurrencyCode": toConvertCurrencyCode,
                      };
                      currencyPageDataBox.put(kHomePageTravelCardKey, tempMap);
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
