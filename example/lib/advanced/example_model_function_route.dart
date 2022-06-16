import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_function.dart';
import 'package:folly_fields_example/example_model.dart';

///
///
///
class ExampleModelFunctionRoute extends ModelFunction<ExampleModel> {
  final ExampleModel? model;

  ///
  ///
  ///
  const ExampleModelFunctionRoute({this.model, super.key});

  ///
  ///
  ///
  @override
  List<String> get routeName => const <String>['example_model_function_route'];

  ///
  ///
  ///
  @override
  Future<Widget> onPressed(
    BuildContext context,
    ExampleModel object, {
    required bool selection,
  }) async =>
      ExampleModelFunctionRoute(model: object);

  ///
  ///
  ///
  @override
  _ExampleModelFunctionRouteState createState() =>
      _ExampleModelFunctionRouteState();
}

///
///
///
class _ExampleModelFunctionRouteState extends State<ExampleModelFunctionRoute> {
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
        child: Text(widget.model!.email),
      ),
    );
  }
}
