import 'package:flutter/material.dart';
import 'package:my_travel_wallet/data/main_data.dart';
import 'package:my_travel_wallet/utilities/google_auth.dart';
import 'package:my_travel_wallet/widgets/add_new_travel_card_page.dart';
import 'package:my_travel_wallet/widgets/avatar_widget.dart';
import 'package:my_travel_wallet/widgets/home_page_travel_card.dart';
import 'package:my_travel_wallet/widgets/sign_in_button.dart';
import 'package:my_travel_wallet/widgets/submit_button.dart';

class HomePage extends StatefulWidget {
  HomePage({this.key});

  final Key key;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget signInWidget;

  @override
  void initState() {
    // Если юзер залогинен показываем его аватарку, иначе - кнопку для входа
    signInWidget = googleSignIn.currentUser != null
        ? AvatarWidget(
            imageUrl: googleSignIn.currentUser.photoUrl,
          )
        : SignInButton(
            function: () {
              signInWidget = AvatarWidget(
                imageUrl: googleSignIn.currentUser.photoUrl,
              );
              setState(() {});
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
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              HomePageTravelCard(
                travelName: "Ямайка",
                travelDates: "10 мар 2020 - 25 мар 2020",
                travelAmount: "123123.21",
                travelCurrencyCode: "руб",
              ),
            ],
          ),
          SubmitButton(
            buttonTitle: "Добавить путешествие",
            onPressed: () => Navigator.of(context).pushNamed(AddNewTravelCardPage.id),
          )
        ],
      ),
    );
  }
}
