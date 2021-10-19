import 'package:flutter/material.dart';
import 'package:folly_fields/folly_fields.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
class ErrorMessage extends StatelessWidget {
  final Object? error;
  final StackTrace? stackTrace;
  final IconData icon;

  ///
  ///
  ///
  const ErrorMessage({
    this.error = 'Ocorreu um erro.',
    this.stackTrace,
    this.icon = FontAwesomeIcons.exclamationTriangle,
    Key? key,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    if (FollyFields().isDebug) {
      // ignore: avoid_print
      print(error);
      // ignore: avoid_print
      print(stackTrace);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(12),
          child: Icon(icon),
        ),
        Center(
          child: Text(error.toString()),
        ),
      ],
    );
  }
}
