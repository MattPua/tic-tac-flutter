import 'package:flutter/material.dart';
import 'dart:math';
class CirclePainter extends CustomPainter {
  Paint _paint;
  double _fraction;
 
  CirclePainter(this._fraction) {
    _paint = Paint()
      ..color = Colors.pink
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;
  }
 
  @override
  void paint(Canvas canvas, Size size) {
    print('paint $_fraction');
 
    var rect = Offset(0.0, 0.0) & size;
 
    canvas.drawArc(rect, -pi / 2, pi * 2 * _fraction, false, _paint);
  }
 
  @override
  bool shouldRepaint(CirclePainter oldDelegate) {
    return oldDelegate._fraction != _fraction;
  }
}