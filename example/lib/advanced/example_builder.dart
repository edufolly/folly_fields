import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_ui_builder.dart';
import 'package:folly_fields_example/example_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
class ExampleBuilder extends AbstractUIBuilder<ExampleModel> {
  ///
  ///
  ///
  const ExampleBuilder({
    super.labelPrefix,
    super.labelSuffix,
  });

  ///
  ///
  ///
  @override
  String single(_) => 'Exemplo';

  ///
  ///
  ///
  @override
  String plural(_) => 'Exemplos';

  ///
  ///
  ///
  @override
  Widget getLeading(_, ExampleModel model) => Icon(
        FontAwesomeIcons.solidCircle,
        color: (model.integer).isEven ? Colors.red : Colors.green,
      );

  ///
  ///
  ///
  @override
  Widget getTitle(_, ExampleModel model) => Text(model.text);

  ///
  ///
  ///
  @override
  Widget getSubtitle(_, ExampleModel model) => Text(model.email);

  ///
  ///
  ///
  @override
  Map<String, Color> listLegend(_) => const <String, Color>{
        'Par': Colors.red,
        'Impar': Colors.green,
      };
}
