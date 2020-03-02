import 'package:flutter/material.dart';
import 'package:my_travel_wallet/tabs/main_navigation_view.dart';

void main() => runApp(MyTravelWallet());

class MyTravelWallet extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Приложение для учета финансов в путешествиях.',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainTabView(),
    );
  }
}
