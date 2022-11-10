import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:folly_fields/responsive/responsive.dart';
import 'package:folly_fields/validators/date_validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
// TODO(edufolly): Herdar de DateTimeField?
class DateField extends ResponsiveStateful {
  final String labelPrefix;
  final String? label;
  final Widget? labelWidget;
  final DateEditingController? controller;
  final FormFieldValidator<DateTime?>? validator;
  final TextAlign textAlign;
  final FormFieldSetter<DateTime?>? onSaved;
  final DateTime? initialValue;
  final bool enabled;
  final AutovalidateMode autoValidateMode;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final ValueChanged<String?>? onFieldSubmitted;
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
  final DatePickerEntryMode initialEntryMode;
  final DatePickerMode initialDatePickerMode;
  final bool clearOnCancel;
  final String? hintText;
  final EdgeInsets? contentPadding;

  ///
  ///
  ///
  const DateField({
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
    this.padding = const EdgeInsets.all(8),
    this.initialEntryMode = DatePickerEntryMode.calendar,
    this.initialDatePickerMode = DatePickerMode.day,
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
  DateFieldState createState() => DateFieldState();
}

///
///
///
class DateFieldState extends State<DateField> {
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
            icon: const Icon(FontAwesomeIcons.solidCalendarDays),
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
                        initialEntryMode: widget.initialEntryMode,
                        initialDatePickerMode: widget.initialDatePickerMode,
                      );

                      fromButton = false;

                      if (selectedDate != null ||
                          (selectedDate == null && widget.clearOnCancel)) {
                        _effectiveController.date = selectedDate;
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

                String? message = _validator!.valid(value!);

                if (message != null) {
                  return message;
                }

                if (widget.validator != null) {
                  return widget.validator!(_validator!.parse(value));
                }

                return null;
              }
            : (_) => null,
        keyboardType: TextInputType.datetime,
        minLines: 1,
        inputFormatters: _validator!.inputFormatters,
        textAlign: widget.textAlign,
        maxLength: widget.mask.length,
        onSaved: (String? value) => widget.enabled && widget.onSaved != null
            ? widget.onSaved!(_validator?.parse(value))
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

    _controller?.dispose();
    _focusNode?.dispose();

    super.dispose();
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
  DateEditingController.fromValue(TextEditingValue super.value)
      : super.fromValue();

  ///
  ///
  ///
  DateTime? get date => DateValidator().parse(text);

  ///
  ///
  ///
  set date(DateTime? date) =>
      text = date == null ? '' : DateValidator().format(date);
}
