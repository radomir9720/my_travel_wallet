import 'package:flutter/material.dart';
import 'package:my_travel_wallet/constants.dart';
import 'package:my_travel_wallet/data/main_data.dart';

class CustomBottomNavigationBarButton extends StatelessWidget {
  CustomBottomNavigationBarButton({
    @required this.icon,
    @required this.function,
    @required this.color,
    this.isActive,
  });

  final Function function;
  final IconData icon;
  final Color color;
  final bool isActive;

  Widget build(BuildContext context) {
    return Container(
      child: MaterialButton(
        padding: EdgeInsets.all(0.0),
        color: prefs.getMainThemeColor(),
        elevation: isActive ? kElevationDouble : 0.0,
        minWidth: kCustomBottomNavigationBarButtonWidth,
        height: kCustomBottomNavigationBarButtonHeight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
          side: BorderSide(
            color: isActive
                ? prefs.getThemeAccentColor()
                : prefs.getMainThemeColor(),
          ),
        ),
        onPressed: function,
        child: Icon(
          icon,
          color: color,
        ),
      ),
    );
  }
}
