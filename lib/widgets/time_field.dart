import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folly_fields/util/field_helper.dart';
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
    @required String label,
    TimeOfDay initialValue,
    this.controller,
    this.focusNode,
    FormFieldSetter<TimeOfDay> onSaved,
    FormFieldValidator<TimeOfDay> validator,
    bool enabled = true,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    AutovalidateMode autovalidateMode,
  }) : super(
          key: key,
          initialValue: controller != null
              ? controller.time
              : (initialValue ?? TimeOfDay.now()),
          onSaved: onSaved,
          validator: enabled ? validator : (_) => null,
          enabled: enabled,
          autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
          builder: (FormFieldState<TimeOfDay> field) {
            final _NewTimeFieldState state = field as _NewTimeFieldState;

            Color rootColor = Theme.of(state.context).primaryColor;

            final InputDecoration effectiveDecoration = InputDecoration(
              border: OutlineInputBorder(),
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

            ///
            // void onChangedHandler(String value) {
            //   field.didChange(value);
            //   if (onChanged != null) {
            //     onChanged(value);
            //   }
            // }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: state._effectiveController,
                focusNode: state._effectiveFocusNode,
                decoration: effectiveDecoration.copyWith(
                  errorText: enabled ? field.errorText : null,
                ),
                keyboardType: TextInputType.datetime,
                // textInputAction: textInputAction,
                style: enabled ? null : TextStyle(color: Colors.black26),
                // strutStyle: strutStyle,
                textAlign: TextAlign.start,
                // textAlignVertical: textAlignVertical,
                // textDirection: textDirection,
                textCapitalization: TextCapitalization.none,
                autofocus: false,
                // toolbarOptions: toolbarOptions,
                readOnly: false,
                showCursor: true,
                // obscuringCharacter: obscuringCharacter,
                obscureText: false,
                autocorrect: false,
                smartDashesType: SmartDashesType.disabled,
                smartQuotesType: SmartQuotesType.disabled,
                enableSuggestions: false,
                // maxLengthEnforced: maxLengthEnforced,
                maxLines: 1,
                minLines: 1,
                expands: false,
                // maxLength: maxLength,
                // onChanged: onChangedHandler,
                // onTap: onTap,
                // onEditingComplete: onEditingComplete,
                // onSubmitted: onFieldSubmitted,
                inputFormatters: <TextInputFormatter>[
                  FieldHelper.masks[FieldType.time],
                ],
                enabled: enabled,
                // cursorWidth: cursorWidth,
                // cursorHeight: cursorHeight,
                // cursorRadius: cursorRadius,
                // cursorColor: cursorColor,
                scrollPadding: scrollPadding,
                // scrollPhysics: scrollPhysics,
                // keyboardAppearance: keyboardAppearance,
                enableInteractiveSelection: enableInteractiveSelection,
                // buildCounter: buildCounter,
                // autofillHints: autofillHints,
              ),
            );
          },
        );

  ///
  ///
  ///
  @override
  _NewTimeFieldState createState() => _NewTimeFieldState();
}

///
///
///
class _NewTimeFieldState extends FormFieldState<TimeOfDay> {
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
  ///
  ///
  ///
  TimeEditingController({TimeOfDay time})
      : super(text: TimeValidator.format(time ?? TimeOfDay.now()));

  ///
  ///
  ///
  TimeEditingController.fromValue(TextEditingValue value)
      : super.fromValue(value);

  ///
  ///
  ///
  TimeOfDay get time => TimeValidator.parse(text);

  ///
  ///
  ///
  set time(TimeOfDay time) => text = TimeValidator.format(time);
}
