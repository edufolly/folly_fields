import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folly_fields/validators/date_validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
class DateField extends StatefulWidget {
  final String prefix;
  final String label;
  final DateEditingController controller;
  final FormFieldValidator<DateTime> validator;
  final TextAlign textAlign;
  final FormFieldSetter<DateTime> onSaved;
  final DateTime initialValue;
  final bool enabled;
  final AutovalidateMode autoValidateMode;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final ValueChanged<String> onFieldSubmitted;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final DateTime firstDate;
  final DateTime lastDate;
  final bool filled;
  final void Function(DateTime) lostFocus;

  ///
  ///
  ///
  DateField({
    Key key,
    this.prefix,
    this.label,
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
  }) : super(key: key);

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
  final DateValidator validator = DateValidator();

  DateEditingController _controller;
  FocusNode _focusNode;

  ///
  ///
  ///
  DateEditingController get _effectiveController =>
      widget.controller ?? _controller;

  ///
  ///
  ///
  FocusNode get _effectiveFocusNode => widget.focusNode ?? _focusNode;

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = DateEditingController(date: widget.initialValue);
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
      widget.lostFocus(_effectiveController.date);
    }
  }

  ///
  ///
  ///
  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_handleFocus);

    if (_controller != null) _controller.dispose();
    if (_focusNode != null) _focusNode.dispose();

    super.dispose();
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    Color rootColor = Theme.of(context).primaryColor;

    final InputDecoration effectiveDecoration = InputDecoration(
      border: OutlineInputBorder(),
      filled: widget.filled,
      labelText: widget.prefix == null || widget.prefix.isEmpty
          ? widget.label
          : '${widget.prefix} - ${widget.label}',
      counterText: '',
      suffixIcon: IconButton(
        icon: Icon(FontAwesomeIcons.calendarDay),
        onPressed: () async {
          try {
            DateTime selectedDate = await showDatePicker(
              context: context,
              initialDate: _effectiveController.date ?? DateTime.now(),
              firstDate: widget.firstDate ?? DateTime(1900),
              lastDate: widget.lastDate ?? DateTime(2100),
              builder: (BuildContext context, Widget child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    primaryColor: rootColor,
                    accentColor: rootColor,
                    colorScheme: ColorScheme.light(primary: rootColor),
                  ),
                  child: child,
                );
              },
            );

            if (selectedDate != null) {
              _effectiveController.date = selectedDate;
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
            ? (String value) => widget.validator != null
                ? widget.validator(validator.parse(value))
                : null
            : (_) => null,
        keyboardType: TextInputType.datetime,
        minLines: 1,
        maxLines: 1,
        obscureText: false,
        inputFormatters: validator.inputFormatters,
        textAlign: widget.textAlign,
        maxLength: 10,
        onSaved: widget.enabled
            ? (String value) => widget.onSaved != null
                ? widget.onSaved(validator.parse(value))
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
            : Theme.of(context).textTheme.subtitle1.copyWith(
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
  DateEditingController({DateTime date})
      : super(text: date == null ? '' : DateValidator().format(date));

  ///
  ///
  ///
  DateEditingController.fromValue(TextEditingValue value)
      : super.fromValue(value);

  ///
  ///
  ///
  DateTime get date => DateValidator().parse(text);

  ///
  ///
  ///
  set date(DateTime dateTime) => text = DateValidator().format(dateTime);
}
