import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:folly_fields/controllers/color_editing_controller.dart';
import 'package:folly_fields/fields/base_stateful_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
class ColorField extends BaseStatefulField<Color, ColorEditingController> {
  ///
  ///
  ///
  ColorField({
    super.maxLength = 8,
    super.suffixIconData = FontAwesomeIcons.palette,
    super.labelPrefix,
    super.label,
    super.labelWidget,
    super.controller,
    super.validator,
    super.textAlign = TextAlign.start,
    super.onSaved,
    super.initialValue,
    super.enabled = true,
    super.autoValidateMode = AutovalidateMode.disabled,
    super.focusNode,
    super.textInputAction,
    super.onFieldSubmitted,
    super.scrollPadding = const EdgeInsets.all(20),
    super.enableInteractiveSelection = true,
    super.filled = false,
    super.fillColor,
    super.readOnly = false,
    super.style,
    super.decoration,
    super.padding = const EdgeInsets.all(8),
    super.hintText,
    super.contentPadding,
    super.prefix,
    super.prefixIcon,
    super.onTap,
    super.lostFocus,
    super.required = true,
    super.clearOnCancel = true,
    super.sizeExtraSmall,
    super.sizeSmall,
    super.sizeMedium,
    super.sizeLarge,
    super.sizeExtraLarge,
    super.minHeight,
    super.key,
  }) : super(
          updatePrefixIcon: (BuildContext context, Color? color, _) => Icon(
            FontAwesomeIcons.solidSquare,
            color: color,
          ),
        );

  ///
  ///
  ///
  @override
  ColorEditingController createController() =>
      ColorEditingController(color: initialValue);

  ///
  ///
  ///
  @override
  Future<Color?> selectData({
    required BuildContext context,
    required ColorEditingController controller,
  }) {
    return showDialog<Color?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: controller.data ?? controller.pickerColor.value,
              onColorChanged: (Color value) =>
                  controller.pickerColor.value = value,
              portraitOnly: true,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
            ),
            ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).pop(controller.pickerColor.value),
              child: Text(MaterialLocalizations.of(context).okButtonLabel),
            ),
          ],
        );
      },
    );
  }
}
