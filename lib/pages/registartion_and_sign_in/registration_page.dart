import 'package:flutter/material.dart';
import 'package:my_travel_wallet/widgets/content_wrapper.dart';
import 'package:my_travel_wallet/widgets/submit_button.dart';
import 'package:my_travel_wallet/widgets/text_input_field.dart';

import '../../main.dart';

class RegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPageContentWrapper(
      child: ListView(
        children: <Widget>[
          Text(
            "Зарегистрируйтесь",
            style: prefs.getMainTextStyle().copyWith(fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10.0,
          ),
          TextInputField(
            hintText: "Придумайте логин",
          ),
          TextInputField(
            hintText: "Придумайте пароль",
            obscure: true,
          ),
          TextInputField(
            hintText: "Повторите пароль",
            obscure: true,
          ),
          SubmitButton(
            buttonTitle: "Зарегистрироваться",
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
