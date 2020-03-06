import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  AvatarWidget({this.imageUrl});
  final imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ClipRRect(
        child: Image(
          image: NetworkImage(imageUrl),
        ),
        borderRadius: BorderRadius.all(Radius.circular(100.0)),
      ),
    );
  }
}
