import 'package:flutter/material.dart';

///
///
///
class FutureAppear extends FutureAnimatedOpacity {
  ///
  ///
  ///
  const FutureAppear({
    Key? key,
    required Duration delay,
    Curve curve = Curves.linear,
    required Duration animationDuration,
    VoidCallback? onEnd,
    bool alwaysIncludeSemantics = false,
    required Widget child,
  }) : super(
          key: key,
          delay: delay,
          initialOpacity: 0.0,
          finalOpacity: 1.0,
          curve: curve,
          animationDuration: animationDuration,
          onEnd: onEnd,
          alwaysIncludeSemantics: alwaysIncludeSemantics,
          child: child,
        );
}

///
///
///
class FutureDisappear extends FutureAnimatedOpacity {
  ///
  ///
  ///
  const FutureDisappear({
    Key? key,
    required Duration delay,
    Curve curve = Curves.linear,
    required Duration animationDuration,
    VoidCallback? onEnd,
    bool alwaysIncludeSemantics = false,
    required Widget child,
  }) : super(
          key: key,
          delay: delay,
          initialOpacity: 1.0,
          finalOpacity: 0.0,
          curve: curve,
          animationDuration: animationDuration,
          onEnd: onEnd,
          alwaysIncludeSemantics: alwaysIncludeSemantics,
          child: child,
        );
}

///
///
///
class FutureAnimatedOpacity extends StatelessWidget {
  final Duration delay;
  final double initialOpacity;
  final double finalOpacity;
  final Curve curve;
  final Duration animationDuration;
  final VoidCallback? onEnd;
  final bool alwaysIncludeSemantics;
  final Widget child;

  ///
  ///
  ///
  const FutureAnimatedOpacity({
    Key? key,
    required this.delay,
    required this.initialOpacity,
    required this.finalOpacity,
    this.curve = Curves.linear,
    required this.animationDuration,
    this.onEnd,
    this.alwaysIncludeSemantics = false,
    required this.child,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double>(
      initialData: initialOpacity,
      future: Future<double>.delayed(delay, () => finalOpacity),
      builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
        return AnimatedOpacity(
          opacity: snapshot.data ?? initialOpacity,
          duration: animationDuration,
          curve: curve,
          onEnd: onEnd,
          alwaysIncludeSemantics: alwaysIncludeSemantics,
          child: child,
        );
      },
    );
  }
}
