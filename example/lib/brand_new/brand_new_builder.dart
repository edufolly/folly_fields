import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_ui_builder.dart';
import 'package:folly_fields_example/brand_new/brand_new_model.dart';

///
///
///
class BrandNewBuilder extends AbstractUIBuilder<BrandNewModel> {
  ///
  ///
  ///
  const BrandNewBuilder([String prefix = '']) : super(prefix);

  ///
  ///
  ///
  @override
  String getInternalPlural() => 'Brand New';

  ///
  ///
  @override
  String getInternalSingle() => 'Brand News';

  ///
  ///
  ///
  @override
  Widget getTitle(BrandNewModel model) => Text(model.name);
}
