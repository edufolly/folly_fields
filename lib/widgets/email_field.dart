import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folly_fields/util/field_helper.dart';

///
///
///
class EmailField extends StatelessWidget {
  final String prefix;
  final String label;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final int minLines;
  final int maxLines;
  final bool obscureText;
  final List<TextInputFormatter> inputFormatter;
  final TextAlign textAlign;
  final int maxLength;
  final FormFieldSetter<String> onSaved;
  final String initialValue;
  final bool enabled;
  final AutovalidateMode autoValidateMode;
  final ValueChanged<String> onChanged;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final ValueChanged<String> onFieldSubmitted;
  final bool autocorrect;
  final bool enableSuggestions;
  final TextCapitalization textCapitalization;
  final String validatorMessage;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;

  ///
  ///
  ///
  const EmailField({
    Key key,
    this.prefix,
    this.label,
    this.controller,
    this.validator,
    this.minLines = 1,
    this.maxLines = 1,
    this.obscureText = false,
    this.inputFormatter,
    this.textAlign = TextAlign.left,
    this.maxLength,
    this.onSaved,
    this.initialValue,
    this.enabled = true,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.onChanged,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.textCapitalization = TextCapitalization.none,
    this.validatorMessage = 'Informe o e-mail.',
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection = true,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText:
              prefix == null || prefix.isEmpty ? label : '$prefix - $label',
          border: OutlineInputBorder(),
          counterText: '',
          enabled: enabled,
        ),
        validator: validator ??
            (String value) => FieldHelper.validators[FieldType.email](value)
                ? null
                : validatorMessage,
        minLines: 1,
        maxLines: 1,
        obscureText: false,
        inputFormatters: inputFormatter,
        textAlign: textAlign,
        maxLength: maxLength,
        onSaved: onSaved,
        initialValue: initialValue,
        enabled: enabled,
        autovalidateMode: autoValidateMode,
        onChanged: onChanged,
        focusNode: focusNode,
        textInputAction: textInputAction,
        onFieldSubmitted: onFieldSubmitted,
        autocorrect: false,
        enableSuggestions: false,
        textCapitalization: TextCapitalization.none,
        scrollPadding: scrollPadding,
        enableInteractiveSelection: enableInteractiveSelection,
        style: enabled
            ? null
            : Theme.of(context).textTheme.subtitle1.copyWith(
                  color: Theme.of(context).disabledColor,
                ),
      ),
    );
  }
}
