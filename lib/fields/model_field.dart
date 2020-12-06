import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
class ModelField<T extends AbstractModel> extends FormField<T> {
  final ModelEditingController<T> controller;

  ///
  ///
  ///
  ModelField({
    Key key,
    String prefix,
    String label,
    this.controller,
    FormFieldValidator<T> validator,
    TextAlign textAlign = TextAlign.start,
    FormFieldSetter<T> onSaved,
    T initialValue,
    bool enabled = true,
    AutovalidateMode autoValidateMode = AutovalidateMode.disabled,
    // TODO - onChanged
    TextInputAction textInputAction,
    ValueChanged<String> onFieldSubmitted,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool filled = false,
    Widget Function(BuildContext) routeBuilder,
    Future<bool> Function(BuildContext, T) beforeRoute,
    Future<bool> Function(T model) acceptChange,
    Function(T model) tapToVisualize,
  }) : super(
          key: key,
          initialValue: controller != null ? controller.model : initialValue,
          onSaved: onSaved,
          validator: enabled ? validator : (_) => null,
          enabled: enabled,
          autovalidateMode: autoValidateMode,
          builder: (FormFieldState<T> field) {
            final _ModelFormFieldState<T> state =
                field as _ModelFormFieldState<T>;

            final InputDecoration effectiveDecoration = InputDecoration(
              border: OutlineInputBorder(),
              filled: filled,
              labelText: prefix == null || prefix.isEmpty
                  ? label
                  : '${prefix} - ${label}',
              suffixIcon: enabled && routeBuilder != null
                  ? FaIcon(FontAwesomeIcons.search)
                  : tapToVisualize != null
                      ? FaIcon(FontAwesomeIcons.chevronRight)
                      : null,
            ).applyDefaults(Theme.of(field.context).inputDecorationTheme);

            return Padding(
              padding: const EdgeInsets.all(8.0),
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
                style: enabled ? null : TextStyle(color: Colors.black26),
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

                          T selected = await Navigator.of(state.context).push(
                            MaterialPageRoute<T>(
                              builder: routeBuilder,
                            ),
                          );

                          bool accept = true;

                          if (acceptChange != null) {
                            accept = await acceptChange(selected);
                          }

                          if (accept) state.didChange(selected);
                        } catch (e, s) {
                          print(e);
                          print(s);
                        }
                      }
                    : tapToVisualize != null && state.value != null
                        ? () => Navigator.of(state.context).push(
                              MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) =>
                                    tapToVisualize(state.value),
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
  _ModelFormFieldState<T> createState() => _ModelFormFieldState<T>();
}

///
///
///
class _ModelFormFieldState<T extends AbstractModel> extends FormFieldState<T> {
  ModelEditingController<T> _controller;

  ///
  ///
  ///
  @override
  ModelField<T> get widget => super.widget as ModelField<T>;

  ///
  ///
  ///
  ModelEditingController<T> get _effectiveController =>
      widget.controller ?? _controller;

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = ModelEditingController<T>(model: widget.initialValue);
    } else {
      widget.controller.addListener(_handleControllerChanged);
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
          model: oldWidget.controller.model,
        );
      }

      if (widget.controller != null) {
        setValue(widget.controller.model);

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
  void didChange(T value) {
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
class ModelEditingController<T extends AbstractModel>
    extends TextEditingController {
  T _model;

  ///
  ///
  ///
  ModelEditingController({T model})
      : _model = model,
        super(text: model.toString());

  ///
  ///
  ///
  T get model => _model;

  ///
  ///
  ///
  set model(T model) {
    value = TextEditingValue(
      text: model.toString(),
    );
    _model = model;
  }

  ///
  ///
  ///
  String get Text => _model.toString();
}
