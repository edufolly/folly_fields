import 'dart:math' as math;

import 'package:flutter/material.dart';

///
///
///
class ResponsiveLogo extends StatelessWidget {
  final String path;
  final double min;
  final double max;
  final double percent;

  ///
  ///
  ///
  const ResponsiveLogo({
    Key? key,
    required this.path,
    this.min = 430,
    this.max = double.maxFinite,
    this.percent = 0.5,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    double responsive = MediaQuery.of(context).size.width * percent;

    return Image.asset(path, width: math.min(math.max(responsive, min), max));
  }
}
