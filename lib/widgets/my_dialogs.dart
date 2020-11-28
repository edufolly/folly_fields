import 'dart:async';

import 'package:flutter/material.dart';

///
///
///
class MyDialogs {
  ///
  ///
  ///
  static Future<bool> dialogMessage({
    @required BuildContext context,
    @required String message,
    String title = 'Atenção',
    String buttonText = 'OK',
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            RaisedButton(
              child: Text(
                buttonText,
              ),
              onPressed: () => Navigator.of(context).pop(true),
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
    @required BuildContext context,
    @required String title,
    @required String message,
    String confirmLabel = 'OK',
    String cancelLabel = 'CANCELAR',
    String startString = '',
    TextInputType keyboardType = TextInputType.text,
  }) {
    final TextEditingController _controller = TextEditingController();

    _controller.text = startString;

    _controller.selection = TextSelection(
      baseOffset: 0,
      extentOffset: _controller.text.length,
    );

    return showDialog(
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
                  style: TextStyle(fontSize: 18.0),
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
            RaisedButton(
              child: Text(cancelLabel),
              onPressed: () => Navigator.of(context).pop(null),
            ),
            FlatButton(
              child: Text(confirmLabel),
              onPressed: () => Navigator.of(context).pop(_controller.text),
            ),
          ],
        );
      },
    );
  }

  ///
  ///
  ///
  static Future<bool> yesNoDialog({
    @required BuildContext context,
    String title = 'Atenção',
    @required String message,
    String affirmative = 'Sim',
    String negative = 'Não',
    bool marked = false,
  }) {
    Widget aff;
    Widget neg;

    if (marked) {
      aff = RaisedButton(
        onPressed: () => Navigator.of(context).pop(true),
        child: Text(
          affirmative,
          style: const TextStyle(color: Colors.white),
        ),
        color: Theme.of(context).accentColor,
      );

      neg = FlatButton(
        onPressed: () => Navigator.of(context).pop(false),
        child: Text(negative),
      );
    } else {
      aff = FlatButton(
        onPressed: () => Navigator.of(context).pop(true),
        child: Text(affirmative),
      );

      neg = RaisedButton(
        onPressed: () => Navigator.of(context).pop(false),
        child: Text(
          negative,
          style: const TextStyle(color: Colors.white),
        ),
        color: Theme.of(context).accentColor,
      );
    }

    return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[neg, aff],
          ),
        ) ??
        false;
  }
}
