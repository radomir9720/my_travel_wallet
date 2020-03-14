import 'package:flutter/material.dart';
import 'package:my_travel_wallet/constants.dart';
import 'package:my_travel_wallet/data/main_data.dart';
import 'package:my_travel_wallet/pages/home_page/functions/updateTravelCardExpensesAmount.dart';
import 'package:my_travel_wallet/utilities/currencies.dart';
import 'package:my_travel_wallet/pages/home_page/add_new_expense_view.dart';
import 'package:my_travel_wallet/widgets/dialog_window.dart';
import 'package:my_travel_wallet/widgets/stack_behind_dismiss.dart';
import 'package:my_travel_wallet/widgets/submit_button.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_travel_wallet/widgets/title_text_widget.dart';

class TravelPageDetail extends StatefulWidget {
  static String id = 'travelPageDetail';

  @override
  _TravelPageDetailState createState() => _TravelPageDetailState();
}

class _TravelPageDetailState extends State<TravelPageDetail> {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: prefs.getThirdThemeColor(),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.delete,
                color: prefs.getThirdThemeColor(),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  child: DialogWindow(
                    positiveButtonText: "Да",
                    positiveButtonFunction: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      deleteCurrentTravelCard(arguments.keys.first);
                    },
                    negativeButtonText: "Нет",
                    negativeButtonFunction: () => Navigator.of(context).pop(),
                    mainText: "Вы точно хотите удалить это путешествие?",
                    detailText: "Вернуть эти данные не будет возможности",
                  ),
                );
              }),
        ],
        title: Text(
          arguments.values.first["travelName"],
          style: prefs.getMainTextStyle(),
        ),
        backgroundColor: prefs.getMainThemeColor(),
      ),
      body: Container(
        padding: EdgeInsets.only(top: kPaddingDouble),
        color: prefs.getSecondaryThemeColor(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: ValueListenableBuilder(
                valueListenable: currencyPageDataBox.listenable(),
                builder: (context, currencyPageDataBox, widget) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: getTravelCardData(arguments.keys.first).length,
                    itemBuilder: (context, index) {
                      List<dynamic> keys = currencyPageDataBox
                          .get(kHomePageTravelExpensesKey)[arguments.keys.first]
                          .keys
                          .toList()
                            ..sort();
                      keys = keys.reversed.toList();
                      Map<dynamic, dynamic> expensesMap =
                          currencyPageDataBox.get(kHomePageTravelExpensesKey)[
                              arguments.keys.first][keys[index]];
                      return Column(
                        children: <Widget>[
                          (index == 0 ||
                                  expensesMap["expenseDate"] !=
                                      currencyPageDataBox.get(
                                                  kHomePageTravelExpensesKey)[
                                              arguments.keys.first]
                                          [keys[index - 1]]["expenseDate"])
                              ? Container(
                                  padding: EdgeInsets.all(kPaddingDouble / 2),
                                  child: Text(
                                    expensesMap["expenseDate"],
                                    style: prefs.getMainTextStyle(),
                                  ),
                                  decoration: BoxDecoration(
                                    color: prefs.getThemeAccentColor(),
                                    borderRadius:
                                        BorderRadius.all(kBorderRadius),
                                  ),
                                )
                              : SizedBox(),
                          Dismissible(
                            background: stackBehindDismiss(),
                            key: ObjectKey(keys[index]),
                            child: Padding(
                              padding: kPadding,
                              child: Material(
                                borderRadius: BorderRadius.all(kBorderRadius),
                                elevation: 10.0,
                                child: Container(
//                          height: 100.0,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(kBorderRadius),
                                    color: prefs.getMainThemeColor(),
                                  ),
                                  child: Padding(
                                    padding: kPadding,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Stack(
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 25.0),
                                                  child: Material(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(100.0),
                                                    ),
                                                    elevation: 10.0,
                                                    child: ClipRRect(
                                                      child: Image(
                                                        height: 40.0,
                                                        width: 40.0,
                                                        fit: BoxFit.fitHeight,
                                                        image: AssetImage(kPathToImages +
                                                            currencies[arguments
                                                                        .values
                                                                        .first[
                                                                    "toConvertCurrencyCode"]]
                                                                ["img_name"]),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(100.0),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Material(
                                                  elevation: 10.0,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              100.0)),
                                                  child: ClipRRect(
                                                    child: Image(
                                                      height: 40.0,
                                                      width: 40.0,
                                                      fit: BoxFit.fitHeight,
                                                      image: AssetImage(
                                                        kPathToImages +
                                                            currencies[expensesMap[
                                                                    "expenseCurrency"]]
                                                                ["img_name"],
                                                      ),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                100.0)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 7, top: 24.0),
                                                  child: Material(
                                                    elevation: 10.0,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                100.0)),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: prefs
                                                              .getThemeAccentColor(),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      100.0))),
                                                      child: Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        color: prefs
                                                            .getThirdThemeColor(),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 5.0,
                                            ),
                                            TitleText(
                                                text:
                                                    expensesMap["expenseName"]),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: <Widget>[
                                            TitleText(
                                                text:
                                                    "${expensesMap["expenseSum"]} ${currencies[expensesMap["expenseCurrency"]]["cur_symbol"]}"),
                                            TitleText(
                                                text:
                                                    "${expensesMap["convertedExpenseSum"]} ${currencies[arguments.values.first["toConvertCurrencyCode"]]["cur_symbol"]}"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            onDismissed: (direction) {
                              var item = expensesMap;
                              //To show a snackbar with the UNDO button
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "Расход ${expensesMap["expenseName"]} удален"),
                                  action: SnackBarAction(
                                    label: "Отменить",
                                    onPressed: () {
                                      //To undo deletion
                                      addItem(
                                          arguments.keys.first, keys[index], item);
                                    },
                                  ),
                                ),
                              );
                              //To delete
                              deleteItem(arguments.keys.first, keys[index]);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  color: prefs.getThemeAccentColor(),
                  height: 1.0,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: kPaddingDouble, right: kPaddingDouble),
                  child: Row(
                    children: <Widget>[
                      TitleText(text: "Итого:"),
                      TitleText(
                          text:
                              "${getExpensesAmount(getExpensesMap(arguments.keys.first))} "
                              "${currencies[arguments.values.first["toConvertCurrencyCode"]]["cur_symbol"]}")
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
                SubmitButton(
                  buttonTitle: "Добавить расход",
                  onPressed: () {
                    showDialog(
                      context: context,
                      child: Scaffold(
                        backgroundColor: Colors.black.withOpacity(0.1),
                        body: AddNewExpenseView(
                          defaultBaseCurrency: arguments
                              .values.first["defaultExpensesCurrencyCode"],
                          travelCardKey: arguments.keys.first,
                          toConvertCurrencyCode:
                              arguments.values.first["toConvertCurrencyCode"],
                        ),
                      ),
                    ).then((value) {
                      // setState для обновления суммы в "Итого".
                      setState(() {});
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Map<dynamic, dynamic> getTravelCardData(int key) {
    Map retMap = Map();
    try {
      retMap = currencyPageDataBox.get(kHomePageTravelExpensesKey)[key];
    } catch (e) {
      retMap = {};
    }
    return retMap ?? {};
  }

  Map<dynamic, dynamic> getExpensesMap(int travelCardKey) {
    try {
      return currencyPageDataBox.get(kHomePageTravelExpensesKey)[travelCardKey];
    } catch (e) {
      return {};
    }
  }

  String getExpensesAmount(Map expenses) {
    double _expensesAmount = 0;
    (expenses ?? {}).forEach((key, value) {
      _expensesAmount += double.parse(value["convertedExpenseSum"]);
    });
    return _expensesAmount.toStringAsFixed(2);
  }

  void deleteCurrentTravelCard(int currentTravelCardKey) {
    // Удаляем саму карточку
    Map<dynamic, dynamic> tempMap =
        currencyPageDataBox.get(kHomePageTravelCardKey);
    tempMap.remove(currentTravelCardKey);
    currencyPageDataBox.put(kHomePageTravelCardKey, tempMap);
    // Удаляем расходы по этой карточке
    tempMap = currencyPageDataBox.get(kHomePageTravelExpensesKey);
    tempMap.remove(currentTravelCardKey);
    currencyPageDataBox.put(kHomePageTravelExpensesKey, tempMap);
  }

  void deleteItem(int travelKey, int expenseKey) {
    /*
    By implementing this method, it ensures that upon being dismissed from our widget tree,
    the item is removed from our list of items and our list is updated, hence
    preventing the "Dismissed widget still in widget tree error" when we reload.
    */

    Map<dynamic, dynamic> tempMap =
        currencyPageDataBox.get(kHomePageTravelExpensesKey);
    Map<dynamic, dynamic> expenseTempMap = tempMap[travelKey];
    expenseTempMap.remove(expenseKey);
    tempMap[travelKey] = expenseTempMap;
    currencyPageDataBox.put(kHomePageTravelExpensesKey, tempMap);
    updateExpensesAmount(travelKey);
    setState(() {});
  }

  void addItem(int travelKey, int expenseKey, item) {
    /*
    This method accepts the parameters index and item and re-inserts the {item} at
    index {index}
    */
    Map<dynamic, dynamic> tempMap =
        currencyPageDataBox.get(kHomePageTravelExpensesKey);
    Map<dynamic, dynamic> expenseTempMap = tempMap[travelKey];
    expenseTempMap[expenseKey] = item;
    tempMap[travelKey] = expenseTempMap;
    currencyPageDataBox.put(kHomePageTravelExpensesKey, tempMap);
    updateExpensesAmount(travelKey);
    setState(() {});
  }

}
