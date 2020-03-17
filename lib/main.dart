import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_travel_wallet/pages/home_page/widgets/add_new_travel_card_page.dart';
import 'package:my_travel_wallet/tabs/main_navigation_view.dart';
import 'package:my_travel_wallet/data/main_data.dart';
import 'package:my_travel_wallet/widgets/custom_progress_indicator.dart';
import 'package:my_travel_wallet/pages/home_page/widgets/travel_page_detail.dart';

void main() => runApp(MyTravelWallet());

class MyTravelWallet extends StatefulWidget {
  @override
  _MyTravelWalletState createState() => _MyTravelWalletState();
}

class _MyTravelWalletState extends State<MyTravelWallet> {
  Widget body = Container(
    height: 100.0,
    child: Center(
      child: CustomCircularProgressIndicator()
    ),
  );

  void waitInitializeDataAndRunApp() async {
    await initializeData();
    setState(() {
      body = MainTabView();
    });
  }

  @override
  void initState() {
    waitInitializeDataAndRunApp();
    super.initState();
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        AddNewTravelCardPage.id: (context) => AddNewTravelCardPage(),
        TravelPageDetail.id: (context) => TravelPageDetail(),
      },
      title: 'Приложение для учета финансов в путешествиях.',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: body,
    );
  }
}
