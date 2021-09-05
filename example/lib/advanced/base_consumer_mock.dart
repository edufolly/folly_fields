import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_consumer.dart';
import 'package:folly_fields/crud/abstract_model.dart';
import 'package:folly_fields_example/example_model.dart';

///
///
///
@immutable
abstract class BaseConsumerMock<T extends AbstractModel<Object>>
    extends AbstractConsumer<T> {
  ///
  ///
  ///
  const BaseConsumerMock();

  ///
  ///
  ///
  @override
  Future<ConsumerPermission> checkPermission(
    BuildContext context,
    List<String>? paths,
  ) =>
      Future<ConsumerPermission>.value(
        const ConsumerPermission(
          name: 'mock',
          iconName: 'question',
          view: true,
          insert: true,
          update: true,
          delete: true,
          menu: true,
        ),
      );

  ///
  ///
  ///
  @override
  Future<List<T>> list(
    BuildContext context,
    Map<String, String> qsParam,
    bool forceOffline,
  ) async {
    print('mock list: $qsParam');

    int first = int.tryParse(qsParam['f'] ?? '0') ?? 0;
    int qtd = int.tryParse(qsParam['q'] ?? '50') ?? 50;

    return Future<List<T>>.delayed(
      const Duration(seconds: 2),
      () => List<T>.generate(
        qtd,
        (int index) => (ExampleModel.generate(seed: first + index) as T),
      ),
    );
  }

  ///
  ///
  ///
  @override
  Future<Map<T, String>> dropdownMap(
    BuildContext context,
    Map<String, String> qsParam,
  ) async =>
      <T, String>{};

  ///
  ///
  ///
  @override
  Future<T> getById(
    BuildContext context,
    T model,
  ) async =>
      Future<T>.value(model);

  ///
  ///
  ///
  @override
  Future<bool> saveOrUpdate(
    BuildContext context,
    T model,
  ) =>
      Future<bool>.value(true);

  ///
  ///
  ///
  @override
  Future<bool> delete(
    BuildContext context,
    T model,
  ) async =>
      Future<bool>.value(true);
}
