import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///
/// TODO - Implementar herança do FormField. Será?
///
class StringField extends StatelessWidget {
  final String prefix;
  final String label;
  final TextEditingController controller;
  final TextInputType keyboard;
  final FormFieldValidator<String> validator;
  final String keyStart;
  final int minLines;
  final int maxLines;
  final bool obscureText;
  final List<TextInputFormatter> inputFormatter;
  final TextAlign textAlign;
  final bool readOnly;
  final int maxLength;
  final FormFieldSetter<String> onSaved;
  final String initialValue;
  final bool enabled;
  final ValueChanged<String> onChanged;
  final FocusNode focusNode;

  ///
  ///
  ///
  const StringField({
    Key key,
    @required this.prefix,
    @required this.label,
    this.controller,
    this.keyboard = TextInputType.text,
    this.validator,
    this.keyStart,
    this.minLines = 1,
    this.maxLines = 1,
    this.obscureText = false,
    this.inputFormatter,
    this.textAlign = TextAlign.left,
    this.readOnly = false,
    this.maxLength,
    this.onSaved,
    this.initialValue,
    @required this.enabled,
    this.onChanged,
    this.focusNode,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        key: Key('${keyStart}TextFormField'),
        controller: controller,
        keyboardType: keyboard,
        decoration: InputDecoration(
          labelText:
              prefix == null || prefix.isEmpty ? label : '$prefix - $label',
          border: OutlineInputBorder(),
          counterText: '',
          enabled: enabled,
        ),
        validator: validator,
        minLines: minLines,
        maxLines: maxLines,
        obscureText: obscureText,
        inputFormatters: inputFormatter,
        textAlign: textAlign,
        readOnly: readOnly,
        maxLength: maxLength,
        onSaved: onSaved,
        initialValue: initialValue,
        enabled: enabled,
        onChanged: onChanged,
        focusNode: focusNode,
        style: enabled
            ? null
            : Theme.of(context).textTheme.subtitle1.copyWith(
                  color: Theme.of(context).disabledColor,
                ),
      ),
    );
  }
}
