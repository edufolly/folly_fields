import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_edit.dart';
import 'package:folly_fields/crud/empty_edit_controller.dart';
import 'package:folly_fields/fields/dropdown_field.dart';
import 'package:folly_fields/fields/string_field.dart';
import 'package:folly_fields/responsive/responsive.dart';
import 'package:folly_fields/responsive/responsive_decorator.dart';
import 'package:folly_fields/util/folly_validators.dart';
import 'package:folly_fields_example/brand_new/brand_new_builder.dart';
import 'package:folly_fields_example/brand_new/brand_new_consumer.dart';
import 'package:folly_fields_example/brand_new/brand_new_enum.dart';
import 'package:folly_fields_example/brand_new/brand_new_model.dart';

///
///
///
class BrandNewEdit extends AbstractEdit<BrandNewModel, BrandNewBuilder,
    BrandNewConsumer, EmptyEditController<BrandNewModel, int>, int> {
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
    BrandNewModel model, {
    required bool edit,
    bool Function()? formValidate,
    void Function({required bool refresh})? refresh,
  }) {
    return <Responsive>[
      /// Name
      StringField(
        labelPrefix: uiBuilder.labelPrefix,
        label: 'Nome*',
        enabled: edit,
        initialValue: model.name,
        validator: FollyValidators.stringNotEmpty,
        onSaved: (String? value) => model.name = value ?? '',
      ),

      /// Type
      DropdownField<BrandNewEnum>(
        labelPrefix: uiBuilder.labelPrefix,
        label: 'Tipo*',
        enabled: edit,
        items: BrandNewEnum.items,
        initialValue: model.type,
        validator: FollyValidators.notNull,
        onChanged: (BrandNewEnum? value) {
          model.type = value ?? BrandNewEnum.panel1;
          refresh?.call(refresh: true);
        },
        onSaved: (BrandNewEnum? value) => model.type = value!,
      ),

      /// Panel1
      if (model.type == BrandNewEnum.panel1) ...<Responsive>[
        const ResponsiveDecorator(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text('Panel 1'),
          ),
        ),
        StringField(
          key: const Key('Test1'),
          label: 'Nome*',
          enabled: edit,
          initialValue: model.specific1 ?? model.type.toString(),
          onSaved: (String? value) => model.specific1 = value,
        ),
      ]

      /// Panel2
      else if (model.type == BrandNewEnum.panel2) ...<Responsive>[
        const ResponsiveDecorator(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text('Panel 2'),
          ),
        ),
        StringField(
          key: const Key('Test2'),
          label: 'Nome*',
          enabled: edit,
          initialValue: model.specific2 ?? model.type.toString(),
          onSaved: (String? value) => model.specific2 = value,
        ),
      ]

      /// Panel3
      else if (model.type == BrandNewEnum.panel3) ...<Responsive>[
        const ResponsiveDecorator(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text('Panel 3'),
          ),
        ),
        StringField(
          key: const Key('Test3'),
          label: 'Nome*',
          enabled: edit,
          initialValue: model.specific3 ?? model.type.toString(),
          onSaved: (String? value) => model.specific3 = value,
        ),
      ],
    ];
  }
}
