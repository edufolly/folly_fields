import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_model.dart';
import 'package:folly_fields/folly_fields.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
class ModelField<T extends AbstractModel<Object>> extends FormField<T?> {
  final ModelEditingController<T>? controller;

  ///
  ///
  ///
  ModelField({
    Key? key,
    String prefix = '',
    String label = '',
    this.controller,
    FormFieldValidator<T>? validator,
    TextAlign textAlign = TextAlign.start,
    FormFieldSetter<T>? onSaved,
    T? initialValue,
    bool enabled = true,
    AutovalidateMode autoValidateMode = AutovalidateMode.disabled,
    // TODO - onChanged
    TextInputAction? textInputAction,
    ValueChanged<String>? onFieldSubmitted,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool filled = false,
    Color? fillColor,
    Widget Function(BuildContext context)? routeBuilder,
    Future<bool> Function(BuildContext context, T? model)? beforeRoute,
    Future<bool> Function(T? model)? acceptChange,
    Function(T model)? tapToVisualize,
    InputDecoration? decoration,
    EdgeInsets padding = const EdgeInsets.all(8.0),
  })  : assert(initialValue == null || controller == null),
        super(
          key: key,
          initialValue: controller != null ? controller.model : initialValue,
          onSaved: onSaved,
          validator: enabled ? validator : (_) => null,
          enabled: enabled,
          autovalidateMode: autoValidateMode,
          builder: (FormFieldState<T?> field) {
            final _ModelFieldState<T> state = field as _ModelFieldState<T>;

            final InputDecoration effectiveDecoration = (decoration ??
                    InputDecoration(
                      border: const OutlineInputBorder(),
                      filled: filled,
                      fillColor: fillColor,
                      labelText: prefix.isEmpty ? label : '$prefix - $label',
                      counterText: '',
                    ))
                .applyDefaults(Theme.of(field.context).inputDecorationTheme)
                .copyWith(
                  suffixIcon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      enabled && routeBuilder != null
                          ? const FaIcon(FontAwesomeIcons.search)
                          : tapToVisualize != null
                              ? const FaIcon(FontAwesomeIcons.chevronRight)
                              : Container(width: 0),
                    ],
                  ),
                );

            return Padding(
              padding: padding,
              child: TextField(
                controller: state._effectiveController,
                decoration: effectiveDecoration.copyWith(
                  errorText: enabled ? field.errorText : null,
                ),
                keyboardType: TextInputType.datetime,
                minLines: 1,
                maxLines: 1,
                obscureText: false,
                textAlign: textAlign,
                enabled: enabled,
                textInputAction: textInputAction,
                onSubmitted: onFieldSubmitted,
                autocorrect: false,
                enableSuggestions: false,
                textCapitalization: TextCapitalization.none,
                scrollPadding: scrollPadding,
                enableInteractiveSelection: true,
                style: enabled
                    ? null
                    : Theme.of(field.context).textTheme.subtitle1!.copyWith(
                          color: Theme.of(field.context).disabledColor,
                        ),
                readOnly: true,
                onTap: enabled && routeBuilder != null
                    ? () async {
                        try {
                          if (beforeRoute != null) {
                            bool go = await beforeRoute(
                              state.context,
                              state.value,
                            );
                            if (!go) return;
                          }

                          T? selected = await Navigator.of(state.context).push(
                            MaterialPageRoute<T>(
                              builder: routeBuilder,
                            ),
                          );

                          bool accept = true;

                          if (acceptChange != null) {
                            accept = await acceptChange(selected);
                          }

                          if (accept) {
                            state._effectiveController.model = selected;
                            state.didChange(selected);
                          }
                        } catch (e, s) {
                          if (FollyFields().isDebug) {
                            // ignore: avoid_print
                            print('$e\n$s');
                          }
                        }
                      }
                    : tapToVisualize != null && state.value != null
                        ? () => Navigator.of(state.context).push(
                              MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) =>
                                    tapToVisualize(state.value!),
                              ),
                            )
                        : null,
              ),
            );
          },
        );

  ///
  ///
  ///
  @override
  _ModelFieldState<T> createState() => _ModelFieldState<T>();
}

///
///
///
class _ModelFieldState<T extends AbstractModel<Object>>
    extends FormFieldState<T?> {
  ModelEditingController<T>? _controller;

  ///
  ///
  ///
  @override
  ModelField<T> get widget => super.widget as ModelField<T>;

  ///
  ///
  ///
  ModelEditingController<T> get _effectiveController =>
      widget.controller ?? _controller!;

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = ModelEditingController<T>(model: widget.initialValue);
    } else {
      widget.controller!.addListener(_handleControllerChanged);
    }
  }

  ///
  ///
  ///
  @override
  void didUpdateWidget(ModelField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);

      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _controller = ModelEditingController<T>(
          model: oldWidget.controller!.model,
        );
      }

      if (widget.controller != null) {
        setValue(widget.controller!.model);

        if (oldWidget.controller == null) {
          _controller = null;
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
    super.dispose();
  }

  ///
  ///
  ///
  @override
  void didChange(T? value) {
    super.didChange(value);
    if (_effectiveController.model != value) {
      _effectiveController.model = value;
    }
  }

  ///
  ///
  ///
  @override
  void reset() {
    super.reset();
    setState(() => _effectiveController.model = widget.initialValue);
  }

  ///
  ///
  ///
  void _handleControllerChanged() {
    if (_effectiveController.model != value) {
      didChange(_effectiveController.model);
    }
  }
}

///
///
///
class ModelEditingController<T extends AbstractModel<Object>>
    extends TextEditingController {
  T? _model;

  ///
  ///
  ///
  ModelEditingController({T? model})
      : _model = model,
        super(text: (model ?? '').toString());

  ///
  ///
  ///
  T? get model => _model;

  ///
  ///
  ///
  set model(T? model) {
    value = TextEditingValue(
      text: (model ?? '').toString(),
    );
    _model = model;
    notifyListeners();
  }

  ///
  ///
  ///
  @override
  String get text => (_model ?? '').toString();
}
