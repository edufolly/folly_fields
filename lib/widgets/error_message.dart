import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
    this.icon = FontAwesomeIcons.triangleExclamation,
    Key? key,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(error);
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
