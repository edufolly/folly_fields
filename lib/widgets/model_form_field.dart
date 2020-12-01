import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


///
///
///
class ModelFormField<T extends AbstractModel> extends FormField<T> {
  ///
  ///
  ///
  ModelFormField({
    Key key,
    @required T model,
    @required Widget Function(BuildContext) routeBuilder,
    String prefix,
    String label,
    Future<bool> Function(BuildContext, T) beforeRoute,
    FormFieldSetter<T> onSaved,
    FormFieldValidator<T> validator,
    Future<bool> Function(T model) acceptChange,
    bool enabled = true,
    Function(T model) tapToVisualize,
    bool remap = false, // TODO - Realmente é necessário?
    AutovalidateMode autoValidateMode = AutovalidateMode.disabled,
  }) : super(
          key: key,
          initialValue: model,
          onSaved: onSaved,
          validator: validator,
          enabled: enabled,
          autovalidateMode: autoValidateMode,
          builder: (FormFieldState<T> field) {
            InputDecoration inputDecoration;

            if (prefix != null && prefix.isNotEmpty && label != null) {
              label = '$prefix - $label';
            }

            if (remap && !field.hasError) {
              (field as ModelFormFieldState<T>).internalSetValue(model);
            }

            if (label == null) {
              inputDecoration = InputDecoration(
                border: OutlineInputBorder(),
                counterText: '',
                errorText: field.errorText,
              );
            } else {
              inputDecoration = InputDecoration(
                labelText: field.value == null ? null : label,
                hintText: label,
                border: OutlineInputBorder(),
                counterText: '',
                errorText: field.errorText,
              );
            }

            final InputDecoration effectiveDecoration = inputDecoration
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            final TextStyle disabledStyle = Theme.of(field.context)
                .textTheme
                .subtitle1
                .copyWith(color: Colors.black54);

            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 10.0,
              ),
              child: GestureDetector(
                child: InputDecorator(
                  decoration: effectiveDecoration,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: field.value == null
                            ? Text(
                                label ?? '',
                                style: disabledStyle,
                                overflow: TextOverflow.ellipsis,
                              )
                            : Text(
                                field.value.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: enabled
                                    ? Theme.of(field.context)
                                        .textTheme
                                        .subtitle1
                                    : disabledStyle,
                              ),
                      ),
                      enabled
                          ? Flexible(
                              flex: 0,
                              child: FaIcon(
                                FontAwesomeIcons.search,
                                color: Colors.black45,
                              ),
                            )
                          : tapToVisualize != null
                              ? Flexible(
                                  flex: 0,
                                  child: FaIcon(
                                    FontAwesomeIcons.chevronRight,
                                    color: Colors.black45,
                                  ),
                                )
                              : Container(),
                    ],
                  ),
                ),
                onTap: enabled
                    ? () async {
                        if (beforeRoute != null) {
                          bool go = await beforeRoute(
                            field.context,
                            field.value,
                          );
                          if (!go) return;
                        }

                        T selected = await Navigator.of(field.context).push(
                          MaterialPageRoute<T>(
                            builder: routeBuilder,
                          ),
                        );

                        bool accept = true;

                        if (acceptChange != null) {
                          accept = await acceptChange(selected);
                        }

                        if (accept) field.didChange(selected);
                      }
                    : tapToVisualize != null && field.value != null
                        ? () => Navigator.of(field.context).push(
                              MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) =>
                                    tapToVisualize(field.value),
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
  FormFieldState<T> createState() => ModelFormFieldState<T>();
}

///
///
///
class ModelFormFieldState<T extends AbstractModel> extends FormFieldState<T> {
  ///
  ///
  ///
  void internalSetValue(T value) {
    super.setValue(value);
  }
}
