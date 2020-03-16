import 'package:flutter/material.dart';
import 'package:my_travel_wallet/constants.dart';

class CustomCircularProgressIndicator extends StatefulWidget {
  @override
  _CustomCircularProgressIndicatorState createState() =>
      _CustomCircularProgressIndicatorState();
}

class _CustomCircularProgressIndicatorState
    extends State<CustomCircularProgressIndicator>
    with SingleTickerProviderStateMixin {
  double _start = 50.0;
  double _end = 100.0;
  double _temp;
//  double containerHeightAndWidth;
  Animation<double> _animation;
  AnimationController _controller;

//  void changeContainerSize() {
//    print("123");
//    containerHeightAndWidth =
//        containerHeightAndWidth == minSize ? maxSize : minSize;
//    if (this.mounted) setState(() {});
//    changeContainerSize();
//  }

  @override
  void initState() {
//    containerHeightAndWidth = _start;
//    if (this.mounted) changeContainerSize();
    super.initState();
    _controller = new AnimationController(
        vsync: this, duration: new Duration(seconds: 1));
    Tween tween = Tween<double>(begin: _start, end: _end);
    _animation = tween.animate(_controller);
//    _animation = CurvedAnimation(parent: _controller, curve: Curves.decelerate);
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
       _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _animation.addListener(() {
      setState(() {});
    });
    _controller.forward();

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Image(
      width: _animation.value,
      height: _animation.value,
      image: AssetImage('assets/images/my_travel_wallet_logo.png'),
      fit: BoxFit.fill,
    );
  }
}
