import 'package:flutter/material.dart';

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
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.black,
            expandedHeight: 200.0,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('Мои путешествия'),
            ),
            pinned: true,
            actions: <Widget>[
              MaterialButton(
                child: Row(
                  children: <Widget>[
                    Text("Войти", style: TextStyle(color: Colors.white),),
                    SizedBox(width: 3.0,),
                    Icon(Icons.account_circle, size: 40.0, color: Colors.white,),
                  ],
                ),
                onPressed: () {},
              )
            ]),
        SliverList(
          delegate: SliverChildListDelegate(_buildList(50)),
//            delegate: SliverChildBuilderDelegate(
//          (_, index) => ListTile(
//            title: Text("Index: $index"),
//          ),
//        ),
        )
      ],
    ));
  }
}

List _buildList(int count) {
  List<Widget> listItems = List();

  for (int i = 0; i < count; i++) {
    listItems.add(new Padding(
        padding: new EdgeInsets.all(20.0),
        child: new Text('Item ${i.toString()}',
            style: new TextStyle(fontSize: 25.0))));
  }
  return listItems;
}
