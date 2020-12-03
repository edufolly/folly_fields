import 'package:flutter/material.dart';

///
///
///
class MyDivider extends StatelessWidget {
  final double height;
  final Color color;

  ///
  ///
  ///
  const MyDivider({
    Key key,
    this.height = 1.0,
    this.color = Colors.black38,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: color,
    );
  }
}
