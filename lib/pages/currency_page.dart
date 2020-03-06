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
  List<CurrencyCard> listItems = [
    CurrencyCard(
      onPressed: () {},
      imgName: currencies["TZS"]["img_name"],
      currencyCode: currencies["TZS"]["cur_code"],
      currencyName: currencies["TZS"]["cur_name"],
      currencySymbol: currencies["TZS"]["cur_symbol"],
      currencyValue: "1.054",
    ),
    CurrencyCard(
      onPressed: () {},
      imgName: currencies["AZN"]["img_name"],
      currencyCode: currencies["AZN"]["cur_code"],
      currencyName: currencies["AZN"]["cur_name"],
      currencySymbol: currencies["AZN"]["cur_symbol"],
      currencyValue: "1.054",
    ),
  ];
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
//                Text(
//                  "Выберите валюту и введите сумму",
//                  style: prefs.getMainTextStyle(),
//                ),
              ],
            ),
          ),
          Divider(
            color: prefs.getThemeAccentColor(),
            height: 0.0,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: listItems.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  background: stackBehindDismiss(),
                  key: ObjectKey(listItems[index]),
                  child: Container(
//                    padding: EdgeInsets.all(20.0),
                    child: listItems[index],
                  ),
                  onDismissed: (direction) {
                    var item = listItems.elementAt(index);
                    //To delete
                    deleteItem(index);
                    //To show a snackbar with the UNDO button
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("Валюта удалена"),
                        action: SnackBarAction(
                            label: "Отменить",
                            onPressed: () {
                              //To undo deletion
                              undoDeletion(index, item);
                            })));
                  },
                );
              },
//    )),
//          ListView(
//            shrinkWrap: true,
//            children: <Widget>[
//              CurrencyCard(
//                imgName: currencies["TZS"]["img_name"],
//                currencyCode: currencies["TZS"]["cur_code"],
//                currencyName: currencies["TZS"]["cur_name"],
//                currencySymbol: currencies["TZS"]["cur_symbol"],
//              ),
//            ],
//          ),
            ),
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
    setState(() {
      listItems.removeAt(index);
    });
  }

  void undoDeletion(index, item) {
    /*
    This method accepts the parameters index and item and re-inserts the {item} at
    index {index}
    */
    setState(() {
      listItems.insert(index, item);
    });
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
