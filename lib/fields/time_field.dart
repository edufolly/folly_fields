import 'package:flutter/material.dart';
import 'package:folly_fields/folly_fields.dart';
import 'package:folly_fields/responsive/responsive.dart';
import 'package:folly_fields/validators/time_validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
class TimeField extends StatefulResponsive {
  final String labelPrefix;
  final String label;
  final TimeEditingController? controller;
  final FormFieldValidator<TimeOfDay>? validator;
  final TextAlign textAlign;
  final FormFieldSetter<TimeOfDay>? onSaved;
  final TimeOfDay? initialValue;
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
  final void Function(TimeOfDay?)? lostFocus;
  final bool required;
  final InputDecoration? decoration;
  final EdgeInsets padding;

  ///
  ///
  ///
  const TimeField({
    this.labelPrefix = '',
    this.label = '',
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
    int? sizeExtraSmall,
    int? sizeSmall,
    int? sizeMedium,
    int? sizeLarge,
    int? sizeExtraLarge,
    double? minHeight,
    Key? key,
  })  : assert(initialValue == null || controller == null,
            'initialValue or controller must be null.'),
        super(
          sizeExtraSmall: sizeExtraSmall,
          sizeSmall: sizeSmall,
          sizeMedium: sizeMedium,
          sizeLarge: sizeLarge,
          sizeExtraLarge: sizeExtraLarge,
          minHeight: minHeight,
          key: key,
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
  void dispose() {
    _effectiveFocusNode.removeListener(_handleFocus);

    _controller?.dispose();
    _focusNode?.dispose();

    super.dispose();
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    final InputDecoration effectiveDecoration = (widget.decoration ??
            InputDecoration(
              border: const OutlineInputBorder(),
              filled: widget.filled,
              fillColor: widget.fillColor,
              labelText: widget.labelPrefix.isEmpty
                  ? widget.label
                  : '${widget.labelPrefix} - ${widget.label}',
              counterText: '',
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
                      );

                      fromButton = false;

                      _effectiveController.time = selectedTime;

                      if (_effectiveFocusNode.canRequestFocus) {
                        _effectiveFocusNode.requestFocus();
                      }
                    } catch (e, s) {
                      if (FollyFields().isDebug) {
                        // ignore: avoid_print
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
            : Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: Theme.of(context).disabledColor,
                ),
      ),
    );
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
  TimeEditingController.fromValue(TextEditingValue value)
      : super.fromValue(value);

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
