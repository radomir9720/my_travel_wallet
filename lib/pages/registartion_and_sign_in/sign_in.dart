import 'package:flutter/material.dart';
import 'package:my_travel_wallet/main.dart';
import 'package:my_travel_wallet/widgets/submit_button.dart';
import 'package:my_travel_wallet/widgets/text_input_field.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: prefs.getSecondaryThemeColor(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          padding: EdgeInsets.all(10.0),
          color: prefs.getMainThemeColor(),
          child: Column(
            children: <Widget>[
              Text(
                "Войдите, используя логин и пароль",
                style: prefs.getMainTextStyle().copyWith(fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10.0,
              ),
              TextInputField(
                hintText: "Введите логин",
              ),
              TextInputField(
                hintText: "Введите пароль",
                obscure: true,
              ),
              SubmitButton(
                buttonTitle: "Войти",
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
