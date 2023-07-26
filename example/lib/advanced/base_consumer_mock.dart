import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_consumer.dart';
import 'package:folly_fields/crud/abstract_model.dart';
import 'package:folly_fields_example/example_model.dart';

///
///
///
@immutable
abstract class BaseConsumerMock<T extends AbstractModel<int>>
    extends AbstractConsumer<T, int> {
  ///
  ///
  ///
  const BaseConsumerMock(super.routeName);

  ///
  ///
  ///
  @override
  Future<ConsumerPermission> checkPermission(
    BuildContext context,
    List<String>? paths,
  ) async =>
      const ConsumerPermission.allowAll(
        name: 'mock',
        iconName: 'question',
      );

  ///
  ///
  ///
  @override
  Future<List<T>> list(
    BuildContext context, {
    int page = 0,
    int size = 20,
    Map<String, String> extraParams = const <String, String>{},
    bool forceOffline = false,
  }) async {
    if (kDebugMode) {
      print('Page: $page - Size: $size - Extra Params: $extraParams');
    }

    return Future<List<T>>.delayed(
      const Duration(seconds: 1),
      () => List<T>.generate(
        size,
        (int index) => ExampleModel.generate(seed: page * size + index) as T,
      ),
    );
  }

  ///
  ///
  ///
  @override
  Future<Map<T, String>> dropdownMap(
    BuildContext context, {
    int page = 0,
    int size = 20,
    Map<String, String> extraParams = const <String, String>{},
    bool forceOffline = false,
  }) async =>
      <T, String>{};

  ///
  ///
  ///
  @override
  Future<T> getById(
    BuildContext context,
    T model, {
    Map<String, String> extraParams = const <String, String>{},
  }) async =>
      model;

  ///
  ///
  ///
  @override
  Future<bool> delete(
    BuildContext context,
    T model, {
    Map<String, String> extraParams = const <String, String>{},
  }) async =>
      true;

  ///
  ///
  ///
  @override
  Future<int?> saveOrUpdate(
    BuildContext context,
    T model, {
    Map<String, String> extraParams = const <String, String>{},
  }) async =>
      model.id ?? -1;
}
