import 'package:flutter/material.dart';
import 'package:my_travel_wallet/data/main_data.dart';
import 'package:my_travel_wallet/widgets/currency_search_card.dart';
import 'package:my_travel_wallet/widgets/text_input_field.dart';

class CurrencySearchView extends StatefulWidget {
  CurrencySearchView({this.additionalFilter});

  final List<String> additionalFilter;

  @override
  _CurrencySearchViewState createState() => _CurrencySearchViewState();
}

class _CurrencySearchViewState extends State<CurrencySearchView> {
  List<String> currencyListFilter = [];
  List<String> firstListFilter = [];
  TextEditingController _textEditingController = TextEditingController();
  Widget content = Center(
    child: CircularProgressIndicator(),
  );
  @override
  void initState() {
    super.initState();
    firstListFilter = widget.additionalFilter != null
        ? currencyListInit
            .where(
                (e) => widget.additionalFilter.contains(currencyNameAndCode[e]))
            .toList()
        : currencyListInit;
    _textEditingController.addListener(() {
      setState(() {
        currencyListFilter = firstListFilter
            .where(
              (e) => e
                  .toLowerCase()
                  .contains(_textEditingController.value.text.toLowerCase()),
            )
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.1),
        body: Column(
          children: <Widget>[
            Container(
              color: prefs.getMainThemeColor(),
              child: TextInputField(
                autoFocus: true,
                controller: _textEditingController,
                hintText: "Введите название валюты",
              ),
            ),
//            SizedBox(height: 15.0,),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: prefs.getMainThemeColor(),
                    borderRadius: BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                  ),
                  padding: EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: currencyListFilter.length,
                    itemBuilder: (context, position) {
                      return MaterialButton(
                        onPressed: () => Navigator.pop(
                            context, currencyListFilter[position]),
                        child: CurrencySearchResultCard(
                          title: currencyListFilter[position],
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
