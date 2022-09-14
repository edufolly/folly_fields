import 'package:dial_picker/dial_picker.dart';
import 'package:dial_picker/dial_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:folly_fields/responsive/responsive.dart';
import 'package:folly_fields/validators/duration_validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
class DurationField extends StatefulResponsive {
  final String labelPrefix;
  final String? label;
  final Widget? labelWidget;
  final DurationEditingController? controller;
  final String? Function(Duration value)? validator;
  final TextAlign textAlign;
  final void Function(Duration value)? onSaved;
  final Duration? initialValue;
  final bool enabled;
  final AutovalidateMode autoValidateMode;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final bool filled;
  final Color? fillColor;
  final bool readOnly;
  final void Function(Duration)? lostFocus;
  final InputDecoration? decoration;
  final EdgeInsets padding;
  final bool required;
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
    this.labelPrefix = '',
    this.label,
    this.labelWidget,
    this.controller,
    this.validator,
    this.textAlign = TextAlign.start,
    this.onSaved,
    this.initialValue,
    this.enabled = true,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
    this.scrollPadding = const EdgeInsets.all(20),
    this.enableInteractiveSelection = true,
    this.filled = false,
    this.fillColor,
    this.lostFocus,
    this.readOnly = false,
    this.decoration,
    this.padding = const EdgeInsets.all(8),
    this.required = true,
    this.unit = DurationUnit.minute,
    this.yearSuffix = 'y',
    this.monthSuffix = 'M',
    this.daySuffix = 'd',
    this.hourSuffix = 'h',
    this.minuteSuffix = 'm',
    this.secondSuffix = 's',
    this.millisecondSuffix = 'ms',
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
        assert(
          <String>{
                yearSuffix,
                monthSuffix,
                daySuffix,
                hourSuffix,
                minuteSuffix,
                secondSuffix,
                millisecondSuffix
              }.length ==
              7,
          'suffixes should all be differents between them.',
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
  DurationFieldState createState() => DurationFieldState();
}

///
///
///
class DurationFieldState extends State<DurationField> {
  DurationEditingController? _controller;
  FocusNode? _focusNode;
  DurationValidator? _validator;

  ///
  ///
  ///
  DurationEditingController get _effectiveController =>
      widget.controller ?? _controller!;

  ///
  ///
  ///
  FocusNode get _effectiveFocusNode => widget.focusNode ?? _focusNode!;

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();

    _validator = DurationValidator();

    if (widget.controller == null) {
      _controller = DurationEditingController(
        widget.initialValue!,
        yearSuffix: widget.yearSuffix,
        monthSuffix: widget.monthSuffix,
        daySuffix: widget.daySuffix,
        hourSuffix: widget.hourSuffix,
        minuteSuffix: widget.minuteSuffix,
        secondSuffix: widget.secondSuffix,
        millisecondSuffix: widget.millisecondSuffix,
      );
    }

    if (widget.focusNode == null) {
      _focusNode = FocusNode();
    }

    _effectiveFocusNode.addListener(_handleFocus);
  }

  ///
  ///
  ///
  void _handleFocus() {
    if (_effectiveFocusNode.hasFocus) {
      _effectiveController.selection = TextSelection(
        baseOffset: 0,
        extentOffset: _effectiveController.text.length,
      );
    }
    if (!_effectiveFocusNode.hasFocus) {
      _effectiveController.duration = _effectiveController.duration;
      widget.lostFocus?.call(_effectiveController.duration);
    }
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    InputDecoration effectiveDecoration = (widget.decoration ??
            InputDecoration(
              border: const OutlineInputBorder(),
              filled: widget.filled,
              fillColor: widget.fillColor,
              label: widget.labelWidget,
              labelText: widget.labelPrefix.isEmpty
                  ? widget.label
                  : '${widget.labelPrefix} - ${widget.label}',
              counterText: '',
            ))
        .applyDefaults(Theme.of(context).inputDecorationTheme)
        .copyWith(
          suffixIcon: IconButton(
            icon: const Icon(FontAwesomeIcons.stopwatch),
            onPressed: widget.enabled && !widget.readOnly
                ? () async {
                    Duration? dur = await showDialPicker(
                      context: context,
                      initialTime: _controller?.duration ?? Duration.zero,
                      baseUnit: widget.unit.toBaseUnit,
                    );
                    if (dur != null) {
                      _effectiveController.duration = dur;
                    }
                  }
                : null,
          ),
        );

    return Padding(
      padding: widget.padding,
      child: TextFormField(
        controller: _effectiveController,
        decoration: effectiveDecoration,
        validator: widget.enabled
            ? (String? value) {
                if (!widget.required && (value == null || value.isEmpty)) {
                  return null;
                }

                String? message = _validator!.valid(value!);

                if (message != null) {
                  return message;
                }

                if (widget.validator != null) {
                  Duration? dur = _validator!.parse(value);
                  if (dur != null) {
                    return widget.validator!(dur);
                  }
                }

                return null;
              }
            : (_) => null,
        keyboardType: TextInputType.datetime,
        minLines: 1,
        inputFormatters: _validator!.inputFormatters,
        textAlign: widget.textAlign,
        onSaved: (String? value) => widget.enabled && widget.onSaved != null
            ? widget.onSaved!(_validator?.parse(value) ?? Duration.zero)
            : null,
        enabled: widget.enabled,
        autovalidateMode: widget.autoValidateMode,
        focusNode: _effectiveFocusNode,
        textInputAction: widget.textInputAction,
        onFieldSubmitted: widget.onFieldSubmitted,
        autocorrect: false,
        enableSuggestions: false,
        scrollPadding: widget.scrollPadding,
        enableInteractiveSelection: widget.enableInteractiveSelection,
        readOnly: widget.readOnly,
        style: widget.enabled && !widget.readOnly
            ? null
            : Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: Theme.of(context).disabledColor,
                ),
      ),
    );
  }

  ///
  ///
  ///
  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_handleFocus);

    if (_controller != null) {
      _controller!.dispose();
    }

    if (_focusNode != null) {
      _focusNode!.dispose();
    }

    super.dispose();
  }
}

///
///
///
class DurationEditingController extends TextEditingController {
  final DurationValidator validator;

  ///
  ///
  ///
  DurationEditingController(
    Duration value, {
    required String yearSuffix,
    required String monthSuffix,
    required String daySuffix,
    required String hourSuffix,
    required String minuteSuffix,
    required String secondSuffix,
    required String millisecondSuffix,
  }) : validator = DurationValidator(
          yearSuffix: yearSuffix,
          monthSuffix: monthSuffix,
          daySuffix: daySuffix,
          hourSuffix: hourSuffix,
          minuteSuffix: minuteSuffix,
          secondSuffix: secondSuffix,
          millisecondSuffix: millisecondSuffix,
        ) {
    super.text = validator.format(value);
    // addListener(_changeListener);
  }

  ///
  ///
  ///
  set duration(Duration newDuration) {
    super.text = validator.format(newDuration);
  }

  ///
  ///
  ///
  Duration get duration {
    return validator.parse(super.text) ?? Duration.zero;
  }

  ///
  ///
  ///
// void _changeListener() {
//   super.value = super.value.copyWith(text:)
//   duration = validator.parse(super.text) ?? Duration.zero;
// }

  ///
  ///
  ///
// @override
// void dispose() {
//   removeListener(_changeListener);
//   super.dispose();
// }
}

///
///
///
enum DurationUnit {
  millisecond,
  second,
  minute,
  hour,
}

///
///
///
extension DurationUnitExtension on DurationUnit {
  BaseUnit get toBaseUnit {
    switch (this) {
      case DurationUnit.millisecond:
        return BaseUnit.millisecond;
      case DurationUnit.second:
        return BaseUnit.second;
      case DurationUnit.minute:
        return BaseUnit.minute;
      case DurationUnit.hour:
        return BaseUnit.hour;
    }
  }
}
