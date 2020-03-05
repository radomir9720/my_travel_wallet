import 'package:flutter/material.dart';
import 'package:my_travel_wallet/data/main_data.dart';
import 'package:my_travel_wallet/utilities/google_auth.dart';

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
      backgroundColor: prefs.getSecondaryThemeColor(),
      appBar: AppBar(
        backgroundColor: prefs.getMainThemeColor(),
        title: Text(
          "Мои путешествия",
          style: prefs.getMainTextStyle(),
        ),
        actions: <Widget>[
          MaterialButton(
            onPressed: () {
              signInWithGoogle().whenComplete(
                () {print("COMPLETE!");},
              );
//              Navigator.pushNamed(context, SignInPage.id);
            },
            child: Row(
              children: <Widget>[
                Text(
                  "ВОЙТИ",
                  style: prefs.getMainTextStyle(),
                ),
                SizedBox(
                  width: 3.0,
                ),
                Icon(
                  Icons.account_circle,
                  color: prefs.getThirdThemeColor(),
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
