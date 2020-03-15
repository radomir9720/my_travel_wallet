import 'package:flutter/material.dart';
import 'package:my_travel_wallet/tabs/bottom_navigation_bar_button.dart';
import 'package:my_travel_wallet/constants.dart';
import 'package:my_travel_wallet/data/main_data.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  CustomBottomNavigationBar({@required this.items});

  final List<CustomBottomNavigationBarButton> items;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: kCustomBottomNavigationBarElevation,
      shadowColor: Colors.black,
//      height: 60.0,
      child: Container(
        color: prefs.getMainThemeColor(),
        height: kCustomBottomNavigationBarButtonHeight +
            kCustomBottomNavigationBarBorderHeight +
            (kCustomBottomNavigationBarPadding * 2) +
            1.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: kCustomBottomNavigationBarBorderHeight,
              child: Container(
                color: prefs.getThemeAccentColor(),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: kCustomBottomNavigationBarPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: items,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
