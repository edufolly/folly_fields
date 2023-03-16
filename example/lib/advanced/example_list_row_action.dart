import 'package:flutter/material.dart';
import 'package:folly_fields_example/example_model.dart';

///
///
///
class ExampleListRowAction extends StatefulWidget {
  final ExampleModel model;

  ///
  ///
  ///
  const ExampleListRowAction({required this.model, super.key});

  ///
  ///
  ///
  @override
  State<ExampleListRowAction> createState() => _ExampleListRowActionState();
}

///
///
///
class _ExampleListRowActionState extends State<ExampleListRowAction> {
  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example Model Function Route'),
      ),
      body: Center(
        child: Text(widget.model.email),
      ),
    );
  }
}
