import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_consumer.dart';
import 'package:folly_fields/crud/abstract_function.dart';
import 'package:folly_fields/crud/abstract_model.dart';
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
  final Function(dynamic object)? callback;

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
    super.key,
  });

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return SilentFutureBuilder<bool>(
      future: rowFunction.showButton(
        context,
        model,
        selection: selection,
      ),
      builder: (BuildContext context, bool data, _) => data
          ? IconButton(
              tooltip: permission.name,
              icon: IconHelper.faIcon(permission.iconName),
              onPressed: () async {
                Widget? widget = await rowFunction.onPressed(
                  context,
                  model,
                  selection: selection,
                );

                dynamic object;

                if (widget == null) {
                  if (rowFunction.path != null &&
                      rowFunction.path!.isNotEmpty) {
                    object = await Navigator.of(context).pushNamed<Object>(
                      rowFunction.path!,
                      arguments: <String, dynamic>{
                        'qsParam': qsParam,
                        'model': model,
                      },
                    );
                  }
                } else {
                  object = await Navigator.of(context).push(
                    MaterialPageRoute<Object>(
                      builder: (_) => widget,
                    ),
                  );
                }

                if (object != null) {
                  callback?.call(object);
                }
              },
            )
          : const SizedBox.shrink(),
    );
  }
}
