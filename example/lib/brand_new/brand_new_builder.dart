import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_builder.dart';
import 'package:folly_fields_example/brand_new/brand_new_model.dart';

///
///
///
class BrandNewBuilder extends AbstractBuilder<BrandNewModel, int> {
  ///
  ///
  ///
  const BrandNewBuilder();

  ///
  ///
  ///
  @override
  String single(_) => 'Brand New';

  ///
  ///
  @override
  String plural(_) => 'Brand News';

  ///
  ///
  ///
  @override
  Widget getTitle(_, BrandNewModel model) => Text(model.name);
}
