import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_function.dart';
import 'package:folly_fields/fields/string_field.dart';
import 'package:folly_fields/widgets/folly_divider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
class ExampleMapModel {
  Map<String, String> originalMap;
  String? test;

  ///
  ///
  ///
  ExampleMapModel({this.originalMap = const <String, String>{}});

  ///
  ///
  ///
  ExampleMapModel.fromMap(Map<String, String> map)
      : test = map['test'],
        originalMap = Map<String, String>.of(map);

  ///
  ///
  ///
  Map<String, String> toMap() {
    Map<String, String> map = <String, String>{};
    if (test != null) {
      map['test'] = test!;
    }
    return map;
  }
}

///
///
///
class ExampleMapFunctionRoute extends MapFunction {
  final ExampleMapModel? model;

  ///
  ///
  ///
  const ExampleMapFunctionRoute({
    this.model,
    super.key,
  });

  ///
  ///
  ///
  @override
  List<String> get routeName => const <String>['example_map_function_route'];

  ///
  ///
  ///
  @override
  Future<Widget> onPressed(
    BuildContext context,
    Map<String, String> map, {
    required bool selection,
  }) async =>
      ExampleMapFunctionRoute(
        model: ExampleMapModel.fromMap(map),
      );

  ///
  ///
  ///
  @override
  State<ExampleMapFunctionRoute> createState() =>
      _ExampleMapFunctionRouteState();
}

///
///
///
class _ExampleMapFunctionRouteState extends State<ExampleMapFunctionRoute> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ExampleMapModel _stateModel = ExampleMapModel();

  ///
  ///
  ///
  ExampleMapModel get model => widget.model ?? _stateModel;

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example Map Function Route'),
        actions: <Widget>[
          IconButton(
            onPressed: _save,
            icon: const FaIcon(FontAwesomeIcons.check),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: StringField(
                label: 'Campo de Teste',
                initialValue: model.test,
                onSaved: (String? value) =>
                    model.test = value == null || value.isEmpty ? null : value,
              ),
            ),
          ),
          Expanded(
            child: model.originalMap.isNotEmpty
                ? ListView.separated(
                    itemBuilder: (BuildContext context, int index) => ListTile(
                      title: Text(
                        'Key: ${model.originalMap.keys.elementAt(index)} - '
                        'Value: ${model.originalMap.values.elementAt(index)}',
                      ),
                    ),
                    separatorBuilder: (_, __) => const FollyDivider(),
                    itemCount: model.originalMap.keys.length,
                  )
                : const Center(
                    child: Text('Nenhum parâmetro informado.'),
                  ),
          ),
        ],
      ),
    );
  }

  ///
  ///
  ///
  void _save() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.of(context).pop(model.toMap());
    }
  }
}
