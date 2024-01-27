import 'package:dial_picker/dial_picker.dart';
import 'package:dial_picker/dial_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:folly_fields/controllers/duration_editing_controller.dart';
import 'package:folly_fields/fields/base_stateful_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
class DurationField
    extends BaseStatefulField<Duration, DurationEditingController> {
  final DurationUnit unit;
  final String yearSuffix;
  final String monthSuffix;
  final String daySuffix;
  final String hourSuffix;
  final String minuteSuffix;
  final String secondSuffix;
  final String millisecondSuffix;

  ///
  ///
  ///
  DurationField({
    this.unit = DurationUnit.minute,
    this.yearSuffix = 'y',
    this.monthSuffix = 'M',
    this.daySuffix = 'd',
    this.hourSuffix = 'h',
    this.minuteSuffix = 'm',
    this.secondSuffix = 's',
    this.millisecondSuffix = 'ms',
    super.suffixIconData = FontAwesomeIcons.stopwatch,
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
    super.counterText,
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
  })  : assert(
          <String>{
                yearSuffix,
                monthSuffix,
                daySuffix,
                hourSuffix,
                minuteSuffix,
                secondSuffix,
                millisecondSuffix,
              }.length ==
              7,
          'suffixes should all be different between them.',
        ),
        assert(
          !RegExp('[^a-zA-Z]').hasMatch(yearSuffix) &&
              !RegExp('[^a-zA-Z]').hasMatch(monthSuffix) &&
              !RegExp('[^a-zA-Z]').hasMatch(daySuffix) &&
              !RegExp('[^a-zA-Z]').hasMatch(hourSuffix) &&
              !RegExp('[^a-zA-Z]').hasMatch(minuteSuffix) &&
              !RegExp('[^a-zA-Z]').hasMatch(secondSuffix) &&
              !RegExp('[^a-zA-Z]').hasMatch(millisecondSuffix),
          'Suffixes should only have [a-zA-Z] characters',
        );

  ///
  ///
  ///
  @override
  DurationEditingController createController() => DurationEditingController(
        duration: initialValue,
        yearSuffix: yearSuffix,
        monthSuffix: monthSuffix,
        daySuffix: daySuffix,
        hourSuffix: hourSuffix,
        minuteSuffix: minuteSuffix,
        secondSuffix: secondSuffix,
        millisecondSuffix: millisecondSuffix,
      );

  ///
  ///
  ///
  @override
  Future<Duration?> selectData({
    required BuildContext context,
    required DurationEditingController controller,
  }) =>
      showDialPicker(
        context: context,
        initialTime: controller.data ?? Duration.zero,
        baseUnit: unit.baseUnit,
      );
}

///
///
///
enum DurationUnit {
  millisecond(BaseUnit.millisecond),
  second(BaseUnit.second),
  minute(BaseUnit.minute),
  hour(BaseUnit.hour);

  final BaseUnit baseUnit;

  ///
  ///
  ///
  const DurationUnit(this.baseUnit);
}
