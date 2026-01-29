import 'package:flutter/material.dart';

class FollyCircular extends StatelessWidget {
  final Color? color;
  final double size;

  const FollyCircular({super.key, this.color, this.size = 16.0});

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: SizedBox(
        width: size,
        // ignore: no-equal-arguments
        height: size,
        child: FittedBox(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              color ?? Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
