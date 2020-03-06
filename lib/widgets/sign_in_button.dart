import 'package:flutter/material.dart';
import 'package:my_travel_wallet/data/main_data.dart';
import 'package:my_travel_wallet/utilities/google_auth.dart';

class SignInButton extends StatelessWidget {
  SignInButton({this.function});
  final Function function;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.all(0.0),
      onPressed: () async {
        String value = await signInWithGoogle();
        if (googleSignIn.currentUser != null) prefs.setAuthorizedStatus(true);
        print(value);
        function();
      },
      child: Container(
        child: Row(
          children: <Widget>[
            Text(
              "Войти",
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
      ),
    );
  }
}
