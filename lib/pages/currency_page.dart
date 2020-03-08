import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_travel_wallet/constants.dart';
import 'package:my_travel_wallet/data/main_data.dart';
import 'package:my_travel_wallet/utilities/currencies.dart';
import 'package:my_travel_wallet/widgets/currency_card.dart';
import 'package:my_travel_wallet/widgets/currency_search_view.dart';
import 'package:my_travel_wallet/widgets/submit_button.dart';
import 'package:my_travel_wallet/widgets/text_input_field.dart';

class CurrencyPage extends StatefulWidget {
  CurrencyPage({this.key});
  final Key key;

  @override
  _CurrencyPageState createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  List<CurrencyCard> listItems = [];

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
                      if (valueFromDialog != null) {
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
                      }
                    });
                  },
                ),
                TextInputField(
                  keyboardType: TextInputType.numberWithOptions(),
                  hintText: "Введите сумму",
                ),
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
                      child: CurrencyCard(
                        imgName: currencies[currencyPageDataBox
                                .get(keys[index])[kCurrencyPageDataKey]
                            ["currencyCode"]]["img_name"],
                        currencyName: currencies[currencyPageDataBox
                                .get(keys[index])[kCurrencyPageDataKey]
                            ["currencyCode"]]["cur_name"],
                        currencyCode: currencies[currencyPageDataBox
                                .get(keys[index])[kCurrencyPageDataKey]
                            ["currencyCode"]]["cur_code"],
                        currencySymbol: currencies[currencyPageDataBox
                                .get(keys[index])[kCurrencyPageDataKey]
                            ["currencyCode"]]["cur_symbol"],
                        currencyValue: "1.00",
                        onPressed: () {},
                      ),
//                        currencyPageDataBox.get(index),
                    ),
                    onDismissed: (direction) {
                      var item = {
                        kCurrencyPageDataKey: {
                          "addTime": DateTime.now(),
                          "currencyCode": currencies[currencyPageDataBox
                                  .get(keys[index])[kCurrencyPageDataKey]
                              ["currencyCode"]]["cur_code"],
                          "currencyValue": ""
                        }
                      };
                      //To delete
                      deleteItem(keys[index]);
                      //To show a snackbar with the UNDO button
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Валюта удалена"),
                          action: SnackBarAction(
                            label: "Отменить",
                            onPressed: () {
                              //To undo deletion
                              undoDeletion(keys[index], item);
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          )),
          SubmitButton(
            buttonTitle: "Добавить валюту",
            onPressed: () {
//              print(currencyPageDataBox.toMap());
//              print(currencyPageDataBox.get(0));
              showDialog(
                context: context,
                child: CurrencySearchView(),
              ).then(
                (valueFromDialog) {
                  if (valueFromDialog != null) {
                    currencyPageDataBox.add(
                      {
                        kCurrencyPageDataKey: {
                          "addTime": DateTime.now(),
                          "currencyCode":
                              currencies[currencyNameAndCode[valueFromDialog]]
                                  ["cur_code"],
                          "currencyValue": ""
                        }
                      },
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
