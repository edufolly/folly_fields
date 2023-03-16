import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_model.dart';
import 'package:folly_fields/crud/abstract_route.dart';

///
///
///
// TODO(edufolly): Remove in version 1.0.0.
@Deprecated('This class will be removed in version 1.0.0.')
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
// TODO(edufolly): Remove in version 1.0.0.
@Deprecated('This class will be removed in version 1.0.0.')
abstract class AbstractMapFunction
    extends AbstractFunctionInterface<Map<String, String>> {}

///
///
///
// TODO(edufolly): Remove in version 1.0.0.
@Deprecated('This class will be removed in version 1.0.0.')
abstract class AbstractModelFunction<T extends AbstractModel<Object>>
    extends AbstractFunctionInterface<T> {}

///
///
///
// TODO(edufolly): Remove in version 1.0.0.
@Deprecated('This class will be removed in version 1.0.0.')
abstract class AbstractFunction<T> extends AbstractRoute
    implements AbstractFunctionInterface<T> {
  ///
  ///
  ///
  @Deprecated('This class will be removed in version 1.0.0.')
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
// TODO(edufolly): Remove in version 1.0.0.
@Deprecated('This class will be removed in version 1.0.0.')
abstract class MapFunction extends AbstractFunction<Map<String, String>>
    implements AbstractMapFunction {
  ///
  ///
  ///
  @Deprecated('This class will be removed in version 1.0.0.')
  const MapFunction({super.key});
}

///
///
///
// TODO(edufolly): Remove in version 1.0.0.
@Deprecated('This class will be removed in version 1.0.0.')
abstract class ModelFunction<T extends AbstractModel<Object>>
    extends AbstractFunction<T> implements AbstractModelFunction<T> {
  ///
  ///
  ///
  @Deprecated('This class will be removed in version 1.0.0.')
  const ModelFunction({super.key});
}
