import 'package:flutter/material.dart';
import 'package:my_travel_wallet/constants.dart';
import 'package:my_travel_wallet/main.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mySharedPreferences.getSecondaryThemeColor(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          padding: EdgeInsets.all(10.0),
          color: mySharedPreferences.getMainThemeColor(),
          child: Column(
            children: <Widget>[
              Text(
                "Войдите, используя логин и пароль",
                style: mySharedPreferences
                    .getMainTextStyle()
                    .copyWith(fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  style: TextStyle(color: mySharedPreferences.getThemeAccentColor()),
                  cursorColor: mySharedPreferences.getThemeAccentColor(),
                  decoration: kInputDecoration.copyWith(
                    hintText: "Введите логин",
                    hintStyle: TextStyle(
                      color: mySharedPreferences.getThirdThemeColor(),
                    ),
//                    labelStyle: TextStyle(color: mySharedPreferences.getThemeAccentColor()),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  style: TextStyle(color: mySharedPreferences.getThemeAccentColor()),
                  cursorColor: mySharedPreferences.getThemeAccentColor(),
                  decoration: kInputDecoration.copyWith(
                    hintText: "Введите пароль",
                    hintStyle: TextStyle(
                      color: mySharedPreferences.getThirdThemeColor(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  color: mySharedPreferences.getThemeAccentColor(),
                  height: 50.0,
                  minWidth: double.infinity,
                  onPressed: () {},
                  child: Text(
                    'Войти',
                    style: mySharedPreferences
                        .getMainTextStyle()
                        .copyWith(fontSize: 15.0),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
