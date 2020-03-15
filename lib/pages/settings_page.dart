import 'package:flutter/material.dart';
import 'package:my_travel_wallet/utilities/google_auth.dart';
import 'package:my_travel_wallet/widgets/dialog_window.dart';
import 'package:my_travel_wallet/widgets/settings_card.dart';
import 'package:my_travel_wallet/data/main_data.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({this.key});

  final Key key;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _themeSwitchValue;

  @override
  void initState() {
    _themeSwitchValue = prefs.getSwitchThemeValue();
    prefs.addListener(() {
      if (this.mounted) setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    prefs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: prefs.getSecondaryThemeColor(),
      appBar: AppBar(
        title: Text(
          "Настройки",
          style: prefs.getMainTextStyle(),
        ),
        backgroundColor: prefs.getMainThemeColor(),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          SettingsCard(
            title: "Темная тема",
            switchValue: _themeSwitchValue,
            function: () {
              _themeSwitchValue = !_themeSwitchValue;
              prefs.setSwitchThemeValue(_themeSwitchValue);
            },
          ),
          MaterialButton(
            padding: EdgeInsets.all(0.0),
            onPressed: () {
              showDialog(
                context: context,
                // Проверка залогинен ли пользователь
                child: googleSignIn.currentUser == null
                    // Если не залогинен, выводим диалоговое окно с данной информацией
                    ? DialogWindow(
                        mainText: "Вы не авторизованы",
                        neutralButtonText: "Понятно",
                        neutralButtonFunction: () => Navigator.pop(context),
                      )
                    // Если залогинен, показываем диалоговое окно с выбором
                    : DialogWindow(
                        mainText: "Вы точно хотите выйти?",
                        detailText:
                            "Авторизация нужна для синхронизации данных. При входе в данное приложение на другом устройстве данные синхронизируются.",
                        positiveButtonFunction: () {
                          sendDataToFirebase();
                          signOutGoogle();
                          prefs.setAuthorizedStatus(false);
                          Navigator.pop(context);
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text("Вы вышли из аккаунта")));
                        },
                        positiveButtonText: "Да",
                        negativeButtonFunction: () => Navigator.pop(context),
                        negativeButtonText: "Нет",
                      ),
              );
            },
            child: SettingsCard(
              title: "Выйти из аккаунта Google",
            ),
          ),
          SettingsCard(
            title: "Версия приложения",
            subTitle: "1.0.0",
          )
        ],
      ),
    );
  }
}
