import 'dart:math' as math;

import 'package:flutter/material.dart';

@Deprecated('Should I remove?')
class ResponsiveLogo extends StatelessWidget {
  final String path;
  final double min;
  final double max;
  final double percent;

  const ResponsiveLogo({
    required this.path,
    this.min = 430,
    this.max = double.maxFinite,
    this.percent = 0.5,
    super.key,
  });

  @override
  Widget build(final BuildContext context) => Image.asset(
    path,
    width: math.min(
      math.max(MediaQuery.of(context).size.width * percent, min),
      max,
    ),
  );
}
