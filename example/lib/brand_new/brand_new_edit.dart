import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_edit.dart';
import 'package:folly_fields/fields/string_field.dart';
import 'package:folly_fields/responsive/responsive.dart';
import 'package:folly_fields/util/folly_validators.dart';
import 'package:folly_fields_example/brand_new/brand_new_builder.dart';
import 'package:folly_fields_example/brand_new/brand_new_consumer.dart';
import 'package:folly_fields_example/brand_new/brand_new_edit_controller.dart';
import 'package:folly_fields_example/brand_new/brand_new_model.dart';

///
///
///
class BrandNewEdit extends AbstractEdit<BrandNewModel, BrandNewBuilder,
    BrandNewConsumer, BrandNewEditController> {
  ///
  ///
  ///
  const BrandNewEdit(
      BrandNewModel model,
      BrandNewBuilder uiBuilder,
      BrandNewConsumer consumer,
      BrandNewEditController editController,
      bool edit,
      {Key? key})
      : super(
          model,
          uiBuilder,
          consumer,
          edit,
          editController: editController,
          key: key,
        );

  ///
  ///
  ///
  @override
  List<Responsive> formContent(
    BuildContext context,
    BrandNewModel model,
    bool edit,
    String prefix,
    Function(bool refresh) refresh,
    BrandNewEditController? editController,
  ) {
    return <Responsive>[
      StringField(
        prefix: prefix,
        label: 'Nome*',
        enabled: edit,
        initialValue: model.name,
        validator: FollyValidators.stringNotEmpty,
        onSaved: (String value) => model.name = value,
      ),
    ];
  }
}
