import 'package:flutter/material.dart';
import 'package:my_travel_wallet/constants.dart';
import 'package:my_travel_wallet/data/main_data.dart';
import 'package:my_travel_wallet/widgets/add_new_expense_view.dart';
import 'package:my_travel_wallet/widgets/content_wrapper.dart';
import 'package:my_travel_wallet/widgets/small_button.dart';
import 'package:my_travel_wallet/widgets/text_input_field.dart';
import 'package:my_travel_wallet/widgets/title_text_widget.dart';

class TravelPageDetail extends StatefulWidget {
  static String id = 'travelPageDetail';

  @override
  _TravelPageDetailState createState() => _TravelPageDetailState();
}

class _TravelPageDetailState extends State<TravelPageDetail> {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
//    if (arguments != null) print(arguments);
    return Scaffold(
//      appBar: AppBar(
//        title: Text(
//          arguments["travelName"],
//          style: prefs.getMainTextStyle(),
//        ),
//        backgroundColor: prefs.getMainThemeColor(),
//      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            bottom: PreferredSize(
              preferredSize: Size(double.infinity, 20.0),
              child: Text(
                arguments.values.first["travelName"],
                textAlign: TextAlign.center,
                style: prefs.getMainTextStyle().copyWith(fontSize: 20.0),
              ),
            ),
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.arrow_back_ios,
                color: prefs.getThirdThemeColor(),
              ),
            ),
            backgroundColor: prefs.getMainThemeColor(),
//            expandedHeight: 100.0,
            actions: <Widget>[
              DropdownButton(
//                value: "",
                icon: Icon(Icons.more_vert),
                items: [
//                  DropdownMenuItem(child: Text("")),
                  DropdownMenuItem(child: Text("УдОлить")),
                  DropdownMenuItem(child: Text("Не удолять"))
                ],
                onChanged: (value) {print(value);},
              ),
//              IconButton(icon: Icon(Icons.more_vert, color: prefs.getThirdThemeColor(),),
//                onPressed: () {},),
//              Padding(
//                padding: kPadding,
//                child: SmallButton(
//                  buttonTitle: "Добавить расход",
//                  onPressed: () {
//                    showDialog(
//                      context: context,
//                      child: Scaffold(
//                        backgroundColor: Colors.black.withOpacity(0.1),
//                        body: AddNewExpenseView(
//                          defaultBaseCurrency:
//                              arguments.values.first["defaultExpensesCurrencyCode"],
//                          travelCardKey: arguments.keys.first,
//                          toConvertCurrencyCode: arguments.values.first["toConvertCurrencyCode"],
//                        ),
//                      ),
//                    );
//                  },
//                ),
//              )
            ],
            title: Text(
              "Расходы",
              style: prefs.getMainTextStyle(),
            ),
//            flexibleSpace: 200.0,
          )
        ],
      ),
    );
  }
}
