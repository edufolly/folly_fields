import 'dart:async';

import 'package:flutter/material.dart';

///
///
///
class FollyDialogs {
  ///
  ///
  ///
  static Future<void> dialogMessage({
    required BuildContext context,
    required String? message,
    String title = 'Atenção',
    String buttonText = 'OK',
    String defaultMessage = 'Ocorreu um erro.',
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message ?? defaultMessage),
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

  ///
  ///
  ///
  static Future<String> dialogText({
    required BuildContext context,
    required String title,
    required String message,
    String confirmLabel = 'OK',
    String cancelLabel = 'CANCELAR',
    String startString = '',
    TextInputType keyboardType = TextInputType.text,
  }) async {
    final TextEditingController _controller = TextEditingController();

    _controller.text = startString;

    _controller.selection = TextSelection(
      baseOffset: 0,
      extentOffset: _controller.text.length,
    );

    String? value = await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 16.0,
                  left: 8.0,
                  right: 8.0,
                ),
                child: Text(
                  message,
                  style: const TextStyle(fontSize: 18.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _controller,
                  keyboardType: keyboardType,
                  autofocus: true,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(null),
              child: Text(cancelLabel),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(_controller.text),
              child: Text(confirmLabel),
            ),
          ],
        );
      },
    );

    return value ?? '';
  }

  ///
  ///
  ///
  static Future<bool> yesNoDialog({
    required BuildContext context,
    String title = 'Atenção',
    required String message,
    String affirmative = 'Sim',
    String negative = 'Não',
    bool marked = false,
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
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[neg, aff],
      ),
    );

    return value ?? false;
  }
}
