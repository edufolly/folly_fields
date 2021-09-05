import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_model.dart';
import 'package:folly_fields/crud/abstract_ui_builder.dart';
import 'package:folly_fields/folly_fields.dart';
import 'package:folly_fields/widgets/add_button.dart';
import 'package:folly_fields/widgets/field_group.dart';
import 'package:folly_fields/widgets/folly_dialogs.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sprintf/sprintf.dart';

///
/// TODO - Create controller??
///
class ListField<T extends AbstractModel<Object>,
    UI extends AbstractUIBuilder<T>> extends FormField<List<T>> {
  ///
  ///
  ///
  ListField({
    Key? key,
    required List<T> initialValue,
    required UI uiBuilder,
    required Widget Function(BuildContext context, UI uiBuilder)
        routeAddBuilder,
    Function(BuildContext context, T model, UI uiBuilder, bool edit)?
        routeEditBuilder,
    void Function(List<T> value)? onSaved,
    String? Function(List<T> value)? validator,
    bool enabled = true,
    AutovalidateMode autoValidateMode = AutovalidateMode.disabled,
    Future<bool> Function(BuildContext context)? beforeAdd,
    Future<bool> Function(BuildContext context, int index, T model)? beforeEdit,
    String addText = 'Adicionar %s',
    String removeText = 'Deseja remover %s?',
    String emptyListText = 'Sem %s até o momento.',
    InputDecoration? decoration,
    EdgeInsets padding = const EdgeInsets.all(8.0),
  }) : super(
          key: key,
          initialValue: initialValue,
          enabled: enabled,
          onSaved: enabled && onSaved != null
              ? (List<T>? value) => onSaved(value!)
              : null,
          validator: enabled && validator != null
              ? (List<T>? value) => validator(value!)
              : null,
          autovalidateMode: autoValidateMode,
          builder: (FormFieldState<List<T>> field) {
            InputDecoration effectiveDecoration = (decoration ??
                    InputDecoration(
                      labelText: uiBuilder.getSuperPlural(),
                      border: const OutlineInputBorder(),
                      counterText: '',
                      enabled: enabled,
                      errorText: field.errorText,
                    ))
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            return FieldGroup(
              padding: padding,
              decoration: effectiveDecoration,
              children: <Widget>[
                if (field.value!.isEmpty)

                  /// Lista vazia.
                  SizedBox(
                    height: 75.0,
                    child: Center(
                      child: Text(
                        sprintf(
                          emptyListText,
                          <dynamic>[uiBuilder.getSuperPlural()],
                        ).toString(),
                      ),
                    ),
                  )
                else

                  /// Lista
                  ...field.value!
                      .asMap()
                      .entries
                      .map(
                        (MapEntry<int, T> entry) => _MyListTile<T, UI>(
                          index: entry.key,
                          model: entry.value,
                          uiBuilder: uiBuilder,
                          onEdit: (int index, T model) async {
                            if (beforeEdit != null) {
                              bool go =
                                  await beforeEdit(field.context, index, model);
                              if (!go) return;
                            }

                            if (routeEditBuilder != null) {
                              T? returned =
                                  await Navigator.of(field.context).push(
                                MaterialPageRoute<T>(
                                  builder: (BuildContext context) =>
                                      routeEditBuilder(
                                    context,
                                    model,
                                    uiBuilder,
                                    enabled,
                                  ),
                                ),
                              );

                              if (returned != null) {
                                field.value![index] = returned;
                                field.didChange(field.value);
                              }
                            }
                          },
                          onDelete: (T model) {
                            field.value!.remove(model);
                            field.didChange(field.value);
                          },
                          removeText: removeText,
                          enabled: enabled,
                        ),
                      )
                      .toList(),

                /// Botão Adicionar
                AddButton(
                  enabled: enabled,
                  label: sprintf(
                    addText,
                    <dynamic>[uiBuilder.getSuperSingle()],
                  ).toUpperCase(),
                  onPressed: () async {
                    if (beforeAdd != null) {
                      bool go = await beforeAdd(field.context);
                      if (!go) return;
                    }

                    final dynamic selected =
                        await Navigator.of(field.context).push(
                      MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) =>
                            routeAddBuilder(context, uiBuilder),
                      ),
                    );

                    if (selected != null) {
                      if (selected is List) {
                        for (T item in selected) {
                          if (item.id == null ||
                              !field.value!
                                  .any((T element) => element.id == item.id)) {
                            field.value!.add(item);
                          }
                        }
                      } else {
                        if ((selected as AbstractModel<Object>).id == null ||
                            !field.value!.any((T element) {
                              return element.id == selected.id;
                            })) {
                          field.value!.add((selected as T));
                        }
                      }

                      field.value!.sort(
                          (T a, T b) => a.toString().compareTo(b.toString()));

                      field.didChange(field.value);
                    }
                  },
                ),
              ],
            );
          },
        );
}

///
///
///
class _MyListTile<T extends AbstractModel<Object>,
    UI extends AbstractUIBuilder<T>> extends StatelessWidget {
  final int index;
  final T model;
  final UI uiBuilder;
  final void Function(int, T) onEdit;
  final void Function(T) onDelete;
  final String removeText;
  final bool enabled;

  ///
  ///
  ///
  const _MyListTile({
    Key? key,
    required this.index,
    required this.model,
    required this.uiBuilder,
    required this.onEdit,
    required this.onDelete,
    required this.removeText,
    required this.enabled,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return FollyFields().isWeb || enabled
        ? _internalTile(context, index, model)
        : Dismissible(
            // TODO - Test the key in tests.
            key: Key('key_${index}_${model.id}'),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 8.0),
              child: const FaIcon(
                FontAwesomeIcons.trashAlt,
                color: Colors.white,
              ),
            ),
            confirmDismiss: (DismissDirection direction) => _askDelete(context),
            onDismissed: (DismissDirection direction) =>
                _delete(context, model),
            child: _internalTile(context, index, model),
          );
  }

  ///
  ///
  ///
  Widget _internalTile(BuildContext context, int index, T model) {
    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          uiBuilder.getLeading(model),
        ],
      ),
      title: uiBuilder.getTitle(model),
      subtitle: uiBuilder.getSubtitle(model),
      trailing: Visibility(
        visible: FollyFields().isWeb,
        child: IconButton(
          icon: const Icon(FontAwesomeIcons.trashAlt),
          onPressed: enabled ? () => _delete(context, model, ask: true) : null,
        ),
      ),
      onTap: () => onEdit(index, model),
    );
  }

  ///
  ///
  ///
  void _delete(BuildContext context, T model, {bool ask = false}) async {
    bool del = true;
    if (ask) del = (await _askDelete(context)) ?? false;
    if (del) onDelete(model);
  }

  ///
  ///
  ///
  Future<bool?> _askDelete(BuildContext context) => FollyDialogs.yesNoDialog(
        context: context,
        message: sprintf(removeText, <dynamic>[uiBuilder.getSuperSingle()]),
      );
}
