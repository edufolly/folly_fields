import 'package:flutter/material.dart';
import 'package:folly_fields/controllers/dropdown_editing_controller.dart';
import 'package:folly_fields/responsive/responsive_form_field.dart';

class DropdownField<T, I extends Widget> extends ResponsiveFormField<T> {
  final DropdownEditingController<T, I>? controller;
  final Map<T, I>? items;

  DropdownField({
    final String? labelPrefix,
    final String? label,
    final Widget? labelWidget,
    this.controller,
    final FormFieldValidator<T?>? validator,
    super.onSaved,
    final T? initialValue,
    this.items,
    super.enabled,
    final AutovalidateMode autoValidateMode = AutovalidateMode.disabled,
    final Function(T? value)? onChanged,
    final bool filled = false,
    final Color? fillColor,
    final DropdownButtonBuilder? selectedItemBuilder,
    final Widget? hint,
    final Widget? disabledHint,
    final Color? focusColor,
    final int elevation = 8,
    final TextStyle? style,
    final Widget? icon,
    final Color? iconDisabledColor,
    final Color? iconEnabledColor,
    final double iconSize = 24.0,
    final bool isDense = true,
    final bool isExpanded = false,
    final double? itemHeight,
    final FocusNode? focusNode,
    final bool autofocus = false,
    final Color? dropdownColor,
    final InputDecoration? decoration,
    final EdgeInsets padding = const EdgeInsets.all(8),
    final String? hintText,
    final EdgeInsets? contentPadding,
    super.sizeExtraSmall,
    super.sizeSmall,
    super.sizeMedium,
    super.sizeLarge,
    super.sizeExtraLarge,
    super.minHeight,
    super.key,
  }) : assert(
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
         builder: (final FormFieldState<T?> field) {
           _DropdownFieldState<T, I> state = field as _DropdownFieldState<T, I>;

           InputDecoration effectiveDecoration =
               (decoration ??
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
                 builder: (final BuildContext context) {
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
                             ? (final T? value) {
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

  @override
  FormFieldState<T> createState() => _DropdownFieldState<T, I>();
}

class _DropdownFieldState<T, I extends Widget> extends FormFieldState<T> {
  DropdownEditingController<T, I>? _controller;

  @override
  DropdownField<T, I> get widget => super.widget as DropdownField<T, I>;

  DropdownEditingController<T, I> get _effectiveController =>
      widget.controller ?? _controller!;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = DropdownEditingController<T, I>(
        value: widget.initialValue,
        items: widget.items,
      );
    } else {
      widget.controller!.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(final DropdownField<T, I> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);

      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _controller = DropdownEditingController<T, I>.fromValue(
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

  @override
  void didChange(final T? value) {
    super.didChange(value);
    if (_effectiveController.value != value) {
      _effectiveController.value = value;
    }
  }

  @override
  void reset() {
    super.reset();
    setState(() => _effectiveController.value = widget.initialValue);
  }

  void _handleControllerChanged() {
    if (_effectiveController.value != value) {
      didChange(_effectiveController.value);
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    _controller?.dispose();
    super.dispose();
  }
}
