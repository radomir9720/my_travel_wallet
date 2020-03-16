import 'package:flutter/material.dart';
import 'package:my_travel_wallet/constants.dart';
import 'package:my_travel_wallet/data/main_data.dart';
import 'package:my_travel_wallet/utilities/currencies.dart';
import 'package:my_travel_wallet/utilities/google_auth.dart';
import 'package:my_travel_wallet/widgets/avatar_widget.dart';
import 'package:my_travel_wallet/widgets/dialog_window.dart';
import 'package:my_travel_wallet/widgets/home_page_travel_card.dart';
import 'package:my_travel_wallet/widgets/sign_in_button.dart';
import 'package:my_travel_wallet/widgets/submit_button.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'add_new_travel_card_page.dart';

class HomePage extends StatefulWidget {
  HomePage({this.key});

  final Key key;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget signInWidget;
  double width = 100.0;
  double height = 50.0;

  @override
  void initState() {
    // Если юзер залогинен показываем его аватарку, иначе - кнопку для входа
    signInWidget = (sessionWithConnection && prefs.getAuthorizedStatus())
//    (googleSignIn.currentUser?.id != null &&
//            googleSignIn.currentUser != null)
        ?
//    MaterialButton(
//            onPressed: () {
//              print(googleSignIn.currentUser);
//              print(googleSignIn.currentUser.id);
//            print(prefs.getAuthorizedStatus());
//              },
//            child: Text("1234"),
//          )
        AvatarWidget(
            imageUrl: googleSignIn.currentUser.photoUrl,
          )
        : SignInButton(
            function: () {
              if (googleSignIn.currentUser?.id != null && sessionWithConnection) {
//                    print(googleSignIn.clientId);
                signInWidget = AvatarWidget(
                  imageUrl: googleSignIn.currentUser.photoUrl,
                );
                setState(() {});
                getDataFromFirebase();
              } else {
                showDialog(
                  context: context,
                  child: DialogWindow(
                    mainText: "Соединение отсутствует",
                    detailText: "Приложение работает в режиме оффлайн",
                    neutralButtonText: "Понятно",
                    neutralButtonFunction: () => Navigator.of(context).pop(),
                  ),
                );
              }
            },
          );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: prefs.getSecondaryThemeColor(),
      appBar: AppBar(
        backgroundColor: prefs.getMainThemeColor(),
        title: Text(
          "Мои путешествия",
          style: prefs.getMainTextStyle(),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
            child: signInWidget,
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: currencyPageDataBox.listenable(),
              builder: (context, currencyPageDataBox, widget) {
                return (currencyPageDataBox.get(kHomePageTravelCardKey) ?? {})
                            .length ==
                        0
                    ? ListView(children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(30.0),
                          child: Column(
                            children: <Widget>[
                              Icon(
                                Icons.airplanemode_inactive,
                                size: 100.0,
                                color:
                                    prefs.getThirdThemeColor().withOpacity(0.4),
                              ),
                              Text(
                                "Пока тут ничего нет 😕",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    color: prefs
                                        .getThirdThemeColor()
                                        .withOpacity(0.4)),
                              )
                            ],
                          ),
                        ),
                      ])
                    : ListView.builder(
                        itemCount:
                            (currencyPageDataBox.get(kHomePageTravelCardKey) ??
                                    {})
                                .length,
                        itemBuilder: (context, index) {
                          List<dynamic> keys = currencyPageDataBox
                              .get(kHomePageTravelCardKey)
                              .keys
                              .toList();
                          Map<dynamic, dynamic> travelCardsMap =
                              currencyPageDataBox
                                  .get(kHomePageTravelCardKey)[keys[index]];
//                    print(keys[index].runtimeType);

                          return HomePageTravelCard(
                            travelName: travelCardsMap["travelName"],
                            travelDates:
                                "${travelCardsMap["dateFrom"]} - ${travelCardsMap["dateTo"]}",
                            travelAmount: travelCardsMap["expensesAmount"]
                                .toStringAsFixed(2),
                            travelCurrencySymbol: currencies[
                                    travelCardsMap["toConvertCurrencyCode"]]
                                ["cur_symbol"],
                            baseCurrencyCode:
                                travelCardsMap["defaultExpensesCurrencyCode"],
                            toConvertCurrencyCode:
                                travelCardsMap["toConvertCurrencyCode"],
                            arguments: {keys[index]: travelCardsMap},
                          );
                        },
//                  shrinkWrap: true,
                      );
              },
            ),
          ),
          SubmitButton(
            buttonTitle: "Добавить путешествие",
            onPressed: () =>
//                getDataFromFirebase(),
//            print(currencyPageDataBox.get(kHomePageTravelExpensesKey)),
                Navigator.of(context).pushNamed(AddNewTravelCardPage.id),
          )
        ],
      ),
    );
  }
}
