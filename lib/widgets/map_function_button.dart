import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_consumer.dart';
import 'package:folly_fields/crud/abstract_function.dart';
import 'package:folly_fields/util/folly_utils.dart';
import 'package:folly_fields/util/icon_helper.dart';
import 'package:folly_fields/util/safe_builder.dart';

///
///
///
class MapFunctionButton extends StatelessWidget {
  final AbstractMapFunction mapFunction;
  final ConsumerPermission permission;
  final Map<String, String> qsParam;
  final bool selection;
  final Function(Map<String, String> qsParam)? callback;

  ///
  ///
  ///
  const MapFunctionButton({
    required this.mapFunction,
    required this.permission,
    required this.qsParam,
    this.selection = false,
    this.callback,
    Key? key,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return SilentFutureBuilder<bool>(
      future: mapFunction.showButton(
        context,
        selection,
        qsParam,
      ),
      builder: (BuildContext context, bool data) {
        if (!data) {
          return FollyUtils.nothing;
        }

        return IconButton(
          tooltip: permission.name,
          icon: IconHelper.faIcon(permission.iconName),
          onPressed: () async {
            Widget? w = await mapFunction.onPressed(
              context,
              selection,
              qsParam,
            );

            Map<String, String>? map;

            if (w != null) {
              map = await Navigator.of(context).push(
                MaterialPageRoute<Map<String, String>>(
                  builder: (_) => w,
                ),
              );
            } else {
              map = await Navigator.of(context).pushNamed<Map<String, String>>(
                mapFunction.path,
                arguments: qsParam,
              );
            }

            if (map != null) {
              callback?.call(map);
            }
          },
        );
      },
    );
  }
}
