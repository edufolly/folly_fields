import 'package:flutter/src/widgets/framework.dart';
import 'package:folly_fields/crud/abstract_consumer.dart';

import 'mock_int_model.dart';

///
///
///
class MockIntConsumer extends AbstractConsumer<MockIntModel, int> {
  ///
  ///
  ///
  const MockIntConsumer() : super(const <String>['mock', 'int']);

  ///
  ///
  ///
  @override
  MockIntModel fromJson(Map<String, dynamic> map) => MockIntModel.fromJson(map);

  ///
  ///
  ///
  @override
  Future<ConsumerPermission> checkPermission(
    BuildContext context,
    List<String> paths,
  ) async =>
      const ConsumerPermission.allowAll(name: 'Mock Int');

  ///
  ///
  ///
  @override
  Future<MockIntModel?> getById(
    BuildContext context,
    MockIntModel model, {
    Map<String, String> extraParams = const <String, String>{},
  }) {
    // TODO(edufolly): implement getById
    throw UnimplementedError();
  }

  ///
  ///
  ///
  @override
  Future<List<MockIntModel>> list(
    BuildContext context, {
    int page = 0,
    int size = 20,
    Map<String, String> extraParams = const <String, String>{},
    bool forceOffline = false,
  }) {
    // TODO(edufolly): implement list
    throw UnimplementedError();
  }

  ///
  ///
  ///
  @override
  Future<bool> delete(
    BuildContext context,
    MockIntModel model, {
    Map<String, String> extraParams = const <String, String>{},
  }) async =>
      true;

  ///
  ///
  ///
  @override
  Future<MockIntModel> saveOrUpdate(
    BuildContext context,
    MockIntModel model, {
    Map<String, String> extraParams = const <String, String>{},
  }) async {
    model.id = model.hashCode;
    return model;
  }
}
