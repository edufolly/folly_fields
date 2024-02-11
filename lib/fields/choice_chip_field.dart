import 'package:flutter/material.dart';
import 'package:folly_fields/controllers/choice_chip_field_controller.dart';
import 'package:folly_fields/responsive/responsive_form_field.dart';
import 'package:folly_fields/util/folly_utils.dart';

///
///
///
class ChoiceChipField<T> extends ResponsiveFormField<Set<T>> {
  final ChoiceChipFieldController<T>? controller;
  final Map<T, ChipEntry>? items;

  ///
  ///
  ///
  ChoiceChipField({
    String? labelPrefix,
    String? label,
    Widget? labelWidget,
    this.controller,
    FormFieldValidator<Set<T>?>? validator,
    super.onSaved,
    Set<T>? initialValue,
    this.items,
    super.enabled,
    AutovalidateMode autoValidateMode = AutovalidateMode.disabled,
    Function(T? value, {required bool selected})? onChanged,
    bool filled = false,
    Color? fillColor,
    Color? focusColor,
    bool? showCheckMark,
    InputDecoration? decoration,
    EdgeInsets padding = const EdgeInsets.all(8),
    WrapAlignment wrapAlignment = WrapAlignment.spaceEvenly,
    WrapCrossAlignment wrapCrossAlignment = WrapCrossAlignment.center,
    String? hintText,
    EdgeInsets? contentPadding,
    Widget? prefix,
    Widget? suffix,
    EdgeInsets chipExternalPadding = EdgeInsets.zero,
    bool multiple = false,
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
          builder: (FormFieldState<Set<T>?> field) {
            _ChoiceChipFieldState<T> state = field as _ChoiceChipFieldState<T>;

            InputDecoration effectiveDecoration = (decoration ??
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
                      prefix: prefix,
                      suffix: suffix,
                    ))
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            return Padding(
              padding: padding,
              child: InputDecorator(
                decoration: effectiveDecoration.copyWith(
                  errorText: enabled ? field.errorText : null,
                  enabled: enabled,
                ),
                child: ValueListenableBuilder<Set<T>>(
                  valueListenable: state._effectiveController,
                  builder: (BuildContext context, Set<T> value, _) => Wrap(
                    alignment: wrapAlignment,
                    crossAxisAlignment: wrapCrossAlignment,
                    children:
                        state._effectiveController.items!.entries.map<Widget>(
                      (MapEntry<T, ChipEntry> e) {
                        bool selected = value.contains(e.key);

                        Color? labelColor = _getLabelColor(
                          context: context,
                          entry: e.value,
                          selected: selected,
                        );

                        return Padding(
                          padding: chipExternalPadding,
                          child: FilterChip(
                            label: Text(e.value.label),
                            padding: e.value.padding,
                            backgroundColor: e.value.color,
                            selected: selected,
                            selectedColor: e.value.selectedColor ??
                                Theme.of(state.context).colorScheme.primary,
                            showCheckmark: showCheckMark,
                            checkmarkColor: labelColor,
                            labelStyle: TextStyle(
                              color: labelColor,
                            ),
                            onSelected: (bool selected) {
                              state.update(
                                e.key,
                                selected: selected,
                                multiple: multiple,
                              );
                              if (onChanged != null) {
                                onChanged(e.key, selected: selected);
                              }
                            },
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
            );
          },
        );

  ///
  ///
  ///
  static Color? _getLabelColor({
    required BuildContext context,
    required ChipEntry entry,
    required bool selected,
  }) {
    if (selected) {
      return entry.selectedTextColor ??
          (entry.selectedColor != null
              ? FollyUtils.textColorByLuminance(entry.selectedColor!)
              : Theme.of(context).colorScheme.onPrimary);
    } else if (entry.textColor != null) {
      return entry.textColor;
    } else if (entry.textColor == null && entry.color != null) {
      return FollyUtils.textColorByLuminance(entry.color!);
    }

    return null;
  }

  ///
  ///
  ///
  @override
  FormFieldState<Set<T>> createState() => _ChoiceChipFieldState<T>();
}

///
///
///
class _ChoiceChipFieldState<T> extends FormFieldState<Set<T>> {
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
  void update(
    T element, {
    required bool selected,
    required bool multiple,
  }) {
    Set<T> value = Set<T>.from(_effectiveController.value);

    if (!multiple) {
      value.clear();
    }

    if (selected) {
      value.add(element);
    } else {
      value.remove(element);
    }

    didChange(value);
  }

  ///
  ///
  ///
  @override
  void didChange(Set<T>? value) {
    super.didChange(value);
    if (_effectiveController.value != value) {
      _effectiveController.value = value ?? <T>{};
    }
  }

  ///
  ///
  ///
  @override
  void reset() {
    super.reset();
    setState(() => _effectiveController.value = widget.initialValue ?? <T>{});
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

///
///
///
@immutable
class ChipEntry {
  final String label;
  final Color? color;
  final Color? textColor;
  final EdgeInsets? padding;
  final Color? selectedColor;
  final Color? selectedTextColor;

  ///
  ///
  ///
  const ChipEntry(
    this.label, {
    this.color,
    this.textColor,
    this.padding,
    this.selectedColor,
    this.selectedTextColor,
  });
}
