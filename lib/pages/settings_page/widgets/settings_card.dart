import 'package:flutter/material.dart';
import 'package:my_travel_wallet/constants.dart';
import 'package:my_travel_wallet/data/main_data.dart';

class SettingsCard extends StatefulWidget {
  SettingsCard(
      {@required this.title, this.subTitle, this.switchValue, this.function});

  final String title;
  final String subTitle;
  final bool switchValue;
  final Function function;

  @override
  _SettingsCardState createState() => _SettingsCardState();
}

class _SettingsCardState extends State<SettingsCard> {
  bool _switchValue;
  @override
  void initState() {
    super.initState();
    _switchValue = widget.switchValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            widget.title,
            style: prefs.getMainTextStyle(),
          ),
          subtitle: widget.subTitle == null
              ? null
              : Text(
                  widget.subTitle,
                  style: prefs.getMainTextStyle(),
                ),
          trailing: widget.switchValue == null
              ? SizedBox()
              : Switch(
                  activeColor: prefs.getThemeAccentColor(),
                  value: _switchValue,
                  onChanged: (bool) {
                    setState(() {
                      _switchValue = bool;
                    });
                    widget.function();
                  }),
        ),
        Divider(
          color: prefs.getThemeAccentColor(),
          height: 0.0,
          indent: kStartIndentDividerValue,
          endIndent: kEndIndentDividerValue,
          thickness: kBorderWidth,
        ),
      ],
    );
  }
}
