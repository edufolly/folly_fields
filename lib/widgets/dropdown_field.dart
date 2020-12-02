import 'package:flutter/material.dart';

///
/// TODO - Implementar herança do FormField.
///
class DropdownField<T> extends StatelessWidget {
  final String prefix;
  final String label;
  final T initialValue;
  final Map<T, String> items;
  final ValueChanged<T> onChanged;
  final FormFieldValidator<T> validator;
  final FormFieldSetter<T> onSaved;
  final bool enabled;

  ///
  ///
  ///
  const DropdownField({
    Key key,
    this.prefix,
    this.label,
    @required this.initialValue,
    @required this.items,
    @required this.onChanged,
    this.validator,
    this.onSaved,
    this.enabled = true,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<T>(
        isExpanded: true,
        isDense: true,
        decoration: InputDecoration(
          labelText:
              prefix == null || prefix.isEmpty ? label : '$prefix - $label',
          border: OutlineInputBorder(),
          counterText: '',
        ),
        value: initialValue,
        items: items.keys
            .map(
              (T key) => DropdownMenuItem<T>(
                value: key,
                child: Text(items[key]),
              ),
            )
            .toList(),
        onChanged: enabled ? onChanged : (_) {},
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }
}
