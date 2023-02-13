import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:folly_fields/responsive/responsive.dart';
import 'package:folly_fields/validators/time_validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
class TimeField extends ResponsiveStateful {
  final String labelPrefix;
  final String? label;
  final Widget? labelWidget;
  final TimeEditingController? controller;
  final FormFieldValidator<TimeOfDay?>? validator;
  final TextAlign textAlign;
  final FormFieldSetter<TimeOfDay?>? onSaved;
  final TimeOfDay? initialValue;
  final bool enabled;
  final AutovalidateMode autoValidateMode;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final ValueChanged<String?>? onFieldSubmitted;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final bool filled;
  final Color? fillColor;
  final bool readOnly;
  final void Function(TimeOfDay?)? lostFocus;
  final bool required;
  final InputDecoration? decoration;
  final EdgeInsets padding;
  final TimePickerEntryMode initialEntryMode;
  final bool clearOnCancel;
  final String? hintText;
  final EdgeInsets? contentPadding;

  ///
  ///
  ///
  const TimeField({
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
    this.readOnly = false,
    this.lostFocus,
    this.required = true,
    this.decoration,
    this.padding = const EdgeInsets.all(8),
    this.initialEntryMode = TimePickerEntryMode.dial,
    this.clearOnCancel = true,
    this.hintText,
    this.contentPadding,
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
        );

  ///
  ///
  ///
  @override
  TimeFieldState createState() => TimeFieldState();
}

///
///
///
class TimeFieldState extends State<TimeField> {
  final TimeValidator validator = TimeValidator();

  TimeEditingController? _controller;
  FocusNode? _focusNode;
  bool fromButton = false;

  ///
  ///
  ///
  TimeEditingController get _effectiveController =>
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
    if (widget.controller == null) {
      _controller = TimeEditingController(time: widget.initialValue);
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

    if (!fromButton &&
        !_effectiveFocusNode.hasFocus &&
        widget.lostFocus != null) {
      widget.lostFocus!(_effectiveController.time);
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
              hintText: widget.hintText,
              contentPadding: widget.contentPadding,
            ))
        .applyDefaults(Theme.of(context).inputDecorationTheme)
        .copyWith(
          suffixIcon: IconButton(
            icon: const Icon(FontAwesomeIcons.clock),
            onPressed: widget.enabled && !widget.readOnly
                ? () async {
                    try {
                      fromButton = true;

                      TimeOfDay? selectedTime = await showTimePicker(
                        context: context,
                        initialTime:
                            _effectiveController.time ?? TimeOfDay.now(),
                        initialEntryMode: widget.initialEntryMode,
                      );

                      fromButton = false;

                      if (selectedTime != null ||
                          (selectedTime == null && widget.clearOnCancel)) {
                        _effectiveController.time = selectedTime;
                      }
                      if (_effectiveFocusNode.canRequestFocus) {
                        _effectiveFocusNode.requestFocus();
                      }
                    } on Exception catch (e, s) {
                      if (kDebugMode) {
                        print('$e\n$s');
                      }
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

                String? message = validator.valid(value!);

                if (message != null) {
                  return message;
                }

                if (widget.validator != null) {
                  return widget.validator!(validator.parse(value));
                }

                return null;
              }
            : (_) => null,
        keyboardType: TextInputType.datetime,
        minLines: 1,
        inputFormatters: validator.inputFormatters,
        textAlign: widget.textAlign,
        maxLength: 5,
        onSaved: (String? value) => widget.enabled && widget.onSaved != null
            ? widget.onSaved!(validator.parse(value))
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
            : Theme.of(context).textTheme.titleMedium!.copyWith(
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

    _controller?.dispose();
    _focusNode?.dispose();

    super.dispose();
  }
}

///
///
///
class TimeEditingController extends TextEditingController {
  ///
  ///
  ///
  TimeEditingController({TimeOfDay? time})
      : super(text: time == null ? '' : TimeValidator().format(time));

  ///
  ///
  ///
  TimeEditingController.fromValue(TextEditingValue super.value)
      : super.fromValue();

  ///
  ///
  ///
  TimeOfDay? get time => TimeValidator().parse(text);

  ///
  ///
  ///
  set time(TimeOfDay? time) =>
      text = time == null ? '' : TimeValidator().format(time);
}
