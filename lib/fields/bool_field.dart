import 'package:flutter/material.dart';

///
///
///
class BoolField extends FormField<bool> {
  final BoolEditingController? controller;

  ///
  ///
  ///
  BoolField({
    Key? key,
    String prefix = '',
    String label = '',
    this.controller,
    String? Function(bool value)? validator,
    void Function(bool value)? onSaved,
    bool? initialValue,
    bool enabled = true,
    AutovalidateMode autoValidateMode = AutovalidateMode.disabled,
    // TODO - onChanged
    // ValueChanged<String> onFieldSubmitted,
    bool filled = false,
    Color? fillColor,
    bool adaptive = false,
    Color? activeColor,
    InputDecoration? decoration,
    EdgeInsets padding = const EdgeInsets.all(8.0),
  })  : assert(initialValue == null || controller == null),
        super(
          key: key,
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
            final _BoolFieldState state = field as _BoolFieldState;

            final InputDecoration effectiveDecoration = (decoration ??
                    InputDecoration(
                      border: const OutlineInputBorder(),
                      filled: filled,
                      fillColor: fillColor,
                      labelText: null,
                      counterText: '',
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 8.0,
                      ),
                    ))
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            Color? textColor =
                Theme.of(field.context).textTheme.subtitle1!.color;

            TextStyle textStyle =
                Theme.of(field.context).textTheme.subtitle1!.copyWith(
                      color: textColor!.withOpacity(enabled ? 1 : 0.4),
                    );

            Color accentColor =
                activeColor ?? Theme.of(field.context).colorScheme.secondary;

            return Padding(
              padding: padding,
              child: Focus(
                canRequestFocus: false,
                skipTraversal: true,
                child: Builder(
                  builder: (BuildContext context) {
                    return InkWell(
                      onTap: enabled
                          ? () => state.didChange(!(state.value ?? false))
                          : null,
                      child: InputDecorator(
                        decoration: effectiveDecoration.copyWith(
                          errorText: enabled ? field.errorText : null,
                        ),
                        isEmpty: false,
                        isFocused: Focus.of(context).hasFocus,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4.0,
                              ),
                              child: Text(
                                prefix.isEmpty ? label : '$prefix - $label',
                                style: textStyle,
                              ),
                            ),
                            if (adaptive)
                              Switch.adaptive(
                                value: state._effectiveController.value,
                                onChanged: enabled ? state.didChange : null,
                                activeColor: accentColor,
                              )
                            else
                              Switch(
                                value: state._effectiveController.value,
                                onChanged: enabled ? state.didChange : null,
                                activeColor: accentColor,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );

  ///
  ///
  ///
  @override
  _BoolFieldState createState() => _BoolFieldState();
}

///
///
///
class _BoolFieldState extends FormFieldState<bool> {
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
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    super.dispose();
  }

  ///
  ///
  ///
  @override
  void didChange(bool? value) {
    super.didChange(value);
    if (_effectiveController.value != value) {
      _effectiveController.value = value ?? false;
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
}

///
///
///
class BoolEditingController extends ValueNotifier<bool> {
  BoolEditingController({bool value = false}) : super(value);
}
