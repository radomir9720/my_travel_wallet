import 'package:flutter/material.dart';
import 'package:my_travel_wallet/constants.dart';
import 'package:my_travel_wallet/data/main_data.dart';
import 'package:my_travel_wallet/utilities/google_auth.dart';
import 'package:my_travel_wallet/presentation/my_flutter_app_icons.dart';

class SignInButton extends StatelessWidget {
  SignInButton({this.function});
  final Function function;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.all(0.0),
      onPressed: () async {
        if (sessionWithConnection) {
          try {
            String value = await signInWithGoogle();
            if (googleSignIn.currentUser != null) prefs.setAuthorizedStatus(true);
            print(value);
          } catch (_) {}
        }
        function();
      },
      child: Container(
        child: Row(
          children: <Widget>[
            Text(
              "Войти ",
              style: prefs.getMainTextStyle().copyWith(fontSize: 17.0),
            ),
            SizedBox(
              width: 3.0,
            ),
            Material(
              color: prefs.getMainThemeColor(),
              elevation: kElevationDouble,
              borderRadius: BorderRadius.all(Radius.circular(100.0)),
              child: Container(
                padding: EdgeInsets.all(kPaddingDouble +2.0),
                child: Icon(
                  MyFlutterApp.gplus,
                  color: prefs.getThemeAccentColor(),
                  size: 25.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
