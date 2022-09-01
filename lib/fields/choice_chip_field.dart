import 'package:flutter/material.dart';
import 'package:folly_fields/responsive/responsive.dart';

///
///
///
class ChoiceChipField<T> extends FormFieldResponsive<T> {
  final ChoiceChipFieldController<T>? controller;
  final Map<T, String>? items;

  ///
  ///
  ///
  ChoiceChipField({
    String labelPrefix = '',
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
    // ValueChanged<String> onFieldSubmitted,
    bool filled = false,
    Color? fillColor,
    Color? focusColor,
    InputDecoration? decoration,
    EdgeInsets padding = const EdgeInsets.all(8),
    Color? selectedColor,
    Color? selectedTextColor,
    WrapAlignment wrapAlignment = WrapAlignment.spaceEvenly,
    WrapCrossAlignment wrapCrossAlignment = WrapCrossAlignment.center,
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
        assert(
          label == null || labelWidget == null,
          'label or labelWidget must be null.',
        ),
        super(
          initialValue: controller != null ? controller.value : initialValue,
          validator: enabled ? validator : (_) => null,
          autovalidateMode: autoValidateMode,
          builder: (FormFieldState<T?> field) {
            ChoiceChipFieldState<T> state = field as ChoiceChipFieldState<T>;

            Color effectiveSelectedColor =
                selectedColor ?? Theme.of(state.context).colorScheme.primary;

            Color effectiveSelectedTextColor = selectedTextColor ??
                Theme.of(state.context).colorScheme.onPrimary;

            InputDecoration effectiveDecoration = (decoration ??
                    InputDecoration(
                      border: const OutlineInputBorder(),
                      filled: filled,
                      fillColor: fillColor,
                      label: labelWidget,
                      labelText:
                          labelPrefix.isEmpty ? label : '$labelPrefix - $label',
                      counterText: '',
                      focusColor: focusColor,
                    ))
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            return Padding(
              padding: padding,
              child: InputDecorator(
                decoration: effectiveDecoration.copyWith(
                  errorText: enabled ? field.errorText : null,
                  enabled: enabled,
                ),
                child: ValueListenableBuilder<T?>(
                  valueListenable: state._effectiveController,
                  builder: (BuildContext context, T? value, _) {
                    return Wrap(
                      alignment: wrapAlignment,
                      crossAxisAlignment: wrapCrossAlignment,
                      children:
                          state._effectiveController.items!.entries.map<Widget>(
                        (MapEntry<T, String> e) {
                          return ChoiceChip(
                            label: Text(e.value),
                            selected: value == e.key,
                            selectedColor: effectiveSelectedColor,
                            labelStyle: value == e.key
                                ? TextStyle(color: effectiveSelectedTextColor)
                                : null,
                            onSelected: (_) {
                              state.didChange(e.key);
                              if (onChanged != null) {
                                onChanged(e.key);
                              }
                            },
                          );
                        },
                      ).toList(),
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
  ChoiceChipFieldState<T> createState() => ChoiceChipFieldState<T>();
}

///
///
///
class ChoiceChipFieldState<T> extends FormFieldState<T> {
  ChoiceChipFieldController<T>? _controller;

  ///
  ///
  ///
  @override
  ChoiceChipField<T> get widget => super.widget as ChoiceChipField<T>;

  ///
  ///
  ///
  ChoiceChipFieldController<T> get _effectiveController =>
      widget.controller ?? _controller!;

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = ChoiceChipFieldController<T>(
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
  void didUpdateWidget(ChoiceChipField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);

      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _controller = ChoiceChipFieldController<T>.fromValue(
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
    super.dispose();
  }
}

///
///
///
class ChoiceChipFieldController<T> extends ValueNotifier<T?> {
  Map<T, String>? _items;

  ///
  ///
  ///
  ChoiceChipFieldController.fromValue(ChoiceChipFieldController<T> controller)
      : _items = controller.items,
        super(controller.value);

  ///
  ///
  ///
  ChoiceChipFieldController({T? value, Map<T, String>? items})
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
}
