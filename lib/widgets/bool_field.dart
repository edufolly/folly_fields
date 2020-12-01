import 'package:flutter/material.dart';

///
/// TODO - Implementar herança do FormField.
///
class BoolField extends StatelessWidget {
  final String prefix;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool enabled;

  ///
  ///
  ///
  const BoolField({
    Key key,
    this.prefix,
    this.label,
    this.value = false,
    @required this.onChanged,
    this.enabled = true,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(color: Colors.black45),
        ),
        child: SwitchListTile.adaptive(
          title: Text(
            prefix == null || prefix.isEmpty ? label : '$prefix - $label',
            style: TextStyle(color: Colors.black45),
          ),
          value: value,
          onChanged: enabled ? onChanged : (_) {},
        ),
      ),
    );
  }
}
