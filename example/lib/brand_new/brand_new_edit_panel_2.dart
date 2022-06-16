import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_edit_content.dart';
import 'package:folly_fields/crud/empty_edit_controller.dart';
import 'package:folly_fields/fields/string_field.dart';
import 'package:folly_fields/responsive/responsive.dart';
import 'package:folly_fields_example/brand_new/brand_new_model.dart';

///
///
///
class BrandNewEditPanel2 extends AbstractEditContent<BrandNewModel,
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
          child: Text('Panel 2'),
        ),
      ),

      ///
      ///
      ///
      StringField(
        key: const Key('Test2'),
        labelPrefix: labelPrefix,
        label: 'Nome*',
        enabled: edit,
        initialValue: model.specific2 ?? model.type.toString(),
        onSaved: (String value) => model.specific2 = value,
      ),
    ];
  }
}
