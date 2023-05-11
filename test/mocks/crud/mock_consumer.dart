// ignore_for_file: avoid-top-level-members-in-tests

import 'package:flutter/src/widgets/framework.dart';
import 'package:folly_fields/crud/abstract_consumer.dart';

import 'mock_model.dart';

///
///
///
class MockConsumer extends AbstractConsumer<MockModel> {
  ///
  ///
  ///
  const MockConsumer() : super(const <String>['mock']);

  ///
  ///
  ///
  @override
  Future<ConsumerPermission> checkPermission(
    BuildContext context,
    List<String> paths,
  ) async =>
      const ConsumerPermission(
        name: 'Mock',
        menu: true,
        view: true,
        insert: true,
        update: true,
        delete: true,
      );

  ///
  ///
  ///
  @override
  Future<bool> delete(BuildContext context, MockModel model) async => true;

  ///
  ///
  ///
  @override
  Future<MockModel?> getById(BuildContext context, MockModel model) {
    // TODO(edufolly): implement getById
    throw UnimplementedError();
  }

  ///
  ///
  ///
  @override
  Future<List<MockModel>> list(
    BuildContext context,
    Map<String, String> qsParam, {
    required bool forceOffline,
  }) {
    // TODO(edufolly): implement list
    throw UnimplementedError();
  }

  ///
  ///
  ///
  @override
  Future<bool> saveOrUpdate(BuildContext context, MockModel model) async =>
      true;

  ///
  ///
  ///
  @override
  MockModel fromJson(Map<String, dynamic> map) => MockModel.fromJson(map);
}
