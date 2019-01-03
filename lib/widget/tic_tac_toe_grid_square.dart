import 'package:flutter/material.dart';
import 'cross.dart';
import 'circle.dart';

class TicTacToeGridSquare extends StatelessWidget {
  Function onTapFunction;
  int index;
  bool isToggled;
  int score;

  Widget cross = new AspectRatio(
    aspectRatio: 0.5,
    child: Container(
        child: Container(padding: EdgeInsets.all(32.0), child: Cross())));
  Widget circle = new AspectRatio(
    aspectRatio: 0.5,
    child: Container(
        child: Container(padding: EdgeInsets.all(32.0), child: Circle())));

  TicTacToeGridSquare(
      {Key key, this.onTapFunction, this.index, this.isToggled, this.score})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: Colors.orange,
        highlightColor: Colors.green,
        onTap: () => this.onTapFunction(this.index),
        child: Container(
            width: 200,
            height: 200,
            child: getCursor(),
            decoration: BoxDecoration(
                // color: getColor(), 
                border: Border.all(color: Colors.white54))));
  }

  Widget getCursor() {
    return this.isToggled
        ? (this.score == 1 ? cross : circle)
        : null;
  }
}
