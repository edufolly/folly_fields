import 'package:flutter/material.dart';
import 'package:folly_fields/controllers/time_editing_controller.dart';
import 'package:folly_fields/fields/base_stateful_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TimeField extends BaseStatefulField<TimeOfDay, TimeEditingController> {
  final TimePickerEntryMode initialEntryMode;

  const TimeField({
    this.initialEntryMode = TimePickerEntryMode.dial,
    super.maxLength = 5,
    super.suffixIconData = FontAwesomeIcons.clock,
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
    super.readOnly = false,
    super.style,
    super.decoration,
    super.padding = const EdgeInsets.all(8),
    super.hintText,
    super.contentPadding,
    super.counterText,
    super.prefix,
    super.prefixIcon,
    super.onTap,
    super.required = true,
    super.clearOnCancel = true,
    super.lostFocus,
    super.sizeExtraSmall,
    super.sizeSmall,
    super.sizeMedium,
    super.sizeLarge,
    super.sizeExtraLarge,
    super.minHeight,
    super.key,
  });

  @override
  TimeEditingController createController(TimeOfDay? value) =>
      TimeEditingController(value: value);

  @override
  Future<TimeOfDay?> selectData({
    required BuildContext context,
    required TimeEditingController controller,
  }) => showTimePicker(
    context: context,
    initialTime: controller.data ?? TimeOfDay.now(),
    initialEntryMode: initialEntryMode,
  );
}
