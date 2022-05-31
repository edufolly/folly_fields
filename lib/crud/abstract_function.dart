import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_model.dart';
import 'package:folly_fields/crud/abstract_route.dart';

///
///
///
abstract class AbstractFunctionInterface<T> {
  ///
  ///
  ///
  List<String> get routeName;

  ///
  ///
  ///
  String? get path;

  ///
  ///
  ///
  Future<bool> showButton(
    BuildContext context,
    T object, {
    required bool selection,
  });

  ///
  ///
  ///
  Future<Widget?> onPressed(
    BuildContext context,
    T object, {
    required bool selection,
  });
}

///
///
///
abstract class AbstractMapFunction
    extends AbstractFunctionInterface<Map<String, String>> {}

///
///
///
abstract class AbstractModelFunction<T extends AbstractModel<Object>>
    extends AbstractFunctionInterface<T> {}

///
///
///
abstract class AbstractFunction<T> extends AbstractRoute
    implements AbstractFunctionInterface<T> {
  ///
  ///
  ///
  const AbstractFunction({
    super.key,
  });

  ///
  ///
  ///
  @override
  Future<bool> showButton(
    BuildContext context,
    T object, {
    required bool selection,
  }) async =>
      true;

  ///
  ///
  ///
  @override
  Future<Widget?> onPressed(
    BuildContext context,
    T object, {
    required bool selection,
  }) async =>
      null;
}

///
///
///
abstract class MapFunction extends AbstractFunction<Map<String, String>>
    implements AbstractMapFunction {
  ///
  ///
  ///
  const MapFunction({super.key});
}

///
///
///
abstract class ModelFunction<T extends AbstractModel<Object>>
    extends AbstractFunction<T> implements AbstractModelFunction<T> {
  ///
  ///
  ///
  const ModelFunction({super.key});
}
