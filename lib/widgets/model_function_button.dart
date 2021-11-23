import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_consumer.dart';
import 'package:folly_fields/crud/abstract_function.dart';
import 'package:folly_fields/crud/abstract_model.dart';
import 'package:folly_fields/util/folly_utils.dart';
import 'package:folly_fields/util/icon_helper.dart';
import 'package:folly_fields/util/safe_builder.dart';

///
///
///
class ModelFunctionButton<T extends AbstractModel<Object>>
    extends StatelessWidget {
  final AbstractModelFunction<T> rowFunction;
  final ConsumerPermission permission;
  final T model;
  final bool selection;
  final Map<String, String> qsParam;
  final Function(Object? object)? callback;

  ///
  ///
  ///
  const ModelFunctionButton({
    required this.rowFunction,
    required this.permission,
    required this.model,
    this.selection = false,
    this.qsParam = const <String, String>{},
    this.callback,
    Key? key,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return SilentFutureBuilder<bool>(
      future: rowFunction.showButton(
        context,
        selection,
        model,
      ),
      builder: (BuildContext context, bool data) => data
          ? IconButton(
              tooltip: permission.name,
              icon: IconHelper.faIcon(permission.iconName),
              onPressed: () async {
                Widget? w = await rowFunction.onPressed(
                  context,
                  selection,
                  model,
                );

                Object? object = w != null
                    ? await Navigator.of(context).push(
                        MaterialPageRoute<Object>(
                          builder: (_) => w,
                        ),
                      )
                    : await Navigator.of(context).pushNamed(
                        rowFunction.path,
                        arguments: <String, dynamic>{
                          'qsParam': qsParam,
                          'model': model,
                        },
                      );

                if (object != null) {
                  callback?.call(object);
                }
              },
            )
          : FollyUtils.nothing,
    );
  }
}
