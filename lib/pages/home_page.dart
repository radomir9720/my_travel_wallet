import 'package:flutter/material.dart';
import 'package:my_travel_wallet/main.dart';
import 'package:my_travel_wallet/pages/registartion_and_sign_in/registration_sign_in_page.dart';

class HomePage extends StatefulWidget {
  HomePage({this.key});

  final Key key;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mySharedPreferences.getSecondaryThemeColor(),
      appBar: AppBar(
        backgroundColor: mySharedPreferences.getMainThemeColor(),
        title: Text(
          "Мои путешествия",
          style: mySharedPreferences.getMainTextStyle(),
        ),
        actions: <Widget>[
          MaterialButton(
            onPressed: () {
              Navigator.pushNamed(context, SignInPage.id);
            },
            child: Row(
              children: <Widget>[
                Text(
                  "ВОЙТИ",
                  style: mySharedPreferences.getMainTextStyle(),
                ),
                SizedBox(
                  width: 3.0,
                ),
                Icon(
                  Icons.account_circle,
                  color: mySharedPreferences.getThirdThemeColor(),
                  size: 40.0,
                ),
              ],
            ),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[],
      ),
//      body: CustomScrollView(
//        slivers: <Widget>[
//          SliverAppBar(
//              backgroundColor: mySharedPreferences.getMainThemeColor(),
//              expandedHeight: 200.0,
//              flexibleSpace: const FlexibleSpaceBar(
//                title: Text(
//                  'Мои путешествия',
//                  style: TextStyle(color: Colors.grey),
//                ),
//              ),
//              pinned: true,
//              actions: <Widget>[
//                MaterialButton(
//                  child: Row(
//                    children: <Widget>[
//                      Text(
//                        "Войти",
//                        style: TextStyle(
//                            color: mySharedPreferences.getThirdThemeColor()),
//                      ),
//                      SizedBox(
//                        width: 3.0,
//                      ),
//                      Icon(
//                        Icons.account_circle,
//                        size: 40.0,
//                        color: mySharedPreferences.getThirdThemeColor(),
//                      ),
//                    ],
//                  ),
//                  onPressed: () {},
//                )
//              ]),
//          SliverList(
//            delegate: SliverChildListDelegate(_buildList(50)),
////            delegate: SliverChildBuilderDelegate(
////          (_, index) => ListTile(
////            title: Text("Index: $index"),
////          ),
////        ),
//          )
//        ],
//      ),
    );
  }
}

//List _buildList(int count) {
//  List<Widget> listItems = List();
//
//  for (int i = 0; i < count; i++) {
//    listItems.add(new Padding(
//        padding: new EdgeInsets.all(20.0),
//        child: new Text('Item ${i.toString()}',
//            style: new TextStyle(fontSize: 25.0))));
//  }
//  return listItems;
//}
