import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_travel_wallet/constants.dart';
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
                  imgName:
                      currencyPageDataBox.get(kBaseCurrencyKey)["imageName"],
                  currencyCode:
                      currencyPageDataBox.get(kBaseCurrencyKey)["currencyCode"],
                  currencyName:
                      currencyPageDataBox.get(kBaseCurrencyKey)["currencyName"],
                  currencySymbol: currencyPageDataBox
                      .get(kBaseCurrencyKey)["currencySymbol"],
                  onPressed: () {
                    showDialog(
                      context: context,
                      child: CurrencySearchView(),
                    ).then((valueFromDialog) {
                      if (valueFromDialog != null) {
                        // Обновляем базовую валюту
                        currencyPageDataBox.put(kBaseCurrencyKey, {
                          "imageName":
                              currencies[currencyNameAndCode[valueFromDialog]]
                                  ["img_name"],
                          "currencyCode":
                              currencies[currencyNameAndCode[valueFromDialog]]
                                  ["cur_code"],
                          "currencyName":
                              currencies[currencyNameAndCode[valueFromDialog]]
                                  ["cur_name"],
                          "currencySymbol":
                              currencies[currencyNameAndCode[valueFromDialog]]
                                  ["cur_symbol"],
                        });
                        // Обновляем список текущих валют на экране при смене базовой валюты. Оставляеи только доступные для конвертации валюты.
                        // Например: если у пользователя на экране валюты USD, EUR и RUB, и пользователь меняет базовую валюту на NZD(новозеландский доллар)
                        // то USD и EUR будут удалены, так как API сервис позволяет конвертировать из NZD ТОЛЬКО в RUB.
                        Map<dynamic, dynamic> tempMap = currencyPageDataBox
                            .get(kCurrencyPageToConvertCardKey);
                        List<int> toRemove = [];
                        currencyPageDataBox
                            .get(kCurrencyPageToConvertCardKey)
                            .forEach((key, value) {
                          if (!currencies[currencyPageDataBox
                                      .get(kBaseCurrencyKey)["currencyCode"]]
                                  ["allowable_cur_list"]
                              .contains(value["currencyCode"])) {
                            toRemove.add(key);
                          }
                        });
                        tempMap.removeWhere((k, v) => toRemove.contains(k));
                        currencyPageDataBox.put(
                            kCurrencyPageToConvertCardKey, tempMap);
                        setState(() {});
                      }
                    });
                  },
                ),
                TextInputField(
                  keyboardType: TextInputType.numberWithOptions(),
                  hintText: "Введите сумму",
                ),
                Text(
                  "обновлено: " + "10 марта 18:50",
                  style: TextStyle(fontSize: 12.0, color: Colors.grey),
                ),
//                SubmitButton(
//                  buttonTitle: "Конвертировать",
//                  onPressed: () {
//                    List<String> toCurrency = [];
//                    currencyPageDataBox
//                        .get(kCurrencyPageToConvertCardKey)
//                        .values
//                        .forEach((e) {
//                      toCurrency.add(e["currencyCode"]);
//                    });
////                    print(toCurrency);
//                    ApiData().updateApiData(
//                        currencyPageDataBox
//                            .get(kBaseCurrencyKey)["currencyCode"],
//                        toCurrency);
//                  },
//                )
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
                  itemCount: currencyPageDataBox
                      .get(kCurrencyPageToConvertCardKey)
                      .length,
                  itemBuilder: (context, index) {
                    List<dynamic> keys = currencyPageDataBox
                        .get(kCurrencyPageToConvertCardKey)
                        .keys
                        .toList();
                    Map<dynamic, dynamic> toConvertMap = currencies[
                        currencyPageDataBox
                                .get(kCurrencyPageToConvertCardKey)[keys[index]]
                            ["currencyCode"]];
                    String imageName = toConvertMap["img_name"];
                    String currencyCode = toConvertMap["cur_code"];
                    String currencyName = toConvertMap["cur_name"];
                    String currencySymbol = toConvertMap["cur_symbol"];
                    return Dismissible(
                      background: stackBehindDismiss(),
                      key: ObjectKey(currencyPageDataBox
                          .get(kCurrencyPageToConvertCardKey)[keys[index]]),
                      child: Container(
                        child: ToConvertCurrencyCard(
                          currencyName: currencyName,
                          currencySymbol: currencySymbol,
                          imgName: imageName,
                          currencyValue:
                              getCurrencyValue(keys[index]).values.first,
                          updatedAt: getCurrencyValue(keys[index]).keys.first,
                        ),
                      ),
                      onDismissed: (direction) {
                        var item = {
                          "currencyCode": currencyCode,
                        };
                        //To show a snackbar with the UNDO button
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Валюта $currencyCode удалена"),
                            action: SnackBarAction(
                              label: "Отменить",
                              onPressed: () {
                                //To undo deletion
                                addItem(keys[index], item);
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
            ),
          ),
          SubmitButton(
            buttonTitle: "Добавить валюту",
            onPressed: () {
              showDialog(
                context: context,
                child: CurrencySearchView(
                  additionalFilter: currencies[currencyPageDataBox.get(
                      kBaseCurrencyKey)["currencyCode"]]["allowable_cur_list"],
                ),
              ).then(
                (valueFromDialog) {
                  // Проверка на наличие валюты в списке валют на экране пользователя.
                  // Если валюта уже есть, она добавлена не будет. Будет показан снэк бар с соответствующим сообщением
                  bool canAdd = true;
                  if (valueFromDialog != null) {
                    currencyPageDataBox
                        .get(kCurrencyPageToConvertCardKey)
                        .values
                        .forEach((e) {
                      if (e["currencyCode"] ==
                          currencies[currencyNameAndCode[valueFromDialog]]
                              ["cur_code"]) {
                        canAdd = false;
                      }
                    });
                    canAdd
                        ? addItem(
                            currencyPageDataBox
                                .get(kCurrencyPageToConvertCardKey)
                                .length,
                            {
                                "currencyCode": currencies[
                                        currencyNameAndCode[valueFromDialog]]
                                    ["cur_code"],
                              })
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

  Map<String, String> getCurrencyValue(index) {
    String updatedAt;
    String value;
    try {
      updatedAt = currencyPageDataBox.get(kCurrencyPageValueKey)[
          currencyPageDataBox.get(kBaseCurrencyKey)["currencyCode"] +
              currencies[
                  currencyPageDataBox.get(kCurrencyPageToConvertCardKey)[index]
                      ["currencyCode"]]["cur_code"]]["updated"];
      value = currencyPageDataBox.get(kCurrencyPageValueKey)[
          currencyPageDataBox.get(kBaseCurrencyKey)["currencyCode"] +
              currencies[
                  currencyPageDataBox.get(kCurrencyPageToConvertCardKey)[index]
                      ["currencyCode"]]["cur_code"]]["value"];
    } catch (e) {
      updatedAt = "";
      value = "";
    }
    return {updatedAt: value};
  }

  void deleteItem(index) {
    /*
    By implementing this method, it ensures that upon being dismissed from our widget tree,
    the item is removed from our list of items and our list is updated, hence
    preventing the "Dismissed widget still in widget tree error" when we reload.
    */
    Map<dynamic, dynamic> tempMap =
        currencyPageDataBox.get(kCurrencyPageToConvertCardKey);
    tempMap.remove(index);
    currencyPageDataBox.put(kCurrencyPageToConvertCardKey, tempMap);
//    setState(() {
//      listItems.removeAt(index);
//    });
  }

  void addItem(index, item) {
    /*
    This method accepts the parameters index and item and re-inserts the {item} at
    index {index}
    */
    Map<dynamic, dynamic> tempMap =
        currencyPageDataBox.get(kCurrencyPageToConvertCardKey);
    tempMap[index] = item;
    currencyPageDataBox.put(kCurrencyPageToConvertCardKey, tempMap);
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
