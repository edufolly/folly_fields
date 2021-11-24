import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_function.dart';
import 'package:folly_fields/widgets/folly_divider.dart';

///
///
///
class ExampleMapFunctionRoute extends MapFunction {
  ///
  ///
  ///
  const ExampleMapFunctionRoute({Key? key}) : super(key: key);

  ///
  ///
  ///
  @override
  List<String> get routeName => const <String>['example_map_function_route'];

  ///
  ///
  ///
  @override
  _ExampleMapFunctionRouteState createState() =>
      _ExampleMapFunctionRouteState();
}

///
///
///
class _ExampleMapFunctionRouteState extends State<ExampleMapFunctionRoute> {
  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    Map<String, String>? qsParam =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>?;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Example Map Function Route'),
      ),
      body: qsParam != null
          ? ListView.separated(
              itemBuilder: (BuildContext context, int index) => ListTile(
                title: Text('Key: ${qsParam.keys.elementAt(index)} - '
                    'Value: ${qsParam.values.elementAt(index)}'),
              ),
              separatorBuilder: (_, __) => const FollyDivider(),
              itemCount: qsParam.keys.length,
            )
          : const Center(
              child: Text('Nenhum parâmetro informado.'),
            ),
    );
  }
}
