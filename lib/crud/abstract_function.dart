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
  String get path;

  ///
  ///
  ///
  Future<bool> showButton(BuildContext context, bool selection, T object);

  ///
  ///
  ///
  Future<Widget?> onPressed(BuildContext context, bool selection, T object);
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
    extends AbstractFunctionInterface<T> {
}

///
///
///
abstract class AbstractFunction<T> extends AbstractRoute
    implements AbstractFunctionInterface<T> {
  ///
  ///
  ///
  const AbstractFunction({
    Key? key,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Future<bool> showButton(
    BuildContext context,
    bool selection,
    T object,
  ) async =>
      true;

  ///
  ///
  ///
  @override
  Future<Widget?> onPressed(
    BuildContext context,
    bool selection,
    T object,
  ) async =>
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
  const MapFunction({Key? key}) : super(key: key);
}

///
///
///
abstract class ModelFunction<T extends AbstractModel<Object>>
    extends AbstractFunction<T> implements AbstractModelFunction<T> {
  ///
  ///
  ///
  const ModelFunction({Key? key}) : super(key: key);
}
