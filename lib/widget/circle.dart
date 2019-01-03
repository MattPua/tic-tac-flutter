import 'package:flutter/material.dart';
import '../painter/circle_painter.dart';
import '../util.dart';

class Circle extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CircleState();
}
 
class CircleState extends State<Circle> with SingleTickerProviderStateMixin {
  double _fraction = 0.0;
  Animation<double> animation;
 
  @override
  void initState() {
    super.initState();
    var controller = AnimationController(
        duration: Duration(milliseconds: Util.ANIMATION_SPEED), vsync: this);
 
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          _fraction = animation.value;
        });
      });
 
    controller.forward();
  }
 
  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: CirclePainter(_fraction));
  }
}
 