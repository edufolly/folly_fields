import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final TextStyle? textStyle;
  final String? labelText;
  final String? hintText;
  final bool isDense;
  final double? iconSize;
  final IconData prefixIcon;
  final IconData clearIcon;

  const SearchField(
    this.controller, {
    this.textStyle,
    this.labelText,
    this.hintText,
    this.isDense = true,
    this.iconSize,
    this.prefixIcon = FontAwesomeIcons.magnifyingGlass,
    this.clearIcon = FontAwesomeIcons.xmark,
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    return TextField(
      controller: controller,
      style: textStyle,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        labelText: labelText,
        isDense: isDense,
        hintText: hintText,
        prefixIcon: Icon(prefixIcon, size: iconSize),
        suffixIcon: controller.text.isEmpty
            ? null
            : IconButton(
                onPressed: controller.clear,
                icon: Icon(clearIcon, size: iconSize),
              ),
      ),
    );
  }
}
