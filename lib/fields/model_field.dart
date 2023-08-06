import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:folly_fields/controllers/model_editing_controller.dart';
import 'package:folly_fields/crud/abstract_model.dart';
import 'package:folly_fields/responsive/responsive_form_field.dart';
import 'package:folly_fields/widgets/folly_dialogs.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
class ModelField<T extends AbstractModel<ID>, ID>
    extends ResponsiveFormField<T?> {
  final ModelEditingController<T, ID>? controller;

  ///
  ///
  ///
  ModelField({
    String? labelPrefix,
    String? label,
    Widget? labelWidget,
    this.controller,
    FormFieldValidator<T>? validator,
    TextAlign textAlign = TextAlign.start,
    super.onSaved,
    T? initialValue,
    super.enabled,
    AutovalidateMode autoValidateMode = AutovalidateMode.disabled,
    // TODO(edufolly): onChanged
    TextInputAction? textInputAction,
    ValueChanged<String?>? onFieldSubmitted,
    EdgeInsets scrollPadding = const EdgeInsets.all(20),
    bool filled = false,
    Color? fillColor,
    Widget Function(BuildContext context)? routeBuilder,
    Future<bool> Function(BuildContext context, T? model)? beforeRoute,
    Future<T?> Function(T? model)? acceptChange,
    Function(T model)? tapToVisualize,
    InputDecoration? decoration,
    EdgeInsets padding = const EdgeInsets.all(8),
    bool clearOnCancel = true,
    String? hintText,
    EdgeInsets? contentPadding,
    Widget? prefix,
    Widget? prefixIcon,
    Widget? suffix,
    Widget? suffixIcon,
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
        ),
        super(
          initialValue: controller != null ? controller.model : initialValue,
          validator: enabled ? validator : (_) => null,
          autovalidateMode: autoValidateMode,
          builder: (FormFieldState<T?> field) {
            final _ModelFieldState<T, ID> state =
                field as _ModelFieldState<T, ID>;

            final InputDecoration effectiveDecoration = (decoration ??
                    InputDecoration(
                      border: const OutlineInputBorder(),
                      filled: filled,
                      fillColor: fillColor,
                      label: labelWidget,
                      labelText: (labelPrefix?.isEmpty ?? true)
                          ? label
                          : '$labelPrefix - $label',
                      counterText: '',
                      hintText: hintText,
                      contentPadding: contentPadding,
                      prefix: prefix,
                      prefixIcon: prefixIcon,
                      suffix: suffix,
                      suffixIcon: suffixIcon,
                    ))
                .applyDefaults(Theme.of(field.context).inputDecorationTheme)
                .copyWith(
                  suffixIcon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      if (enabled && routeBuilder != null)
                        const FaIcon(FontAwesomeIcons.magnifyingGlass)
                      else
                        tapToVisualize != null
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
                textAlign: textAlign,
                enabled: enabled,
                textInputAction: textInputAction,
                onSubmitted: onFieldSubmitted,
                autocorrect: false,
                enableSuggestions: false,
                scrollPadding: scrollPadding,
                style: enabled
                    ? null
                    : Theme.of(field.context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(field.context).disabledColor,
                        ),
                readOnly: true,
                onTap: enabled && routeBuilder != null
                    ? () async {
                        try {
                          if (beforeRoute != null) {
                            final bool go = await beforeRoute(
                              state.context,
                              state.value,
                            );
                            if (!go) {
                              return;
                            }
                          }

                          T? selected = await Navigator.of(state.context).push(
                            MaterialPageRoute<T>(
                              builder: routeBuilder,
                            ),
                          );

                          try {
                            if (acceptChange != null) {
                              selected = await acceptChange(selected);
                            }
                            if (selected != null ||
                                (selected == null && clearOnCancel)) {
                              state._effectiveController.model = selected;
                              state.didChange(selected);
                            }
                          } on Exception catch (e, s) {
                            if (kDebugMode) {
                              print(e);
                              print(s);
                            }
                            await FollyDialogs.dialogMessage(
                              context: state.context,
                              message: e.toString(),
                            );
                          }
                        } on Exception catch (e, s) {
                          if (kDebugMode) {
                            print(e);
                            print(s);
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
  FormFieldState<T?> createState() => _ModelFieldState<T, ID>();
}

///
///
///
class _ModelFieldState<T extends AbstractModel<ID>, ID>
    extends FormFieldState<T?> {
  ModelEditingController<T, ID>? _controller;

  ///
  ///
  ///
  ModelField<T, ID> get _modelField => super.widget as ModelField<T, ID>;

  ///
  ///
  ///
  ModelEditingController<T, ID> get _effectiveController =>
      _modelField.controller ?? _controller!;

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();
    if (_modelField.controller == null) {
      _controller = ModelEditingController<T, ID>(
        model: _modelField.initialValue,
      );
    } else {
      _modelField.controller!.addListener(_handleControllerChanged);
    }
  }

  ///
  ///
  ///
  @override
  void didUpdateWidget(ModelField<T, ID> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_modelField.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      _modelField.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && _modelField.controller == null) {
        _controller = ModelEditingController<T, ID>(
          model: oldWidget.controller!.model,
        );
      }

      if (_modelField.controller != null) {
        setValue(_modelField.controller!.model);

        if (oldWidget.controller == null) {
          _controller!.dispose();
          _controller = null;
        }
      }
    }
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
    _effectiveController.model = _modelField.initialValue;
    super.reset();
  }

  ///
  ///
  ///
  void _handleControllerChanged() {
    if (_effectiveController.model != value) {
      didChange(_effectiveController.model);
    }
  }

  ///
  ///
  ///
  @override
  void dispose() {
    _modelField.controller?.removeListener(_handleControllerChanged);
    _controller?.dispose();
    super.dispose();
  }
}
