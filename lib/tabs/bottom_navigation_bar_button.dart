import 'package:flutter/material.dart';
import 'package:my_travel_wallet/constants.dart';

class CustomBottomNavigationBarButton extends StatelessWidget {
  CustomBottomNavigationBarButton(
      {@required this.icon, @required this.function, @required this.color});

  final Function function;
  final IconData icon;
  final Color color;

  Widget build(BuildContext context) {
    return Container(
      child: MaterialButton(
        minWidth: kCustomBottomNavigationBarButtonWidth,
        height: kCustomBottomNavigationBarButtonHeight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
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
