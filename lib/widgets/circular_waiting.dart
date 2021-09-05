import 'dart:async';

import 'package:flutter/material.dart';

///
///
///
class CircularWaiting {
  final BuildContext context;
  final StreamController<Map<String, dynamic>> _streamController =
      StreamController<Map<String, dynamic>>();

  String message;
  double? value;
  bool closeable;
  bool _show = false;

  ///
  ///
  ///
  CircularWaiting(
    this.context, {
    this.message = 'Aguarde',
    this.closeable = false,
  }) {
    _streamController.add(<String, dynamic>{
      'message': message,
      'value': value,
    });
  }

  ///
  ///
  ///
  void show() async {
    _show = true;
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => WillPopScope(
        onWillPop: _onWillPop,
        child: Dialog(
          child: StreamBuilder<Map<String, dynamic>>(
            stream: _streamController.stream,
            builder: (
              BuildContext context,
              AsyncSnapshot<Map<String, dynamic>> snapshot,
            ) {
              String msg = message;
              double? dbl;
              if (snapshot.hasData) {
                msg = snapshot.data!['message'];
                dbl = snapshot.data!['value'];
              }

              return Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CircularProgressIndicator(
                      value: dbl,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text(
                        msg,
                        style: const TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  ///
  ///
  ///
  void close() {
    if (_show) {
      _show = false;
      closeable = true;
      Navigator.of(context).pop();
    }
  }

  ///
  ///
  ///
  void sendMessage(String msg) {
    message = msg;
    _send();
  }

  ///
  ///
  ///
  void sendValue(double dbl) {
    value = dbl;
    _send();
  }

  ///
  ///
  ///
  void _send() {
    if (!_streamController.isClosed) {
      _streamController.add(<String, dynamic>{
        'message': message,
        'value': value,
      });
    }
  }

  ///
  ///
  ///
  Future<bool> _onWillPop() async {
    if (closeable) await _streamController.close();
    return closeable;
  }
}
