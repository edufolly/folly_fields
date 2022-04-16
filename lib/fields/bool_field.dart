import 'package:flutter/material.dart';
import 'package:folly_fields/responsive/responsive.dart';

///
///
///
class BoolField extends FormFieldResponsive<bool> {
  final BoolEditingController? controller;
  final Function(bool)? onChanged;

  ///
  ///
  ///
  BoolField({
    String labelPrefix = '',
    String? label,
    Widget? labelWidget,
    this.controller,
    String? Function(bool value)? validator,
    void Function(bool value)? onSaved,
    bool? initialValue,
    bool enabled = true,
    AutovalidateMode autoValidateMode = AutovalidateMode.disabled,
    this.onChanged,
    bool filled = false,
    Color? fillColor,
    bool adaptive = false,
    Color? activeColor,
    InputDecoration? decoration,
    EdgeInsets padding = const EdgeInsets.all(8),
    int? sizeExtraSmall,
    int? sizeSmall,
    int? sizeMedium,
    int? sizeLarge,
    int? sizeExtraLarge,
    double? minHeight,
    TextOverflow textOverflow = TextOverflow.ellipsis,
    Key? key,
  })  : assert(initialValue == null || controller == null,
            'initialValue or controller must be null.'),
        assert(label == null || labelWidget == null,
            'label or labelWidget must be null.'),
        super(
          key: key,
          sizeExtraSmall: sizeExtraSmall,
          sizeSmall: sizeSmall,
          sizeMedium: sizeMedium,
          sizeLarge: sizeLarge,
          sizeExtraLarge: sizeExtraLarge,
          minHeight: minHeight,
          initialValue: controller != null ? controller.value : initialValue,
          validator: enabled && validator != null
              ? (bool? value) => validator(value ?? false)
              : (_) => null,
          onSaved: enabled && onSaved != null
              ? (bool? value) => onSaved(value ?? false)
              : null,
          enabled: enabled,
          autovalidateMode: autoValidateMode,
          builder: (FormFieldState<bool> field) {
            final BoolFieldState state = field as BoolFieldState;

            final InputDecoration effectiveDecoration = (decoration ??
                    InputDecoration(
                      border: const OutlineInputBorder(),
                      filled: filled,
                      fillColor: fillColor,
                      counterText: '',
                      enabled: enabled,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 8,
                      ),
                    ))
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            Color? textColor =
                Theme.of(field.context).textTheme.subtitle1!.color;

            TextStyle textStyle =
                Theme.of(field.context).textTheme.subtitle1!.copyWith(
                      color: textColor!.withOpacity(enabled ? 1 : 0.4),
                      overflow: textOverflow,
                    );

            return Padding(
              padding: padding,
              child: Builder(
                builder: (BuildContext context) {
                  return InkWell(
                    canRequestFocus: false,
                    onTap: enabled
                        ? () => state.didChange(!(state.value ?? false))
                        : null,
                    child: InputDecorator(
                      decoration: effectiveDecoration.copyWith(
                        errorText: enabled ? field.errorText : null,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: label == null
                                  ? labelWidget
                                  : Text(
                                      labelPrefix.isEmpty
                                          ? label
                                          : '$labelPrefix - $label',
                                      style: textStyle,
                                    ),
                            ),
                          ),
                          if (adaptive)
                            Switch.adaptive(
                              value: state._effectiveController.value,
                              onChanged: enabled ? state.didChange : null,
                              activeColor: activeColor,
                            )
                          else
                            Switch(
                              value: state._effectiveController.value,
                              onChanged: enabled ? state.didChange : null,
                              activeColor: activeColor,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );

  ///
  ///
  ///
  @override
  BoolFieldState createState() => BoolFieldState();
}

///
///
///
class BoolFieldState extends FormFieldState<bool> {
  BoolEditingController? _controller;

  ///
  ///
  ///
  @override
  BoolField get widget => super.widget as BoolField;

  ///
  ///
  ///
  BoolEditingController get _effectiveController =>
      widget.controller ?? _controller!;

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = BoolEditingController(
        value: widget.initialValue ?? false,
      );
    } else {
      widget.controller?.addListener(_handleControllerChanged);
    }
  }

  ///
  ///
  ///
  @override
  void didUpdateWidget(BoolField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);

      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _controller = BoolEditingController(
          value: oldWidget.controller!.value,
        );
      }

      if (widget.controller != null) {
        setValue(widget.controller!.value);

        if (oldWidget.controller == null) {
          _controller = null;
        }
      }
    }
  }

  ///
  ///
  ///
  @override
  void didChange(bool? value) {
    super.didChange(value);
    if (_effectiveController.value != value) {
      _effectiveController.value = value ?? false;
      widget.onChanged?.call(value ?? false);
    }
  }

  ///
  ///
  ///
  @override
  void reset() {
    super.reset();
    setState(() => _effectiveController.value = widget.initialValue ?? false);
  }

  ///
  ///
  ///
  void _handleControllerChanged() {
    if (_effectiveController.value != value) {
      didChange(_effectiveController.value);
    }
  }

  ///
  ///
  ///
  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    super.dispose();
  }
}

///
///
///
class BoolEditingController extends ValueNotifier<bool> {
  ///
  ///
  ///
  BoolEditingController({bool value = false}) : super(value);
}
