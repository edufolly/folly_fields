// ignore_for_file: no_logic_in_create_state

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
    extends StatefulWidget {
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

  @override
  State<StatefulWidget> createState() {
    return ModelFunctionButtonState<T>();
  }
}

///
///
///
class ModelFunctionButtonState<T extends AbstractModel<Object>>
    extends State<ModelFunctionButton<T>> {
  ///
  ///
  ///
  ModelFunctionButtonState();

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return SilentFutureBuilder<bool>(
      future: widget.rowFunction.showButton(
        context,
        widget.model,
        selection: widget.selection,
      ),
      builder: (BuildContext context, bool data) => data
          ? IconButton(
              tooltip: widget.permission.name,
              icon: widget.rowFunction.iconBuilder(context, widget.model) ??
                  IconHelper.faIcon(widget.permission.iconName),
              onPressed: () async {
                Widget? nextWidget = await widget.rowFunction.onPressed(
                  context,
                  widget.model,
                  selection: widget.selection,
                );

                if (widget.rowFunction.redirect) {
                  dynamic object;
                  if (nextWidget == null) {
                    if (widget.rowFunction.path != null &&
                        widget.rowFunction.path!.isNotEmpty) {
                      object = await Navigator.of(context).pushNamed<Object>(
                        widget.rowFunction.path!,
                        arguments: <String, dynamic>{
                          'qsParam': widget.qsParam,
                          'model': widget.model,
                        },
                      );
                    }
                  } else {
                    object = await Navigator.of(context).push(
                      MaterialPageRoute<Object>(
                        builder: (_) => nextWidget,
                      ),
                    );
                  }

                  if (object != null) {
                    widget.callback?.call(object);
                  }
                }
                setState(() {});
              },
            )
          : const SizedBox.shrink(),
    );
  }
}
