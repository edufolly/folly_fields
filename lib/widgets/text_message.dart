import 'package:flutter/material.dart';

@Deprecated('Refactor this class.')
class TextMessage extends StatelessWidget {
  final String message;

  const TextMessage(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(child: Text(message, textAlign: TextAlign.center)),
    );
  }
}
