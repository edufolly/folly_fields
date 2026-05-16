import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final Object? error;
  final StackTrace? stackTrace;
  final IconData icon;

  const ErrorMessage({
    this.error = 'Ocorreu um erro.',
    this.stackTrace,
    this.icon = Icons.info,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    debugPrintStack(label: error.toString(), stackTrace: stackTrace);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(padding: const EdgeInsets.all(12), child: Icon(icon)),
        Center(child: Text(error.toString())),
      ],
    );
  }
}
