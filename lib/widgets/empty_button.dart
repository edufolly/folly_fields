import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
class EmptyButton extends StatelessWidget {
  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 0,
      child: IconButton(
        icon: FaIcon(
          FontAwesomeIcons.trashAlt,
          color: Colors.transparent,
        ),
        onPressed: null,
      ),
    );
  }
}
