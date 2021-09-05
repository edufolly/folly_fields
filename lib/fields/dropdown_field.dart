import 'package:flutter/material.dart';

///
///
///
class DropdownField<T> extends FormField<T> {
  final DropdownEditingController<T>? controller;
  final Map<T, String>? items;

  ///
  ///
  ///
  DropdownField({
    Key? key,
    String prefix = '',
    String label = '',
    this.controller,
    FormFieldValidator<T?>? validator,
    FormFieldSetter<T?>? onSaved,
    T? initialValue,
    this.items,
    bool enabled = true,
    AutovalidateMode autoValidateMode = AutovalidateMode.disabled,
    Function(T? value)? onChanged,
    // ValueChanged<String> onFieldSubmitted,
    bool filled = false,
    Color? fillColor,
    DropdownButtonBuilder? selectedItemBuilder,
    Widget? hint,
    Widget? disabledHint,
    Color? focusColor,
    int elevation = 8,
    TextStyle? style,
    Widget? icon,
    Color? iconDisabledColor,
    Color? iconEnabledColor,
    double iconSize = 24.0,
    bool isDense = true,
    bool isExpanded = false,
    double? itemHeight,
    FocusNode? focusNode,
    bool autofocus = false,
    Color? dropdownColor,
    InputDecoration? decoration,
    EdgeInsets padding = const EdgeInsets.all(8.0),
  })  : assert(initialValue == null || controller == null),
        // assert(elevation != null),
        // assert(iconSize != null),
        // assert(isDense != null),
        // assert(isExpanded != null),
        assert(itemHeight == null || itemHeight >= kMinInteractiveDimension),
        // assert(autofocus != null),
        super(
          key: key,
          initialValue: controller != null ? controller.value : initialValue,
          onSaved: onSaved,
          validator: enabled ? validator : (_) => null,
          enabled: enabled,
          autovalidateMode: autoValidateMode,
          builder: (FormFieldState<T?> field) {
            final _DropdownFieldState<T> state =
                field as _DropdownFieldState<T>;

            final InputDecoration effectiveDecoration = (decoration ??
                    InputDecoration(
                      border: const OutlineInputBorder(),
                      filled: filled,
                      fillColor: fillColor,
                      labelText: prefix.isEmpty ? label : '$prefix - $label',
                      counterText: '',
                      focusColor: focusColor,
                    ))
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            return Padding(
              padding: padding,
              child: Focus(
                canRequestFocus: false,
                skipTraversal: true,
                child: Builder(
                  builder: (BuildContext context) {
                    return InputDecorator(
                      decoration: effectiveDecoration.copyWith(
                        errorText: enabled ? field.errorText : null,
                        enabled: enabled,
                      ),
                      isEmpty: state.value == null,
                      isFocused: Focus.of(context).hasFocus,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<T>(
                          items: state._effectiveController.getDropdownItems(),
                          selectedItemBuilder: selectedItemBuilder,
                          value: state._effectiveController.value,
                          hint: hint,
                          disabledHint: disabledHint,
                          onChanged: enabled
                              ? (T? value) {
                                  state.didChange(value);
                                  if (onChanged != null && state.isValid) {
                                    onChanged(value);
                                  }
                                }
                              : null,
                          // onTap: onTap,
                          elevation: elevation,
                          style: style,
                          icon: icon,
                          iconDisabledColor: iconDisabledColor,
                          iconEnabledColor: iconEnabledColor,
                          iconSize: iconSize,
                          isDense: isDense,
                          isExpanded: isExpanded,
                          itemHeight: itemHeight,
                          focusColor: focusColor,
                          focusNode: focusNode,
                          autofocus: autofocus,
                          dropdownColor: dropdownColor,
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
  _DropdownFieldState<T> createState() => _DropdownFieldState<T>();
}

///
///
///
class _DropdownFieldState<T> extends FormFieldState<T> {
  DropdownEditingController<T>? _controller;

  ///
  ///
  ///
  @override
  DropdownField<T> get widget => super.widget as DropdownField<T>;

  ///
  ///
  ///
  DropdownEditingController<T> get _effectiveController =>
      widget.controller ?? _controller!;

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = DropdownEditingController<T>(
        value: widget.initialValue,
        items: widget.items,
      );
    } else {
      widget.controller!.addListener(_handleControllerChanged);
    }
  }

  ///
  ///
  ///
  @override
  void didUpdateWidget(DropdownField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);

      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _controller = DropdownEditingController<T>.fromValue(
          oldWidget.controller!,
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
  void didChange(T? value) {
    super.didChange(value);
    if (_effectiveController.value != value) {
      _effectiveController.value = value;
    }
  }

  ///
  ///
  ///
  @override
  void reset() {
    super.reset();
    setState(() => _effectiveController.value = widget.initialValue);
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
class DropdownEditingController<T> extends ValueNotifier<T?> {
  Map<T, String>? _items;

  ///
  ///
  ///
  DropdownEditingController.fromValue(DropdownEditingController<T> controller)
      : _items = controller.items,
        super(controller.value);

  ///
  ///
  ///
  DropdownEditingController({T? value, Map<T, String>? items})
      : _items = items,
        super(value);

  ///
  ///
  ///
  Map<T, String>? get items => _items;

  ///
  ///
  ///
  set items(Map<T, String>? items) {
    _items = items;
    super.notifyListeners();
  }

  ///
  ///
  ///
  List<DropdownMenuItem<T>> getDropdownItems() =>
      _items == null || _items!.isEmpty
          ? <DropdownMenuItem<T>>[]
          : _items!.entries
              .map(
                (MapEntry<T, String> entry) => DropdownMenuItem<T>(
                  value: entry.key,
                  child: Text(entry.value),
                ),
              )
              .toList();
}
