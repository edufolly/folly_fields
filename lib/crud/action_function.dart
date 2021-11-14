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
  Future<bool> showButton(BuildContext context, T object);

  ///
  ///
  ///
  Future<Widget?> onPressed(BuildContext context, T object);
}

///
///
///
abstract class AbstractHeaderFunction
    extends AbstractFunctionInterface<Map<String, String>> {}

///
///
///
abstract class AbstractRowFunction<T extends AbstractModel<Object>>
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
    Key? key,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Future<bool> showButton(BuildContext context, T object) async => true;

  ///
  ///
  ///
  @override
  Future<Widget?> onPressed(BuildContext context, T object) async => null;
}

///
///
///
abstract class HeaderFunction extends AbstractFunction<Map<String, String>>
    implements AbstractHeaderFunction {
  ///
  ///
  ///
  const HeaderFunction({Key? key}) : super(key: key);
}

///
///
///
abstract class RowFunction<T extends AbstractModel<Object>>
    extends AbstractFunction<T> implements AbstractRowFunction<T> {
  ///
  ///
  ///
  const RowFunction({Key? key}) : super(key: key);
}
