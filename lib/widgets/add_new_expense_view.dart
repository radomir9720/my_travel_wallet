import 'package:flutter/material.dart';
import 'package:my_travel_wallet/data/main_data.dart';
import 'package:my_travel_wallet/utilities/currencies.dart';
import 'package:my_travel_wallet/widgets/base_currency_card.dart';
import 'package:my_travel_wallet/widgets/currency_search_view.dart';
import 'package:my_travel_wallet/widgets/dialog_window.dart';
import 'package:my_travel_wallet/widgets/submit_button.dart';
import 'package:my_travel_wallet/widgets/text_input_field.dart';
import 'package:my_travel_wallet/widgets/title_text_widget.dart';

import '../constants.dart';
import 'date_picker_widget.dart';

class AddNewExpenseView extends StatefulWidget {
  AddNewExpenseView({
    @required this.defaultBaseCurrency,
    @required this.travelCardKey,
    @required this.toConvertCurrencyCode,
  });
  final String defaultBaseCurrency;
  final int travelCardKey;
  final String toConvertCurrencyCode;

  @override
  _AddNewExpenseViewState createState() => _AddNewExpenseViewState();
}

class _AddNewExpenseViewState extends State<AddNewExpenseView> {
  TextEditingController _datePickerController = TextEditingController();
  TextEditingController _expenseNameController = TextEditingController();
  TextEditingController _expenseSumController = TextEditingController();

  String _baseCurrency;
  bool _isValidExpenseSum = false;
  String _convertedExpenseValue = "";
  @override
  void initState() {
    _baseCurrency = widget.defaultBaseCurrency;
    _expenseSumController.addListener(() {
      _isValidExpenseSum =
          (double.tryParse(_expenseSumController.text) != null &&
              double.tryParse(_expenseSumController.text) >= 0);
      if (_isValidExpenseSum) {
        _convertedExpenseValue =
            ((double.tryParse(_expenseSumController.text) ?? 1) *
                    double.tryParse(currencyPageDataBox
                            .get(kCurrencyPageValueKey)[
                        _baseCurrency + widget.toConvertCurrencyCode]["value"]))
                .toStringAsFixed(2);
      }
      setState(() {});
    });
    _datePickerController.text = DateTime.now().toString().split(" ")[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//    print(currencyPageDataBox.get(kHomePageTravelExpensesKey) ?? {}[widget.travelCardKey]);
    return Padding(
      padding: kPadding,
      child: Container(
        padding: kPadding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(kBorderRadius),
          color: prefs.getMainThemeColor(),
        ),
        child: ListView(
          children: <Widget>[
            TitleText(
              text: "Название расхода:",
            ),
            TextInputField(
              autoFocus: true,
              controller: _expenseNameController,
              errorText:
                  "Поле заполнено неправильно. К-во символов не должно быть больше 40",
              checkIfIsValid: (controller) {
                return controller.text.length <= 40;
              },
              hintText: "Например: Билеты на самолет",
            ),
            Divider(
              color: prefs.getThemeAccentColor(),
            ),
            Row(
//              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  flex: 5,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TitleText(text: "Дата"),
                      DatePickerWidget(
                        controller: _datePickerController,
                        format: "yyyy-MM-dd",
                        hintText: "Введите дату",
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 5,
                  child: Column(
                    children: <Widget>[
                      TitleText(
                        text: "Cумма",
                      ),
                      TextInputField(
                        controller: _expenseSumController,
                        hintText: "Введите сумму",
                        checkIfIsValid: (controller) {
                          return ((double.tryParse(controller.text) != null &&
                                  double.tryParse(controller.text) >= 0) ||
                              controller.text == "");
                        },
                        errorText:
                            "Введите положительное число (может содержать точку)",
                        keyboardType: TextInputType.number,
                      )
                    ],
                  ),
                )
              ],
            ),
            Divider(
              color: prefs.getThemeAccentColor(),
            ),
            TitleText(text: "Валюта операции"),
            BaseCurrencyCard(
              onPressed: () => showDialog(
                context: context,
                child: CurrencySearchView(
                  additionalFilter: currencies[widget.toConvertCurrencyCode]
                      ["allowable_cur_list"],
                ),
              ).then(
                (valueFromDialog) {
                  if (valueFromDialog != null) {
                    _baseCurrency = currencyNameAndCode[valueFromDialog];
                    setState(() {});
                  }
                },
              ),
              imgName: currencies[_baseCurrency]["img_name"],
              currencyCode: currencies[_baseCurrency]["cur_code"],
              currencyName: currencies[_baseCurrency]["cur_name"],
              currencySymbol: currencies[_baseCurrency]["cur_symbol"],
            ),
            _isValidExpenseSum
                ? Padding(
                    padding: kPadding,
                    child: Text(
                      "Будет добавлен расход на сумму $_convertedExpenseValue ${currencies[widget.toConvertCurrencyCode]["cur_symbol"]}",
                      style: prefs.getMainTextStyle(),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  )
                : SizedBox(),
            Row(
//            mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  flex: 5,
                  child: SubmitButton(
                    buttonTitle: "Отмена",
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                Flexible(
                  flex: 5,
                  child: SubmitButton(
                    buttonTitle: "Добавить",
                    onPressed: () {
                      String errorText = "";
                      if (_datePickerController.text == "") {
                        errorText += " - Поле \"Дата\" должно быть заполнено.";
                      }
                      if (_expenseNameController.text == "" ||
                          _expenseNameController.text.length > 40) {
                        errorText +=
                            "\n - Поле \"Название расхода\" должно быть заполнено корректно. Оно должно содержать от 1 до 40 символов.";
                      }
                      if (!_isValidExpenseSum) {
                        errorText +=
                            "\n - Поле \"Сумма\" должно быть заполнено корректно. Введите положительное число (может содержать точку)";
                      }
                      if (errorText != "") {
                        showDialog(
                          context: context,
                          child: DialogWindow(
                            mainText: "Заполните корректно поля",
                            neutralButtonText: "Понятно",
                            neutralButtonFunction: () =>
                                Navigator.of(context).pop(),
                            detailText: errorText,
                          ),
                        );
                      } else {
                        addNewExpense();
                        updateExpensesAmount();
//                        print(currencyPageDataBox
//                            .get(kHomePageTravelExpensesKey));
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void addNewExpense() {
    Map<dynamic, dynamic> tempMap =
        (currencyPageDataBox.get(kHomePageTravelExpensesKey) ?? {});
    Map<dynamic, dynamic> travelDataTempMap =
        tempMap[widget.travelCardKey] ?? {};
    DateTime _expenseDate = DateTime.parse(_datePickerController.text);
    travelDataTempMap[_expenseDate
        .add(Duration(microseconds: DateTime.now().millisecondsSinceEpoch))
        .millisecondsSinceEpoch] = {
      "expenseName": _expenseNameController.text,
      "expenseDate":
          "${_expenseDate.day} ${months[_expenseDate.month]["short"]} ${_expenseDate.year}",
      "expenseSum": _expenseSumController.text,
      "expenseCurrency": _baseCurrency,
      "convertedExpenseSum": _convertedExpenseValue,
    };
    tempMap[widget.travelCardKey] = travelDataTempMap;
    currencyPageDataBox.put(kHomePageTravelExpensesKey, tempMap);
  }

  void updateExpensesAmount() {
    Map<dynamic, dynamic> generalTempMap =
        (currencyPageDataBox.get(kHomePageTravelCardKey));
    Map<dynamic, dynamic> tempMap = generalTempMap[widget.travelCardKey];
    double travelAmount = 0;
    (currencyPageDataBox.get(kHomePageTravelExpensesKey) ??
            {}[widget.travelCardKey])
        .forEach((key, value) {
      value.forEach((k, v) {
        travelAmount += double.parse(v["convertedExpenseSum"]);
      });
    });
    tempMap["expensesAmount"] = travelAmount;
    generalTempMap[widget.travelCardKey] = tempMap;
//    print(travelAmount);
//    print(generalTempMap);
//    tempMap[travlCardKey] = ;
  currencyPageDataBox.put(kHomePageTravelCardKey, generalTempMap);
  }
}
