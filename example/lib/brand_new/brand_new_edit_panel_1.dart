import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_edit_content.dart';
import 'package:folly_fields/crud/empty_edit_controller.dart';
import 'package:folly_fields/fields/string_field.dart';
import 'package:folly_fields/responsive/responsive.dart';
import 'package:folly_fields/responsive/responsive_decorator.dart';
import 'package:folly_fields_example/brand_new/brand_new_model.dart';

///
///
///
class BrandNewEditPanel1 extends AbstractEditContent<BrandNewModel,
    EmptyEditController<BrandNewModel>> {
  ///
  ///
  ///
  @override
  List<Responsive> formContent(
    BuildContext context,
    BrandNewModel model,
    String labelPrefix,
    Function(bool refresh) refresh,
    _,
    __, {
    required bool edit,
  }) {
    return <Responsive>[
      const ResponsiveDecorator(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text('Panel 1'),
        ),
      ),

      ///
      ///
      ///
      StringField(
        key: const Key('Test1'),
        labelPrefix: labelPrefix,
        label: 'Nome*',
        enabled: edit,
        initialValue: model.specific1 ?? model.type.toString(),
        onSaved: (String? value) => model.specific1 = value,
      ),
    ];
  }
}
