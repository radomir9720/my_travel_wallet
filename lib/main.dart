import 'package:flutter/material.dart';
import 'package:my_travel_wallet/pages/registartion_and_sign_in/registration_sign_in_page.dart';
import 'package:my_travel_wallet/tabs/main_navigation_view.dart';
import 'package:my_travel_wallet/utilities/shared_preferences.dart';

void main() => runApp(MyTravelWallet());
MySharedPreferences mySharedPreferences = MySharedPreferences();

class MyTravelWallet extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: mySharedPreferences.init(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.done) {
          return MaterialApp(
            routes: {
              SignInPage.id: (context) => SignInPage(),
            },
            title: 'Приложение для учета финансов в путешествиях.',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: MainTabView(),
          );
        } else {
          return Container(
              height: 100.0,
              child: Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              )));
        }
      },
    );
  }
}
