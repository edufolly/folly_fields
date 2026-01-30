import 'dart:async';

import 'package:flutter/material.dart';

class FollyDialogs {
  static Future<void> dialogMessage({
    required final BuildContext context,
    required final String? message,
    final String title = 'Atenção',
    final String buttonText = 'OK',
    final String defaultMessage = 'Ocorreu um erro.',
    final bool scrollable = false,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (final BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SelectableText(message ?? defaultMessage),
          scrollable: scrollable,
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(buttonText),
            ),
          ],
        );
      },
    );
  }

  static Future<String> dialogText({
    required final BuildContext context,
    required final String title,
    required final String message,
    final String confirmLabel = 'OK',
    final String cancelLabel = 'CANCELAR',
    final String startString = '',
    final TextInputType keyboardType = TextInputType.text,
    final bool scrollable = false,
  }) async {
    TextEditingController controller = TextEditingController()
      ..text = startString;

    controller.selection = TextSelection(
      baseOffset: 0,
      extentOffset: controller.text.length,
    );

    String? value = await showDialog(
      context: context,
      builder: (final BuildContext context) {
        return AlertDialog(
          title: Text(title),
          scrollable: scrollable,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
                child: SelectableText(
                  message,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: controller,
                  keyboardType: keyboardType,
                  autofocus: true,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(cancelLabel),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(controller.text),
              child: Text(confirmLabel),
            ),
          ],
        );
      },
    );

    return value ?? '';
  }

  static Future<bool> yesNoDialog({
    required final BuildContext context,
    required final String message,
    final String title = 'Atenção',
    final String affirmative = 'Sim',
    final String negative = 'Não',
    final bool marked = false,
    final bool scrollable = false,
  }) async {
    Widget aff;
    Widget neg;

    if (marked) {
      aff = ElevatedButton(
        onPressed: () => Navigator.of(context).pop(true),
        child: Text(affirmative),
      );

      neg = TextButton(
        onPressed: () => Navigator.of(context).pop(false),
        child: Text(negative),
      );
    } else {
      aff = TextButton(
        onPressed: () => Navigator.of(context).pop(true),
        child: Text(affirmative),
      );

      neg = ElevatedButton(
        onPressed: () => Navigator.of(context).pop(false),
        child: Text(negative),
      );
    }

    bool? value = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (final BuildContext context) => AlertDialog(
        title: Text(title),
        content: SelectableText(message),
        scrollable: scrollable,
        actions: <Widget>[neg, aff],
      ),
    );

    return value ?? false;
  }
}
