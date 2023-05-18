import 'package:flutter/material.dart';
import 'package:folly_fields/widgets/folly_dialogs.dart';
import 'package:folly_fields_example/advanced/base_consumer_mock.dart';
import 'package:folly_fields_example/brand_new/brand_new_model.dart';

///
///
///
class BrandNewConsumer extends BaseConsumerMock<BrandNewModel> {
  ///
  ///
  ///
  BrandNewConsumer() : super(<String>[]);

  ///
  ///
  ///
  @override
  BrandNewModel fromJson(Map<String, dynamic> map) =>
      BrandNewModel.fromJson(map);

  ///
  ///
  ///
  @override
  Future<bool> beforeSaveOrUpdate(
    BuildContext context,
    BrandNewModel model, {
    Map<String, String> extraParams = const <String, String>{},
  }) async {
    await FollyDialogs.dialogMessage(
      context: context,
      message: model.toMap().toString(),
    );

    return true;
  }
}
