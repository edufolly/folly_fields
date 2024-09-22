import 'package:flutter/widgets.dart';

///
///
///
class BasicTablePaginationController {
  final TextEditingController _controller;

  ///
  ///
  ///
  BasicTablePaginationController()
      : _controller = TextEditingController(text: '1');

  ///
  ///
  ///
  TextEditingController get controller => _controller;

  ///
  ///
  ///
  int get currentPage => int.tryParse(_controller.text) ?? 1;

  ///
  ///
  ///
  set currentPage(int value) => _controller.text = value.toString();

  ///
  ///
  ///
  void reset() => _controller.text = '1';

  ///
  ///
  ///
  void dispose() {
    _controller.dispose();
  }
}
