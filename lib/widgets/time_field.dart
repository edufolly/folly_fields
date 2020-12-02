import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folly_fields/util/time_validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
class TimeField extends FormField<TimeOfDay> {
  final TimeEditingController controller;
  final FocusNode focusNode;

  ///
  ///
  ///
  TimeField({
    Key key,
    String prefix,
    String label,
    this.controller,
    FormFieldValidator<TimeOfDay> validator,
    TextAlign textAlign = TextAlign.start,
    FormFieldSetter<TimeOfDay> onSaved,
    TimeOfDay initialValue,
    bool enabled = true,
    AutovalidateMode autoValidateMode = AutovalidateMode.disabled,
    // TODO - onChanged
    this.focusNode,
    TextInputAction textInputAction,
    ValueChanged<String> onFieldSubmitted,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    bool filled = false,
  }) : super(
          key: key,
          initialValue: controller != null
              ? controller.time
              : (initialValue ?? TimeOfDay.now()),
          onSaved: onSaved,
          validator: enabled ? validator : (_) => null,
          enabled: enabled,
          autovalidateMode: autoValidateMode,
          builder: (FormFieldState<TimeOfDay> field) {
            final _TimeFieldState state = field as _TimeFieldState;

            Color rootColor = Theme.of(state.context).primaryColor;

            final InputDecoration effectiveDecoration = InputDecoration(
              border: OutlineInputBorder(),
              filled: filled,
              labelText: prefix == null || prefix.isEmpty
                  ? label
                  : '${prefix} - ${label}',
              suffixIcon: IconButton(
                icon: Icon(FontAwesomeIcons.clock),
                onPressed: () async {
                  try {
                    TimeOfDay selectedTime = await showTimePicker(
                      context: state.context,
                      initialTime: state.value ?? TimeOfDay.now(),
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
                      state.didChange(selectedTime);
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
                obscureText: false,
                inputFormatters: <TextInputFormatter>[TimeValidator().mask],
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
                // onChanged: (String value) {
                //   field.didChange(value);
                //   if (onChanged != null) {
                //     onChanged(value);
                //   }
                // },
              ),
            );
          },
        );

  ///
  ///
  ///
  @override
  _TimeFieldState createState() => _TimeFieldState();
}

///
///
///
class _TimeFieldState extends FormFieldState<TimeOfDay> {
  TimeEditingController _controller;
  FocusNode _focusNode;

  ///
  ///
  ///
  TimeEditingController get _effectiveController =>
      widget.controller ?? _controller;

  ///
  ///
  ///
  FocusNode get _effectiveFocusNode => widget.focusNode ?? _focusNode;

  ///
  ///
  ///
  @override
  TimeField get widget => super.widget as TimeField;

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = TimeEditingController(time: widget.initialValue);
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
  void didUpdateWidget(TimeField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      oldWidget.focusNode?.removeListener(_handleFocusChanged);

      widget.controller?.addListener(_handleControllerChanged);
      widget.focusNode?.addListener(_handleFocusChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _controller = TimeEditingController.fromValue(
          oldWidget.controller.value,
        );
      }

      if (widget.controller != null) {
        setValue(widget.controller.time);

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
  void didChange(TimeOfDay value) {
    super.didChange(value);

    if (_effectiveController.time != value) {
      _effectiveController.time = value;
    }
  }

  ///
  ///
  ///
  @override
  void reset() {
    super.reset();
    setState(() {
      _effectiveController.time = widget.initialValue;
    });
  }

  ///
  ///
  ///
  void _handleControllerChanged() {
    if (_effectiveController.time != value) {
      didChange(_effectiveController.time);
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
class TimeEditingController extends TextEditingController {
  static final TimeValidator TIME_VALIDATOR = TimeValidator();

  ///
  ///
  ///
  TimeEditingController({TimeOfDay time})
      : super(text: TIME_VALIDATOR.format(time ?? TimeOfDay.now()));

  ///
  ///
  ///
  TimeEditingController.fromValue(TextEditingValue value)
      : super.fromValue(value);

  ///
  ///
  ///
  TimeOfDay get time => TIME_VALIDATOR.parse(text);

  ///
  ///
  ///
  set time(TimeOfDay time) => text = TIME_VALIDATOR.format(time);
}
