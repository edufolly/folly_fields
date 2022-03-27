import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
class EmptyButton extends StatelessWidget {
  ///
  ///
  ///
  const EmptyButton({Key? key}) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return const Flexible(
      flex: 0,
      child: IconButton(
        icon: FaIcon(
          FontAwesomeIcons.trashCan,
          color: Colors.transparent,
        ),
        onPressed: null,
      ),
    );
  }
}
