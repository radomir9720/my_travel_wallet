import 'package:flutter/material.dart';
import 'package:my_travel_wallet/constants.dart';
import 'package:my_travel_wallet/data/main_data.dart';
import 'package:my_travel_wallet/widgets/date_picker_widget.dart';
import 'package:my_travel_wallet/widgets/dialog_window.dart';
import 'package:my_travel_wallet/widgets/submit_button.dart';
import 'package:my_travel_wallet/widgets/text_input_field.dart';

class AddNewTravelCardPage extends StatefulWidget {
  static String id = 'addNewTravelCard';

  @override
  _AddNewTravelCardPageState createState() => _AddNewTravelCardPageState();
}

class _AddNewTravelCardPageState extends State<AddNewTravelCardPage> {
  TextEditingController _travelNameController = TextEditingController();
  TextEditingController _dateFromController = TextEditingController();
  TextEditingController _dateToController = TextEditingController();

  @override
  void initState() {
    _dateFromController.text = DateTime.now().toString().split(" ")[0];
    _dateToController.text =
        DateTime.now().add(Duration(days: 7)).toString().split(" ")[0];
    super.initState();
  }

  @override
  void dispose() {
    _travelNameController.dispose();
    _dateFromController.dispose();
    _dateToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20.0,
          ),
          onPressed: () => Navigator.of(context).pop(),
          color: prefs.getThirdThemeColor(),
        ),
        backgroundColor: prefs.getMainThemeColor(),
        title: Text(
          "Добавление путешествия",
          style: prefs.getMainTextStyle(),
        ),
      ),
      body: Container(
        width: double.infinity,
        color: prefs.getSecondaryThemeColor(),
        child: Padding(
          padding: kPadding,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(kBorderRadius),
              color: prefs.getMainThemeColor(),
            ),
            padding: kPadding,
            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Введите название путешествия:",
                  style: prefs.getMainTextStyle().copyWith(fontSize: 20.0),
                ),
                TextInputField(
                  controller: _travelNameController,
                  checkIfIsValid: (controller) {
                    return controller.text.length <= 50;
                  },
                  errorText: "К-во символов должно быть не более 50.",
                  hintText: "Например: Ямайка :)",
                ),
                Divider(
                  color: prefs.getThemeAccentColor(),
                ),
                Text(
                  "Выберите даты путешествия:",
                  style: prefs.getMainTextStyle().copyWith(fontSize: 20.0),
                ),
                Row(
                  children: <Widget>[
                    DatePickerWidget(
                      controller: _dateFromController,
                      format: "yyyy-MM-dd",
                      hintText: "С какой даты",
                    ),
                    DatePickerWidget(
                      controller: _dateToController,
                      format: "yyyy-MM-dd",
//                      initialValue: DateTime.now().add(
//                        Duration(days: 7),
//                      ),
                      hintText: "По какую дату",
                    ),
                  ],
                ),
                SubmitButton(
                  buttonTitle: "Добавить путешествие",
                  onPressed: () {
                    if (_travelNameController.text.length == 0) {
                      showDialog(
                        context: context,
                        child: DialogWindow(
                          mainText: "Введите название путешествия!",
                          detailText:
                              "Поле с названием путешествия должно содержать от 1 до 50 символов",
                          fractionRatio: 0.3,
                          neutralButtonText: "Понятно",
                          neutralButtonFunction: () =>
                              Navigator.of(context).pop(),
                        ),
                      );
                    } else {
                      DateTime dateFrom =
                          DateTime.parse(_dateFromController.text);
                      DateTime dateTo = DateTime.parse(_dateToController.text);
//                      print(months[dateFrom.month]["short"]);
                      Map<dynamic, dynamic> tempMap =
                          currencyPageDataBox.get(kHomePageTravelCardKey);
                      tempMap[DateTime.now().millisecondsSinceEpoch] = {
                        "travelName": _travelNameController.text.toString(),
                        "dateFrom":
                            "${dateFrom.day} ${months[dateFrom.month]["short"]} ${dateFrom.year}",
                        "dateTo":
                            "${dateTo.day} ${months[dateTo.month]["short"]} ${dateTo.year}",
                      };
                      currencyPageDataBox.put(kHomePageTravelCardKey, tempMap);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
