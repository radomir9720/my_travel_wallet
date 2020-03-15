import 'package:flutter/material.dart';
import 'package:my_travel_wallet/constants.dart';

class RoundCountryFlagImage extends StatelessWidget {
  RoundCountryFlagImage({this.imageName, this.imageSize = 40.0});
  final double imageSize;
  final String imageName;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: kElevationDouble,
      borderRadius: BorderRadius.all(Radius.circular(100.0)),
      child: ClipRRect(
        child: Image(
          height: imageSize,
          width: imageSize,
          fit: BoxFit.fitHeight,
          image: AssetImage(
            kPathToImages + imageName,
          ),
        ),
        borderRadius: BorderRadius.all(Radius.circular(100.0)),
      ),
    );
  }
}
