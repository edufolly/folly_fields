import 'dart:async';

import 'package:flutter/material.dart';

///
///
///
class CircularWaiting {
  final BuildContext context;
  String message;
  double value;
  bool closeable;
  StreamController<Map<String, dynamic>> _streamController;
  bool _show = false;

  ///
  ///
  ///
  CircularWaiting(
    this.context, {
    this.message = 'Aguarde',
    this.closeable = false,
  }) {
    _streamController = StreamController<Map<String, dynamic>>();
    _streamController.add(<String, dynamic>{
      'message': message,
      'value': value,
    });
  }

  ///
  ///
  ///
  void show() async {
    if (context == null) return;
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
              String msg;
              double dbl;
              if (snapshot.hasData) {
                msg = snapshot.data['message'];
                dbl = snapshot.data['value'];
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
                      padding: EdgeInsets.only(top: 12.0),
                      child: Text(
                        msg ?? '',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
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
      if (context != null) Navigator.of(context).pop();
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
    if (closeable) {
      await _streamController.close();
    }
    return closeable;
  }
}
