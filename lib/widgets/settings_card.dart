import 'package:flutter/material.dart';
import 'package:my_travel_wallet/constants.dart';

class SettingsCard extends StatefulWidget {
  SettingsCard(
      {@required this.title,
      this.subTitle = "",
      this.value = false,
      this.function});

  final String title;
  final String subTitle;
  final bool value;
  final Function function;

  @override
  _SettingsCardState createState() => _SettingsCardState();
}

class _SettingsCardState extends State<SettingsCard> {
  bool _switchValue;
  @override
  void initState() {
    super.initState();
    _switchValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.title),
//      subtitle: Text(widget.subTitle),
      trailing: Switch(
          activeColor: kLightThemeSecondaryColor,
          value: _switchValue,
          onChanged: (bool) {
            setState(() {
              _switchValue = bool;
            });
            print("pressed. New value is $bool");
          }),
    );
  }
}
