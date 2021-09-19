import 'package:flutter/material.dart';

///
///
///
class HeaderCell extends StatelessWidget {
  final int flex;
  final Widget child;

  ///
  ///
  ///
  const HeaderCell({
    required this.child,
    this.flex = 1,
    Key? key,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        child: SizedBox(
          width: double.infinity,
          child: child,
        ),
      ),
    );
  }
}
