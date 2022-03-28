import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_edit_content.dart';
import 'package:folly_fields/crud/empty_edit_controller.dart';
import 'package:folly_fields/fields/string_field.dart';
import 'package:folly_fields/responsive/responsive.dart';
import 'package:folly_fields_example/brand_new/brand_new_model.dart';

///
///
///
class BrandNewEditPanel3 extends AbstractEditContent<BrandNewModel,
    EmptyEditController<BrandNewModel>> {
  ///
  ///
  ///
  @override
  List<Responsive> formContent(
    BuildContext context,
    BrandNewModel model,
    bool edit,
    String labelPrefix,
    GlobalKey<FormState> formKey,
    Function(bool refresh) refresh,
    _,
  ) {
    return <Responsive>[
      const ResponsiveDecorator(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text('Panel 3'),
        ),
      ),

      ///
      ///
      ///
      StringField(
        key: const Key('Test3'),
        labelPrefix: labelPrefix,
        label: 'Nome*',
        enabled: edit,
        initialValue: model.specific3 ?? model.type.toString(),
        onSaved: (String value) => model.specific3 = value,
      ),
    ];
  }
}
