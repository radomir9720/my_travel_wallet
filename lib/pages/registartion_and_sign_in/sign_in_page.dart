import 'package:flutter/material.dart';
import 'package:my_travel_wallet/data/main_data.dart';
import 'package:my_travel_wallet/widgets/content_wrapper.dart';
import 'package:my_travel_wallet/widgets/submit_button.dart';
import 'package:my_travel_wallet/widgets/text_input_field.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPageContentWrapper(
      child: ListView(
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
    );
  }
}
