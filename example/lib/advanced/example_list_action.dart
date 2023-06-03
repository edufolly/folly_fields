import 'package:flutter/material.dart';
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
    final Map<String, String> map = <String, String>{};
    if (test != null) {
      map['test'] = test!;
    }
    return map;
  }
}

///
///
///
class ExampleListAction extends StatefulWidget {
  final ExampleMapModel model;

  ///
  ///
  ///
  const ExampleListAction({
    required this.model,
    super.key,
  });

  ///
  ///
  ///
  @override
  State<ExampleListAction> createState() => _ExampleListActionState();
}

class _ExampleListActionState extends State<ExampleListAction> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                initialValue: widget.model.test,
                onSaved: (String? value) => widget.model.test =
                    value == null || value.isEmpty ? null : value,
              ),
            ),
          ),
          Expanded(
            child: widget.model.originalMap.isNotEmpty
                ? ListView.separated(
                    itemBuilder: (BuildContext context, int index) => ListTile(
                      title: Text(
                        'Key: '
                        '${widget.model.originalMap.keys.elementAt(index)} - '
                        'Value: '
                        '${widget.model.originalMap.values.elementAt(index)}',
                      ),
                    ),
                    separatorBuilder: (_, __) => const FollyDivider(),
                    itemCount: widget.model.originalMap.keys.length,
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
      Navigator.of(context).pop(widget.model.toMap());
    }
  }
}
