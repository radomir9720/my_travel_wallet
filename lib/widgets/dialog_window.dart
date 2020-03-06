import 'package:flutter/material.dart';
import 'package:my_travel_wallet/data/main_data.dart';
import 'package:my_travel_wallet/widgets/dialog_window_button.dart';

class DialogWindow extends StatelessWidget {
  DialogWindow({
    @required this.mainText,
    this.detailText,
    @required this.fractionRatio,
    this.positiveButtonFunction,
    this.positiveButtonText,
    this.negativeButtonFunction,
    this.negativeButtonText,
    this.neutralButtonFunction,
    this.neutralButtonText,
  });
  final String mainText;
  final String detailText;
  final double fractionRatio;
  final Function positiveButtonFunction;
  final String positiveButtonText;
  final Function negativeButtonFunction;
  final String negativeButtonText;
  final Function neutralButtonFunction;
  final String neutralButtonText;

  @override
  Widget build(BuildContext context) {
    List<DialogWindowButton> getDialogWindowButtons() {
      List<DialogWindowButton> buttonList = [];
      if (neutralButtonText != null)
        buttonList.add(DialogWindowButton(
          buttonText: neutralButtonText,
          buttonTextStyle: prefs.getMainTextStyle(),
          function: neutralButtonFunction,
        ));
      if (negativeButtonText != null)
        buttonList.add(
          DialogWindowButton(
            buttonText: negativeButtonText,
            buttonTextStyle: TextStyle(
              color: Colors.green,
            ),
            function: negativeButtonFunction,
          ),
        );
      if (positiveButtonText != null)
        buttonList.add(
          DialogWindowButton(
            buttonText: positiveButtonText,
            buttonTextStyle: TextStyle(color: Colors.red),
            function: positiveButtonFunction,
          ),
        );
      return buttonList;
    }

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.1),
      body: Center(
        child: FractionallySizedBox(
          heightFactor: fractionRatio,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: prefs.getMainThemeColor(),
                borderRadius: BorderRadius.all(
                  Radius.circular(4.0),
                ),
              ),
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    mainText,
                    style: prefs.getMainTextStyle().copyWith(fontSize: 20.0),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  detailText != null
                      ? Text(
                          detailText,
                          style: prefs.getMainTextStyle(),
                          textAlign: TextAlign.center,
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: getDialogWindowButtons(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
