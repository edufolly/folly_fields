import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folly_fields/validators/time_validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
class TimeField extends StatefulWidget {
  final String prefix;
  final String label;
  final TimeEditingController controller;
  final FormFieldValidator<TimeOfDay> validator;
  final TextAlign textAlign;
  final FormFieldSetter<TimeOfDay> onSaved;
  final TimeOfDay initialValue;
  final bool enabled;
  final AutovalidateMode autoValidateMode;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final ValueChanged<String> onFieldSubmitted;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final bool filled;

  ///
  ///
  ///
  TimeField({
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
    this.filled = false,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  _TimeFieldState createState() => _TimeFieldState();
}

///
///
///
class _TimeFieldState extends State<TimeField> {
  final TimeValidator validator = TimeValidator();

  TimeEditingController _controller;

  ///
  ///
  ///
  TimeEditingController get _effectiveController =>
      widget.controller ?? _controller;

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = TimeEditingController(time: widget.initialValue);
    }
  }

  ///
  ///
  ///
  @override
  void dispose() {
    if (_controller != null) _controller.dispose();
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
        icon: Icon(FontAwesomeIcons.clock),
        onPressed: () async {
          try {
            TimeOfDay selectedTime = await showTimePicker(
              context: context,
              initialTime: _effectiveController.time ?? TimeOfDay.now(),
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

            if (selectedTime != null) {
              _effectiveController.time = selectedTime;
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
        focusNode: widget.focusNode,
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
class TimeEditingController extends TextEditingController {
  ///
  ///
  ///
  TimeEditingController({TimeOfDay time})
      : super(text: TimeValidator().format(time ?? TimeOfDay.now()));

  ///
  ///
  ///
  TimeEditingController.fromValue(TextEditingValue value)
      : super.fromValue(value);

  ///
  ///
  ///
  TimeOfDay get time => TimeValidator().parse(text);

  ///
  ///
  ///
  set time(TimeOfDay time) => text = TimeValidator().format(time);
}
