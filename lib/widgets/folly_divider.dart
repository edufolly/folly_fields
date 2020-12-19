import 'package:flutter/material.dart';

///
///
///
class FollyDivider extends StatelessWidget {
  final double height;
  final Color color;

  ///
  ///
  ///
  const FollyDivider({
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
