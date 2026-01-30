import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class WidgetImageRenderer<T> extends StatelessWidget {
  final WidgetImageController<T> controller;
  final Widget Function(BuildContext context, T? value, Widget? child) builder;
  final void Function(ByteData data, T? value) callback;
  final Widget? child;
  final double? pixelRatio;
  final ui.ImageByteFormat imageByteFormat;

  const WidgetImageRenderer({
    required this.controller,
    required this.builder,
    required this.callback,
    this.child,
    this.pixelRatio,
    this.imageByteFormat = ui.ImageByteFormat.png,
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    return RepaintBoundary(
      key: controller._globalKey,
      child: ValueListenableBuilder<_InternalHolder<T?>>(
        valueListenable: controller,
        child: child,
        builder:
            (
              final BuildContext context,
              final _InternalHolder<T?> value,
              final Widget? child,
            ) {
              WidgetsBinding.instance.endOfFrame.then((_) => _captureWidget());

              return builder(context, value.value, child);
            },
      ),
    );
  }

  Future<void> _captureWidget() async {
    if (controller._process) {
      String errorTag = '';

      BuildContext? context = controller._globalKey.currentContext;

      if (context != null) {
        RenderRepaintBoundary? boundary =
            context.findRenderObject() as RenderRepaintBoundary?;

        if (boundary != null) {
          ui.Image image = await boundary.toImage(
            pixelRatio: pixelRatio ?? MediaQuery.of(context).devicePixelRatio,
          );

          ByteData? byteData = await image.toByteData(format: imageByteFormat);

          if (byteData != null) {
            callback(byteData, controller.value.value);
          } else {
            errorTag = 'null-byte-data';
          }
        } else {
          errorTag = 'null-render-repaint-boundary';
        }
      } else {
        errorTag = 'null-build-context';
      }

      controller._process = false;

      if (errorTag.isNotEmpty) {
        throw WidgetImageRenderingException(errorTag);
      }
    }
  }
}

class WidgetImageRenderingException implements Exception {
  final String tag;

  const WidgetImageRenderingException(this.tag);

  @override
  String toString() => tag;
}

class _InternalHolder<T> {
  final T? value;

  const _InternalHolder(this.value);
}

class WidgetImageController<T> extends ValueNotifier<_InternalHolder<T>> {
  final GlobalKey _globalKey = GlobalKey();
  bool _process = false;

  WidgetImageController({final T? value}) : super(_InternalHolder<T>(value));

  bool process(final T value) {
    if (!_process) {
      _process = true;
      this.value = _InternalHolder<T>(value);

      return true;
    }

    return false;
  }
}
