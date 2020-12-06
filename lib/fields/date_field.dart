import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folly_fields/validators/date_validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
/// TODO - Usar date_validator.
/// TODO - Implementar a validação padrão.
class DateField extends FormField<DateTime> {
  final DateEditingController controller;
  final FocusNode focusNode;

  ///
  ///
  ///
  DateField({
    Key key,
    String prefix,
    String label,
    this.controller,
    FormFieldValidator<DateTime> validator,
    TextAlign textAlign = TextAlign.start,
    FormFieldSetter<DateTime> onSaved,
    DateTime initialValue,
    bool enabled = true,
    AutovalidateMode autoValidateMode = AutovalidateMode.disabled,
    // TODO - onChanged
    this.focusNode,
    TextInputAction textInputAction,
    ValueChanged<String> onFieldSubmitted,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    DateTime firstDate,
    DateTime lastDate,
    bool filled = false,
  }) : super(
          key: key,
          // TODO - Tirar o DateTime.now()
          initialValue: controller != null
              ? controller.date
              : (initialValue ?? DateTime.now()),
          onSaved: onSaved,
          validator: enabled ? validator : (_) => null,
          enabled: enabled,
          autovalidateMode: autoValidateMode,
          builder: (FormFieldState<DateTime> field) {
            final _DateFieldState state = field as _DateFieldState;

            Color rootColor = Theme.of(state.context).primaryColor;

            final InputDecoration effectiveDecoration = InputDecoration(
              border: OutlineInputBorder(),
              filled: filled,
              labelText: prefix == null || prefix.isEmpty
                  ? label
                  : '${prefix} - ${label}',
              counterText: '',
              suffixIcon: IconButton(
                icon: Icon(FontAwesomeIcons.calendarDay),
                onPressed: () async {
                  try {
                    DateTime selectedDate = await showDatePicker(
                      context: state.context,
                      initialDate: state.value ?? DateTime.now(),
                      firstDate: firstDate ?? DateTime(1900),
                      lastDate: lastDate ?? DateTime(2100),
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
                      state.didChange(selectedDate);
                    }
                  } catch (e, s) {
                    print(e);
                    print(s);
                  }
                },
              ),
            ).applyDefaults(Theme.of(field.context).inputDecorationTheme);

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: state._effectiveController,
                focusNode: state._effectiveFocusNode,
                decoration: effectiveDecoration.copyWith(
                  errorText: enabled ? field.errorText : null,
                ),
                keyboardType: TextInputType.datetime,
                minLines: 1,
                maxLines: 1,
                maxLength: 10,
                obscureText: false,
                inputFormatters: <TextInputFormatter>[DateValidator().mask],
                textAlign: textAlign,
                enabled: enabled,
                textInputAction: textInputAction,
                onSubmitted: onFieldSubmitted,
                autocorrect: false,
                enableSuggestions: false,
                textCapitalization: TextCapitalization.none,
                scrollPadding: scrollPadding,
                enableInteractiveSelection: enableInteractiveSelection,
                style: enabled ? null : TextStyle(color: Colors.black26),
              ),
            );
          },
        );

  ///
  ///
  ///
  @override
  _DateFieldState createState() => _DateFieldState();
}

///
///
///
class _DateFieldState extends FormFieldState<DateTime> {
  DateEditingController _controller;
  FocusNode _focusNode;

  ///
  ///
  ///
  @override
  DateField get widget => super.widget as DateField;

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
    } else {
      widget.controller.addListener(_handleControllerChanged);
    }

    if (widget.focusNode == null) {
      _focusNode = FocusNode();
      _focusNode.addListener(_handleFocusChanged);
    } else {
      widget.focusNode.addListener(_handleFocusChanged);
    }
  }

  ///
  ///
  ///
  @override
  void didUpdateWidget(DateField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      oldWidget.focusNode?.removeListener(_handleFocusChanged);

      widget.controller?.addListener(_handleControllerChanged);
      widget.focusNode?.addListener(_handleFocusChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _controller = DateEditingController.fromValue(
          oldWidget.controller.value,
        );
      }

      if (widget.controller != null) {
        setValue(widget.controller.date);

        if (oldWidget.controller == null) {
          _controller = null;
        }

        if (oldWidget.focusNode == null) {
          _focusNode = null;
        }
      }
    }
  }

  ///
  ///
  ///
  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    widget.focusNode?.removeListener(_handleFocusChanged);
    super.dispose();
  }

  ///
  ///
  ///
  @override
  void didChange(DateTime value) {
    super.didChange(value);

    if (_effectiveController.date != value) {
      _effectiveController.date = value;
    }
  }

  ///
  ///
  ///
  @override
  void reset() {
    super.reset();
    setState(() => _effectiveController.date = widget.initialValue);
  }

  ///
  ///
  ///
  void _handleControllerChanged() {
    if (_effectiveController.date != value) {
      didChange(_effectiveController.date);
    }
  }

  ///
  ///
  ///
  void _handleFocusChanged() {
    _effectiveController.selection = TextSelection(
      baseOffset: 0,
      extentOffset:
          _effectiveFocusNode.hasFocus ? _effectiveController.text.length : 0,
    );
  }
}

///
///
///
class DateEditingController extends TextEditingController {
  static final DateValidator DATE_VALIDATOR = DateValidator();

  ///
  ///
  ///
  DateEditingController({DateTime date})
      : super(text: DATE_VALIDATOR.format(date ?? DateTime.now()));

  ///
  ///
  ///
  DateEditingController.fromValue(TextEditingValue value)
      : super.fromValue(value);

  ///
  ///
  ///
  DateTime get date => DATE_VALIDATOR.parse(text);

  ///
  ///
  ///
  set date(DateTime date) => text = DATE_VALIDATOR.format(date);
}
