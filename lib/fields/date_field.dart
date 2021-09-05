import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folly_fields/folly_fields.dart';
import 'package:folly_fields/validators/date_validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
/// TODO - Herdar de DateTimeField.
///
class DateField extends StatefulWidget {
  final String prefix;
  final String label;
  final DateEditingController? controller;
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
  final Color? fillColor;
  final bool readOnly;
  final void Function(DateTime?)? lostFocus;
  final dynamic locale;
  final String format;
  final String mask;
  final bool required;
  final InputDecoration? decoration;
  final EdgeInsets padding;

  ///
  ///
  ///
  const DateField({
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
    this.fillColor,
    this.readOnly = false,
    this.lostFocus,
    this.locale = 'pt_br',
    this.format = 'dd/MM/yyyy',
    this.mask = '##/##/####',
    this.required = true,
    this.decoration,
    this.padding = const EdgeInsets.all(8.0),
  })  : assert(initialValue == null || controller == null),
        super(key: key);

  ///
  ///
  ///
  @override
  _DateFieldState createState() => _DateFieldState();
}

///
///
///
class _DateFieldState extends State<DateField> {
  DateValidator? _validator;
  DateEditingController? _controller;
  FocusNode? _focusNode;
  bool fromButton = false;

  ///
  ///
  ///
  DateEditingController get _effectiveController =>
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

    _validator = DateValidator(
      locale: widget.locale,
      format: widget.format,
      mask: widget.mask,
    );

    if (widget.controller == null) {
      _controller = DateEditingController(dateTime: widget.initialValue);
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
      widget.lostFocus!(_effectiveController.date);
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
              labelText: widget.prefix.isEmpty
                  ? widget.label
                  : '${widget.prefix} - ${widget.label}',
              counterText: '',
            ))
        .applyDefaults(Theme.of(context).inputDecorationTheme)
        .copyWith(
          suffixIcon: IconButton(
            icon: const Icon(FontAwesomeIcons.solidCalendarAlt),
            onPressed: widget.enabled && !widget.readOnly
                ? () async {
                    try {
                      fromButton = true;

                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate:
                            _effectiveController.date ?? DateTime.now(),
                        firstDate: widget.firstDate ?? DateTime(1900),
                        lastDate: widget.lastDate ?? DateTime(2100),
                      );

                      fromButton = false;

                      _effectiveController.date = selectedDate;

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
class DateEditingController extends TextEditingController {
  ///
  ///
  ///
  DateEditingController({DateTime? dateTime})
      : super(text: dateTime == null ? '' : DateValidator().format(dateTime));

  ///
  ///
  ///
  DateEditingController.fromValue(TextEditingValue value)
      : super.fromValue(value);

  ///
  ///
  ///
  DateTime? get date => DateValidator().parse(text);

  ///
  ///
  ///
  set date(DateTime? date) =>
      text = (date == null ? '' : DateValidator().format(date));
}
