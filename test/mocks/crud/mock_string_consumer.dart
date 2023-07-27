import 'package:flutter/src/widgets/framework.dart';
import 'package:folly_fields/crud/abstract_consumer.dart';

import 'mock_string_model.dart';

///
///
///
class MockStringConsumer extends AbstractConsumer<MockStringModel, String> {
  ///
  ///
  ///
  const MockStringConsumer() : super(const <String>['mock', 'string']);

  ///
  ///
  ///
  @override
  MockStringModel fromJson(Map<String, dynamic> map) =>
      MockStringModel.fromJson(map);

  ///
  ///
  ///
  @override
  Future<ConsumerPermission> checkPermission(
    BuildContext context,
    List<String> paths,
  ) async =>
      const ConsumerPermission.allowAll(name: 'Mock String');

  ///
  ///
  ///
  @override
  Future<MockStringModel?> getById(
    BuildContext context,
    MockStringModel model, {
    Map<String, String> extraParams = const <String, String>{},
  }) {
    // TODO(edufolly): implement getById
    throw UnimplementedError();
  }

  ///
  ///
  ///
  @override
  Future<List<MockStringModel>> list(
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
    MockStringModel model, {
    Map<String, String> extraParams = const <String, String>{},
  }) async =>
      true;

  ///
  ///
  ///
  @override
  Future<String> saveOrUpdate(
    BuildContext context,
    MockStringModel model, {
    Map<String, String> extraParams = const <String, String>{},
  }) async {
    model.id = model.hashCode.toString();
    return model.id!;
  }
}
