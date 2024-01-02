import 'dart:async';

import 'package:flutter/material.dart';

///
///
///
class CircularWaiting {
  final BuildContext context;
  final bool barrierDismissible;
  final StreamController<Map<String, dynamic>> _streamController =
      StreamController<Map<String, dynamic>>();

  String message;
  String? subtitle;
  double? value;

  bool _closeable = false;
  bool _show = false;
  bool _alreadyPopped = false;

  ///
  ///
  ///
  CircularWaiting(
    this.context, {
    this.barrierDismissible = false,
    this.message = 'Aguarde',
    this.subtitle,
  }) {
    _closeable = barrierDismissible;
    _streamController.add(<String, dynamic>{
      'message': message,
      'subtitle': subtitle,
      'value': value,
    });
  }

  ///
  ///
  ///
  void show() {
    _show = true;
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) => PopScope(
        canPop: false,
        onPopInvoked: (_) {
          if (_alreadyPopped) {
            return;
          }

          if (_closeable) {
            _streamController.close();
            _alreadyPopped = true;
            Navigator.of(context).pop();
          }
        },
        child: Dialog(
          child: StreamBuilder<Map<String, dynamic>>(
            stream: _streamController.stream,
            builder: (
              BuildContext context,
              AsyncSnapshot<Map<String, dynamic>> snapshot,
            ) {
              String msg = message;
              String? sub = subtitle;
              double? dbl;

              if (snapshot.hasData) {
                msg = snapshot.data!['message'];
                sub = snapshot.data!['subtitle'];
                dbl = snapshot.data!['value'];
              }

              return Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CircularProgressIndicator(
                      value: dbl,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Column(
                        children: <Widget>[
                          Text(
                            msg,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          if (sub != null && sub.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                sub,
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
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
      _alreadyPopped = true;
      _show = false;
      _closeable = true;
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
}
