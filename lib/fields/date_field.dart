import 'package:flutter/material.dart';
import 'package:folly_fields/controllers/date_editing_controller.dart';
import 'package:folly_fields/fields/base_stateful_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
class DateField extends BaseStatefulField<DateTime, DateEditingController> {
  final DatePickerEntryMode initialEntryMode;
  final DatePickerMode initialDatePickerMode;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String locale;
  final String dateFormat;
  final String mask;

  ///
  ///
  ///
  const DateField({
    this.initialEntryMode = DatePickerEntryMode.calendar,
    this.initialDatePickerMode = DatePickerMode.day,
    this.firstDate,
    this.lastDate,
    this.locale = 'pt_br',
    this.dateFormat = 'dd/MM/yyyy',
    this.mask = 'B#/D#/####',
    super.suffixIconData = FontAwesomeIcons.solidCalendarDays,
    super.labelPrefix = '',
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
  }) : super(maxLength: mask.length);

  ///
  ///
  ///
  @override
  DateEditingController createController() => DateEditingController(
        value: initialValue,
        locale: locale,
        dateFormat: dateFormat,
        mask: mask,
      );

  ///
  ///
  ///
  @override
  Future<DateTime?> selectData({
    required BuildContext context,
    required DateEditingController controller,
  }) =>
      showDatePicker(
        context: context,
        initialDate: controller.data ?? DateTime.now(),
        firstDate: firstDate ?? DateTime(1900),
        lastDate: lastDate ?? DateTime(2100),
        initialEntryMode: initialEntryMode,
        initialDatePickerMode: initialDatePickerMode,
      );
}
