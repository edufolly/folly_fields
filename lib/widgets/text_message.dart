import 'package:flutter/material.dart';

///
///
///
class TextMessage extends StatelessWidget {
  final String message;

  ///
  ///
  ///
  const TextMessage(
    this.message, {
    Key? key,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          message,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
