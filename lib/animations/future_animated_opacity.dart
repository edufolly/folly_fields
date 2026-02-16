import 'package:flutter/material.dart';

class FutureAnimatedOpacity extends StatelessWidget {
  final Duration delay;
  final double initialOpacity;
  final double finalOpacity;
  final Curve curve;
  final Duration animationDuration;
  final VoidCallback? onEnd;
  final bool alwaysIncludeSemantics;
  final Widget child;

  const FutureAnimatedOpacity({
    required this.child,
    required this.delay,
    required this.initialOpacity,
    required this.finalOpacity,
    required this.animationDuration,
    this.curve = Curves.linear,
    this.onEnd,
    this.alwaysIncludeSemantics = false,
    super.key,
  });

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

class FutureAppear extends FutureAnimatedOpacity {
  const FutureAppear({
    required super.child,
    required super.delay,
    required super.animationDuration,
    super.curve,
    super.onEnd,
    super.alwaysIncludeSemantics,
    super.key,
  }) : super(initialOpacity: 0, finalOpacity: 1);
}

class FutureDisappear extends FutureAnimatedOpacity {
  const FutureDisappear({
    required super.child,
    required super.delay,
    required super.animationDuration,
    super.curve,
    super.onEnd,
    super.alwaysIncludeSemantics,
    super.key,
  }) : super(initialOpacity: 1, finalOpacity: 0);
}
