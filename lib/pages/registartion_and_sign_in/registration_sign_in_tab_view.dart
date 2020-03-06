import 'package:flutter/material.dart';
import 'package:my_travel_wallet/data/main_data.dart';
import 'package:my_travel_wallet/pages/registartion_and_sign_in/registration_page.dart';
import 'package:my_travel_wallet/pages/registartion_and_sign_in/sign_in_page.dart';

class SignInPage extends StatefulWidget {
  static String id = 'signInPage';

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<Widget> tabs;
  @override
  void initState() {
    tabs = [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Войти",
          style: prefs.getMainTextStyle().copyWith(fontSize: 15.0),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("Регистрация",
            style: prefs.getMainTextStyle().copyWith(fontSize: 15.0)),
      )
    ];

    _tabController = TabController(length: tabs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: prefs.getSecondaryThemeColor(),
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: prefs.getThirdThemeColor(),
            ),
            onPressed: () => Navigator.pop(context)),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: prefs.getMainThemeColor(),
        title: Text(
          "Авторизация",
          style: prefs.getMainTextStyle(),
        ),
        bottom: TabBar(
          indicatorColor: prefs.getThemeAccentColor(),
          controller: _tabController,
          tabs: tabs,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          SignIn(),
          RegistrationPage(),
        ],
      ),
    );
  }
}