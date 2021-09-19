import 'package:flutter/material.dart';

///
///
///
class FutureAppear extends FutureAnimatedOpacity {
  ///
  ///
  ///
  const FutureAppear({
    required Widget child,
    required Duration delay,
    required Duration animationDuration,
    Curve curve = Curves.linear,
    VoidCallback? onEnd,
    bool alwaysIncludeSemantics = false,
    Key? key,
  }) : super(
          key: key,
          delay: delay,
          initialOpacity: 0,
          finalOpacity: 1,
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
    required Widget child,
    required Duration delay,
    required Duration animationDuration,
    Curve curve = Curves.linear,
    VoidCallback? onEnd,
    bool alwaysIncludeSemantics = false,
    Key? key,
  }) : super(
          key: key,
          delay: delay,
          initialOpacity: 1,
          finalOpacity: 0,
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
    required this.child,
    required this.delay,
    required this.initialOpacity,
    required this.finalOpacity,
    required this.animationDuration,
    this.curve = Curves.linear,
    this.onEnd,
    this.alwaysIncludeSemantics = false,
    Key? key,
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
