import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_travel_wallet/data/main_data.dart';
import 'package:my_travel_wallet/utilities/currencies.dart';
import 'package:my_travel_wallet/widgets/base_currency_card.dart';
import 'package:my_travel_wallet/widgets/currency_search_view.dart';
import 'package:my_travel_wallet/widgets/submit_button.dart';
import 'package:my_travel_wallet/widgets/text_input_field.dart';
import 'package:my_travel_wallet/utilities/api.dart';
import 'package:my_travel_wallet/widgets/to_convert_currency_card.dart';

class CurrencyPage extends StatefulWidget {
  CurrencyPage({this.key});
  final Key key;

  @override
  _CurrencyPageState createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  List<BaseCurrencyCard> listItems = [];

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
//            height: 300.0,
            child: Column(
              children: <Widget>[
                BaseCurrencyCard(
                  imgName: baseCurrencyCardData.getCurrencyImageName(),
                  currencyCode: baseCurrencyCardData.getCurrencyCode(),
                  currencyName: baseCurrencyCardData.getCurrencyName(),
                  currencySymbol: baseCurrencyCardData.getCurrencySymbol(),
                  onPressed: () {
                    showDialog(
                      context: context,
                      child: CurrencySearchView(),
                    ).then((valueFromDialog) {
                      if (valueFromDialog != null) {
                        // Обновляем базовую валюту
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
                        // Обновляем список текущих валют на экране при смене базовой валюты. Оставляеи только доступные для конвертации валюты.
                        // Например: если у пользователя на экране валюты USD, EUR и RUB, и пользователь меняет базовую валюту на NZD(новозеландский доллар)
                        // то USD и EUR будут удалены, так как API сервис позволяет конвертировать из NZD ТОЛЬКО в RUB.
                        currencyPageDataBox.toMap().forEach((key, value) {
                          if (!currencies[baseCurrencyCardData
                                  .getCurrencyCode()]["allowable_cur_list"]
                              .contains(value["currencyCode"]))
                            currencyPageDataBox.delete(key);
                        });
                        setState(() {});
                      }
                    });
                  },
                ),
                TextInputField(
                  keyboardType: TextInputType.numberWithOptions(),
                  hintText: "Введите сумму",
                ),
                SubmitButton(
                  buttonTitle: "Конвертировать",
                  onPressed: () {
                    List<String> toCurrency = [];
                    currencyPageDataBox.values.forEach((e) {
                      toCurrency.add(e["currencyCode"]);
                    });
//                    print(toCurrency);
                    ApiData().updateApiData(
                        baseCurrencyCardData.getCurrencyCode(), toCurrency);
                  },
                )
              ],
            ),
          ),
          Divider(
            color: prefs.getThemeAccentColor(),
            height: 0.0,
          ),
          Expanded(
              child: ValueListenableBuilder(
            valueListenable: currencyPageDataBox.listenable(),
            builder: (context, currencyPageDataBox, widget) {
              return ListView.builder(
                itemCount: currencyPageDataBox.length,
                itemBuilder: (context, index) {
                  List<dynamic> keys = currencyPageDataBox.keys.toList();
                  return Dismissible(
                    background: stackBehindDismiss(),
                    key: ObjectKey(currencyPageDataBox.get(keys[index])),
                    child: Container(
//                    padding: EdgeInsets.all(20.0),
                      child: ToConvertCurrencyCard(
                        currencyName: currencies[currencyPageDataBox
                            .get(keys[index])["currencyCode"]]["cur_name"],
                        currencySymbol: currencies[currencyPageDataBox
                            .get(keys[index])["currencyCode"]]["cur_symbol"],
                        imgName: currencies[currencyPageDataBox
                            .get(keys[index])["currencyCode"]]["img_name"],
                        currencyValue: currencyPageDataBox.get(keys[index])["currencyValue"],
                      )
//                      BaseCurrencyCard(
//                        imgName: currencies[currencyPageDataBox
//                            .get(keys[index])["currencyCode"]]["img_name"],
//                        currencyName: currencies[currencyPageDataBox
//                            .get(keys[index])["currencyCode"]]["cur_name"],
//                        currencyCode: currencies[currencyPageDataBox
//                            .get(keys[index])["currencyCode"]]["cur_code"],
//                        currencySymbol: currencies[currencyPageDataBox
//                            .get(keys[index])["currencyCode"]]["cur_symbol"],
//                        currencyValue: currencyPageDataBox.get(keys[index])["currencyValue"],
//                        onPressed: () {},
//                      ),
//                        currencyPageDataBox.get(index),
                    ),
                    onDismissed: (direction) {
                      var item = {
                        "addTime": DateTime.now(),
                        "currencyCode": currencies[currencyPageDataBox
                            .get(keys[index])["currencyCode"]]["cur_code"],
                        "currencyValue": ""
                      };
                      //To show a snackbar with the UNDO button
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              "Валюта ${currencies[currencyPageDataBox.get(keys[index])["currencyCode"]]["cur_code"]} удалена"),
                          action: SnackBarAction(
                            label: "Отменить",
                            onPressed: () {
                              //To undo deletion
                              undoDeletion(keys[index], item);
                            },
                          ),
                        ),
                      );
                      //To delete
                      deleteItem(keys[index]);
                    },
                  );
                },
              );
            },
          )),
          SubmitButton(
            buttonTitle: "Добавить валюту",
            onPressed: () {
//              Hive.deleteFromDisk();
              showDialog(
                context: context,
                child: CurrencySearchView(
                  additionalFilter:
                      currencies[baseCurrencyCardData.getCurrencyCode()]
                          ["allowable_cur_list"],
                ),
              ).then(
                (valueFromDialog) {
                  // Проверка на наличие валюты в списке валют на экране пользователя.
                  // Если валюта уже есть, она добавлена не будет. Будет показан снэк бар с соответствующим сообщением
                  bool canAdd = true;
                  if (valueFromDialog != null) {
                    currencyPageDataBox.values.forEach((e) {
                      if (e["currencyCode"] ==
                          currencies[currencyNameAndCode[valueFromDialog]]
                              ["cur_code"]) {
                        canAdd = false;
                      }
                    });
                    canAdd
                        ? currencyPageDataBox.add(
                            {
                              "addTime": DateTime.now(),
                              "currencyCode": currencies[
                                      currencyNameAndCode[valueFromDialog]]
                                  ["cur_code"],
                              "currencyValue": ""
                            },
                          )
                        : Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "Валюта ${currencies[currencyNameAndCode[valueFromDialog]]['cur_code']} уже добавлена"),
                            ),
                          );
                  }
                },
              );
            },
          )
        ],
      ),
    );
  }

  void deleteItem(index) {
    /*
    By implementing this method, it ensures that upon being dismissed from our widget tree,
    the item is removed from our list of items and our list is updated, hence
    preventing the "Dismissed widget still in widget tree error" when we reload.
    */
    currencyPageDataBox.delete(index);
//    setState(() {
//      listItems.removeAt(index);
//    });
  }

  void undoDeletion(index, item) {
    /*
    This method accepts the parameters index and item and re-inserts the {item} at
    index {index}
    */
    currencyPageDataBox.put(index, item);
//    setState(() {
//      listItems.insert(index, item);
//    });
  }

  Widget stackBehindDismiss() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      color: prefs.getThemeAccentColor(),
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }
}
