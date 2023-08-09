import 'package:flutter/material.dart';
import 'package:folly_fields/controllers/dropdown_editing_controller.dart';
import 'package:folly_fields/responsive/responsive_form_field.dart';

///
///
///
class DropdownField<T> extends ResponsiveFormField<T> {
  final DropdownEditingController<T>? controller;
  final Map<T, String>? items;

  ///
  ///
  ///
  DropdownField({
    String? labelPrefix,
    String? label,
    Widget? labelWidget,
    this.controller,
    FormFieldValidator<T?>? validator,
    super.onSaved,
    T? initialValue,
    this.items,
    super.enabled,
    AutovalidateMode autoValidateMode = AutovalidateMode.disabled,
    Function(T? value)? onChanged,
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
    EdgeInsets padding = const EdgeInsets.all(8),
    String? hintText,
    EdgeInsets? contentPadding,
    super.sizeExtraSmall,
    super.sizeSmall,
    super.sizeMedium,
    super.sizeLarge,
    super.sizeExtraLarge,
    super.minHeight,
    super.key,
  })  : assert(
          initialValue == null || controller == null,
          'initialValue or controller must be null.',
        ),
        // assert(elevation != null),
        // assert(iconSize != null),
        // assert(isDense != null),
        // assert(isExpanded != null),
        assert(
          itemHeight == null || itemHeight >= kMinInteractiveDimension,
          'itemHeight must be null or equal or greater '
          'kMinInteractiveDimension.',
        ),
        // assert(autofocus != null),
        assert(
          label == null || labelWidget == null,
          'label or labelWidget must be null.',
        ),
        super(
          initialValue: controller != null ? controller.value : initialValue,
          validator: enabled ? validator : (_) => null,
          autovalidateMode: autoValidateMode,
          builder: (FormFieldState<T?> field) {
            final _DropdownFieldState<T> state = field as _DropdownFieldState<T>;

            final InputDecoration effectiveDecoration = (decoration ??
                    InputDecoration(
                      border: const OutlineInputBorder(),
                      filled: filled,
                      fillColor: fillColor,
                      label: labelWidget,
                      labelText: (labelPrefix?.isEmpty ?? true)
                          ? label
                          : '$labelPrefix - $label',
                      counterText: '',
                      focusColor: focusColor,
                      hintText: hintText,
                      contentPadding: contentPadding,
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
  FormFieldState<T> createState() => _DropdownFieldState<T>();
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

  ///
  ///
  ///
  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    _controller?.dispose();
    super.dispose();
  }
}
