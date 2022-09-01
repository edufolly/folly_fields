import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folly_fields/fields/string_field.dart';

///
///
///
class IntegerField extends StringField {
  ///
  ///
  ///
  IntegerField({
    super.labelPrefix,
    super.label,
    super.labelWidget,
    IntegerEditingController? super.controller,
    FormFieldValidator<int?>? validator,
    super.textAlign = TextAlign.end,
    super.maxLength,
    FormFieldSetter<int?>? onSaved,
    int? initialValue,
    super.enabled,
    super.autoValidateMode,
    super.onChanged,
    super.focusNode,
    super.textInputAction,
    super.onFieldSubmitted,
    super.scrollPadding,
    super.enableInteractiveSelection,
    super.filled,
    super.fillColor,
    super.autofillHints,
    super.readOnly,
    super.style,
    super.decoration,
    super.padding,
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
          keyboard: TextInputType.number,
          validator: (String? value) {
            if (enabled && validator != null) {
              return validator(int.tryParse(value ?? ''));
            }
            return null;
          },
          minLines: 1,
          maxLines: 1,
          obscureText: false,
          inputFormatter: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp('^-?[0-9]*')),
          ],
          onSaved: (String? value) {
            if (enabled && onSaved != null) {
              return onSaved(int.tryParse(value ?? ''));
            }
          },
          initialValue: initialValue?.toString(),
          autocorrect: false,
          enableSuggestions: false,
          textCapitalization: TextCapitalization.none,
        );
}

///
///
///
class IntegerEditingController extends TextEditingController {
  ///
  ///
  ///
  IntegerEditingController({int? value}) : super(text: value?.toString());

  ///
  ///
  ///
  int? get integer => int.tryParse(text);

  ///
  ///
  ///
  set integer(int? integer) => text = integer.toString();
}
