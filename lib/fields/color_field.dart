import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:folly_fields/responsive/responsive.dart';
import 'package:folly_fields/validators/color_validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
class ColorField extends StatefulResponsive {
  final String labelPrefix;
  final String? label;
  final Widget? labelWidget;
  final ColorEditingController? controller;
  final FormFieldValidator<Color?>? validator;
  final TextAlign textAlign;
  final FormFieldSetter<Color?>? onSaved;
  final Color? initialValue;
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
  final void Function(Color?)? lostFocus;
  final bool required;
  final InputDecoration? decoration;
  final EdgeInsets padding;
  final IconData colorIcon;
  final bool clearOnCancel;

  ///
  ///
  ///
  const ColorField({
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
    this.colorIcon = FontAwesomeIcons.solidCircle,
    this.clearOnCancel = true,
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
  ColorFieldState createState() => ColorFieldState();
}

///
///
///
class ColorFieldState extends State<ColorField> {
  final ColorValidator _validator = ColorValidator();
  ColorEditingController? _controller;
  FocusNode? _focusNode;
  bool fromButton = false;
  ValueNotifier<Color?> notifier = ValueNotifier<Color?>(null);
  Color pickerColor = Colors.red;

  ///
  ///
  ///
  ColorEditingController get _effectiveController =>
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
      _controller = ColorEditingController(widget.initialValue);
    }

    if (widget.focusNode == null) {
      _focusNode = FocusNode();
    }

    notifier.value = _effectiveController.color;
    pickerColor = _effectiveController.color ?? pickerColor;

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
      widget.lostFocus!(_effectiveController.color);
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
            ))
        .applyDefaults(Theme.of(context).inputDecorationTheme)
        .copyWith(
          prefixIcon: ValueListenableBuilder<Color?>(
            valueListenable: notifier,
            builder: (BuildContext context, Color? value, _) {
              value ??= Colors.transparent;

              if (!widget.enabled) {
                value = value.withOpacity(0.12);
              }

              return Icon(
                widget.colorIcon,
                color: value,
              );
            },
          ),
          suffixIcon: IconButton(
            icon: const Icon(FontAwesomeIcons.palette),
            onPressed: widget.enabled && !widget.readOnly
                ? () async {
                    try {
                      fromButton = true;

                      Color? selectedColor = await showColorPicker(
                        context: context,
                        initialColor: _effectiveController.color,
                      );

                      fromButton = false;

                      if (selectedColor != null ||
                          selectedColor == null && widget.clearOnCancel) {
                        _effectiveController.color = selectedColor;
                        notifier.value = _effectiveController.color;
                      }

                      if (_effectiveFocusNode.canRequestFocus) {
                        _effectiveFocusNode.requestFocus();
                      }
                    } on Exception catch (e, s) {
                      if (kDebugMode) {
                        print(e);
                        print(s);
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

                String? message = _validator.valid(value);

                if (message != null) {
                  return message;
                }

                if (widget.validator != null) {
                  return widget.validator!(_validator.parse(value));
                }

                return null;
              }
            : (_) => null,
        keyboardType: _validator.keyboard,
        minLines: 1,
        inputFormatters: _validator.inputFormatters,
        textAlign: widget.textAlign,
        maxLength: 8,
        onSaved: (String? value) => widget.enabled && widget.onSaved != null
            ? widget.onSaved!(_validator.parse(value))
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
        onChanged: (String value) {
          Color? typedColor = _validator.parse(value);
          if (typedColor != null) {
            notifier.value = typedColor;
          }
        },
      ),
    );
  }

  ///
  ///
  ///
  Future<Color?> showColorPicker({
    required BuildContext context,
    Color? initialColor,
  }) {
    return showDialog<Color?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: ColorPicker(
            pickerColor: initialColor ?? pickerColor,
            onColorChanged: (Color value) =>
                setState(() => pickerColor = value),
            portraitOnly: true,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () => Navigator.of(context).pop(pickerColor),
            ),
          ],
        );
      },
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
class ColorEditingController extends TextEditingController {
  ///
  ///
  ///
  ColorEditingController(Color? color)
      : super(text: color == null ? '' : ColorValidator().format(color));

  ///
  ///
  ///
  ColorEditingController.fromValue(TextEditingValue super.value)
      : super.fromValue();

  ///
  ///
  ///
  Color? get color => ColorValidator().parse(text);

  ///
  ///
  ///
  set color(Color? color) =>
      text = color == null ? '' : ColorValidator().format(color);
}
