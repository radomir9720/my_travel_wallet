import 'package:flutter/material.dart';
import 'package:my_travel_wallet/constants.dart';
//import 'package:my_travel_wallet/utilities/singleton.dart';


class SettingsCard extends StatefulWidget {
  SettingsCard(
      {@required this.title, this.subTitle, this.value, this.function});

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
      subtitle: widget.subTitle == null ? null : Text(widget.subTitle),
      trailing: widget.value == null
          ? SizedBox()
          : Switch(
              activeColor: kLightThemeSecondaryColor,
              value: _switchValue,
              onChanged: (bool) {
                setState(() {
                  _switchValue = bool;

                });
                widget.function();
              }),
    );
  }
}
