import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_function.dart';
import 'package:folly_fields/fields/string_field.dart';
import 'package:folly_fields/widgets/folly_divider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
class ExampleMapFunctionRoute extends MapFunction {
  ///
  ///
  ///
  const ExampleMapFunctionRoute({super.key});

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Map<String, String> qsParam;

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    qsParam =
        (ModalRoute.of(context)!.settings.arguments as Map<String, String>?) ??
            <String, String>{};

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
                initialValue: qsParam['test'],
                onSaved: (String value) => value.isEmpty
                    ? qsParam.remove('test')
                    : qsParam['test'] = value,
              ),
            ),
          ),
          Expanded(
            child: qsParam.isNotEmpty
                ? ListView.separated(
                    itemBuilder: (BuildContext context, int index) => ListTile(
                      title: Text(
                        'Key: ${qsParam.keys.elementAt(index)} - '
                        'Value: ${qsParam.values.elementAt(index)}',
                      ),
                    ),
                    separatorBuilder: (_, __) => const FollyDivider(),
                    itemCount: qsParam.keys.length,
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
      Navigator.of(context).pop(qsParam);
    }
  }
}
