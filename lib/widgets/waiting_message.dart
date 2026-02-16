import 'package:flutter/material.dart';

class WaitingMessage extends StatelessWidget {
  final String? message;

  const WaitingMessage({this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.all(12),
          child: CircularProgressIndicator(),
        ),
        Center(child: Text(message ?? 'Aguarde...')),
      ],
    );
  }
}
