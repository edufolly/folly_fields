import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_edit.dart';
import 'package:folly_fields/crud/empty_edit_controller.dart';
import 'package:folly_fields/fields/dropdown_field.dart';
import 'package:folly_fields/fields/string_field.dart';
import 'package:folly_fields/responsive/responsive.dart';
import 'package:folly_fields/util/folly_validators.dart';
import 'package:folly_fields_example/brand_new/brand_new_builder.dart';
import 'package:folly_fields_example/brand_new/brand_new_consumer.dart';
import 'package:folly_fields_example/brand_new/brand_new_edit_panel_1.dart';
import 'package:folly_fields_example/brand_new/brand_new_edit_panel_2.dart';
import 'package:folly_fields_example/brand_new/brand_new_edit_panel_3.dart';
import 'package:folly_fields_example/brand_new/brand_new_enum.dart';
import 'package:folly_fields_example/brand_new/brand_new_model.dart';

///
///
///
class BrandNewEdit extends AbstractEdit<BrandNewModel, BrandNewBuilder,
    BrandNewConsumer, EmptyEditController<BrandNewModel>> {
  ///
  ///
  ///
  const BrandNewEdit(
    super.model,
    super.uiBuilder,
    super.consumer, {
    required super.edit,
    super.key,
  });

  ///
  ///
  ///
  @override
  List<Responsive> formContent(
    BuildContext context,
    BrandNewModel model,
    String labelPrefix,
    Function(bool refresh) refresh,
    bool Function() fromValidate,
    EmptyEditController<BrandNewModel> editController, {
    required bool edit,
  }) {
    return <Responsive>[
      /// Name
      StringField(
        labelPrefix: labelPrefix,
        label: 'Nome*',
        enabled: edit,
        initialValue: model.name,
        validator: FollyValidators.stringNotEmpty,
        onSaved: (String? value) => model.name = value ?? '',
      ),

      /// Type
      DropdownField<BrandNewEnum>(
        labelPrefix: labelPrefix,
        label: 'Tipo*',
        enabled: edit,
        items: BrandNewEnum.items,
        initialValue: model.type,
        validator: FollyValidators.notNull,
        onChanged: (BrandNewEnum? value) {
          model.type = value ?? BrandNewEnum.panel1;
          refresh(true);
        },
        onSaved: (BrandNewEnum? value) => model.type = value!,
      ),

      /// Panel
      ...complement(
        context,
        model,
        labelPrefix,
        refresh,
        fromValidate,
        editController,
        edit: edit,
      ),
    ];
  }

  ///
  ///
  ///
  List<Responsive> complement(
    BuildContext context,
    BrandNewModel model,
    String labelPrefix,
    Function(bool refresh) refresh,
    bool Function() formValidate,
    EmptyEditController<BrandNewModel> editController, {
    required bool edit,
  }) {
    switch (model.type) {
      case BrandNewEnum.panel1:
        return BrandNewEditPanel1().formContent(
          context,
          model,
          labelPrefix,
          refresh,
          formValidate,
          editController,
          edit: edit,
        );
      case BrandNewEnum.panel2:
        return BrandNewEditPanel2().formContent(
          context,
          model,
          labelPrefix,
          refresh,
          formValidate,
          editController,
          edit: edit,
        );
      case BrandNewEnum.panel3:
        return BrandNewEditPanel3().formContent(
          context,
          model,
          labelPrefix,
          refresh,
          formValidate,
          editController,
          edit: edit,
        );
    }
  }
}
