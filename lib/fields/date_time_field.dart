import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folly_fields/util/folly_utils.dart';
import 'package:folly_fields/validators/date_time_validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
class DateTimeField extends StatefulWidget {
  final String prefix;
  final String label;
  final DateTimeEditingController? controller;
  final FormFieldValidator<DateTime>? validator;
  final TextAlign textAlign;
  final FormFieldSetter<DateTime>? onSaved;
  final DateTime? initialValue;
  final bool enabled;
  final AutovalidateMode autoValidateMode;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final bool filled;
  final void Function(DateTime?)? lostFocus;
  final dynamic locale;
  final String format;
  final String mask;
  final bool required;

  ///
  ///
  ///
  DateTimeField({
    Key? key,
    this.prefix = '',
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
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection = true,
    this.firstDate,
    this.lastDate,
    this.filled = false,
    this.lostFocus,
    this.locale = 'pt_br',
    this.format = 'dd/MM/yyyy HH:mm',
    this.mask = '##/##/#### A#:C#',
    this.required = true,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  _DateTimeFieldState createState() => _DateTimeFieldState();
}

///
///
///
class _DateTimeFieldState extends State<DateTimeField> {
  DateTimeValidator? _validator;
  DateTimeEditingController? _controller;
  FocusNode? _focusNode;

  ///
  ///
  ///
  DateTimeEditingController get _effectiveController =>
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

    _validator = DateTimeValidator(
      locale: widget.locale,
      format: widget.format,
      mask: widget.mask,
    );

    if (widget.controller == null) {
      _controller = DateTimeEditingController(dateTime: widget.initialValue);
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

    if (!_effectiveFocusNode.hasFocus && widget.lostFocus != null) {
      widget.lostFocus!(_effectiveController.dateTime);
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
    final InputDecoration effectiveDecoration = InputDecoration(
      border: OutlineInputBorder(),
      filled: widget.filled,
      labelText: widget.prefix.isEmpty
          ? widget.label
          : '${widget.prefix} - ${widget.label}',
      counterText: '',
      suffixIcon: IconButton(
        icon: Icon(FontAwesomeIcons.calendarDay),
        onPressed: () async {
          try {
            DateTime? selectedDate = await showDatePicker(
              context: context,
              initialDate: _effectiveController.dateTime ?? DateTime.now(),
              firstDate: widget.firstDate ?? DateTime(1900),
              lastDate: widget.lastDate ?? DateTime(2100),
            );

            if (selectedDate != null) {
              TimeOfDay initialTime = TimeOfDay.now();

              try {
                initialTime = TimeOfDay.fromDateTime(selectedDate);
              } catch (e) {
                // Do nothing.
              }

              TimeOfDay? selectedTime = await showTimePicker(
                context: context,
                initialTime: initialTime,
              );

              selectedTime ??= TimeOfDay(hour: 0, minute: 0);

              _effectiveController.dateTime = FollyUtils.dateMergeStart(
                date: selectedDate,
                time: selectedTime,
              );
            }
          } catch (e, s) {
            print(e);
            print(s);
          }
        },
      ),
    ).applyDefaults(Theme.of(context).inputDecorationTheme);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _effectiveController,
        decoration: effectiveDecoration,
        validator: widget.enabled
            ? (String? value) {
                if (!widget.required && (value == null || value.isEmpty)) {
                  return null;
                }

                String? message = _validator!.valid(value!);

                if (message != null) return message;

                if (widget.validator != null) {
                  return widget.validator!(_validator!.parse(value));
                }

                return null;
              }
            : (_) => null,
        keyboardType: TextInputType.datetime,
        minLines: 1,
        maxLines: 1,
        obscureText: false,
        inputFormatters: _validator!.inputFormatters,
        textAlign: widget.textAlign,
        maxLength: widget.mask.length,
        onSaved: widget.enabled
            ? (String? value) => widget.onSaved != null
                ? widget.onSaved!(_validator!.parse(value))
                : null
            : null,
        enabled: widget.enabled,
        autovalidateMode: widget.autoValidateMode,
        focusNode: _effectiveFocusNode,
        textInputAction: widget.textInputAction,
        onFieldSubmitted: widget.onFieldSubmitted,
        autocorrect: false,
        enableSuggestions: false,
        textCapitalization: TextCapitalization.none,
        scrollPadding: widget.scrollPadding,
        enableInteractiveSelection: widget.enableInteractiveSelection,
        style: widget.enabled
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
class DateTimeEditingController extends TextEditingController {
  ///
  ///
  ///
  DateTimeEditingController({DateTime? dateTime})
      : super(text: dateTime == null ? '' : DateTimeValidator().format(dateTime));

  ///
  ///
  ///
  DateTimeEditingController.fromValue(TextEditingValue value)
      : super.fromValue(value);

  ///
  ///
  ///
  DateTime? get dateTime => DateTimeValidator().parse(text);

  ///
  ///
  ///
  set dateTime(DateTime? dateTime) =>
      text = (dateTime == null ? '' : DateTimeValidator().format(dateTime));
}
