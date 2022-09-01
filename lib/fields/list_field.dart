import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_model.dart';
import 'package:folly_fields/crud/abstract_ui_builder.dart';
import 'package:folly_fields/folly_fields.dart';
import 'package:folly_fields/responsive/responsive.dart';
import 'package:folly_fields/widgets/field_group.dart';
import 'package:folly_fields/widgets/folly_dialogs.dart';
import 'package:folly_fields/widgets/table_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sprintf/sprintf.dart';

///
///
///
// TODO(edufolly): Create controller?
class ListField<T extends AbstractModel<Object>,
    UI extends AbstractUIBuilder<T>> extends FormFieldResponsive<List<T>> {
  ///
  ///
  ///
  ListField({
    required List<T> super.initialValue,
    required UI uiBuilder,
    required Widget Function(BuildContext context, UI uiBuilder)
        routeAddBuilder,
    Function(BuildContext context, T model, UI uiBuilder, bool edit)?
        routeEditBuilder,
    void Function(List<T> value)? onSaved,
    String? Function(List<T> value)? validator,
    void Function(List<T> value)? onChanged,
    super.enabled,
    AutovalidateMode autoValidateMode = AutovalidateMode.disabled,
    Future<bool> Function(BuildContext context)? beforeAdd,
    Future<bool> Function(BuildContext context, int index, T model)? beforeEdit,
    String addText = 'Adicionar %s',
    String removeText = 'Deseja remover %s?',
    String clearText = 'Deseja remover todos itens da lista?',
    String emptyListText = 'Sem %s até o momento.',
    InputDecoration? decoration,
    EdgeInsets padding = const EdgeInsets.all(8),
    int Function(T a, T b)? listSort,
    bool expandable = false,
    bool initialExpanded = true,
    bool clearAllButton = false,
    Widget Function(BuildContext context, List<T> value)? onCollapsed,
    bool showCounter = false,
    bool showTopAddButton = false,
    bool showDeleteButton = true,
    bool showAddButton = true,
    super.sizeExtraSmall,
    super.sizeSmall,
    super.sizeMedium,
    super.sizeLarge,
    super.sizeExtraLarge,
    super.minHeight,
    super.key,
  }) : super(
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
                      labelText: uiBuilder.superPlural(field.context),
                      border: const OutlineInputBorder(),
                      counterText: '',
                      enabled: enabled,
                      errorText: field.errorText,
                    ))
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            String emptyText = sprintf(
              emptyListText,
              <dynamic>[uiBuilder.superPlural(field.context)],
            );

            Future<void> add() async {
              if (beforeAdd != null) {
                bool go = await beforeAdd(field.context);
                if (!go) {
                  return;
                }
              }

              dynamic selected = await Navigator.of(field.context).push(
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) =>
                      routeAddBuilder(context, uiBuilder),
                ),
              );

              if (selected != null) {
                bool changed = false;

                if (selected is List) {
                  for (T item in selected) {
                    if (item.id == null ||
                        !field.value!
                            .any((T element) => element.id == item.id)) {
                      field.value!.add(item);
                      changed = true;
                    }
                  }
                } else {
                  if ((selected as AbstractModel<Object>).id == null ||
                      !field.value!
                          .any((T element) => element.id == selected.id)) {
                    field.value!.add(selected as T);
                    changed = true;
                  }
                }

                if (changed) {
                  field.value!.sort(
                    listSort ??
                        (T a, T b) => a.toString().compareTo(b.toString()),
                  );

                  onChanged?.call(field.value!);

                  field.didChange(field.value);
                }
              }
            }

            return FieldGroup(
              decoration: effectiveDecoration,
              padding: padding,
              children: <Widget>[
                ExpandableNotifier(
                  initialExpanded: expandable ? initialExpanded : !expandable,
                  child: Column(
                    children: <Widget>[
                      /// Top Bar
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                /// Counter
                                if (showCounter)
                                  Chip(
                                    label: Text(field.value!.length.toString()),
                                  ),

                                /// Top Add Button
                                if (showTopAddButton)
                                  IconButton(
                                    onPressed: add,
                                    icon: const Icon(FontAwesomeIcons.plus),
                                  ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                /// Expand Button
                                if (expandable)
                                  ExpandableButton(
                                    child: ExpandableIcon(
                                      theme: ExpandableThemeData(
                                        iconColor: Theme.of(field.context)
                                            .iconTheme
                                            .color,
                                        collapseIcon: FontAwesomeIcons.compress,
                                        expandIcon: FontAwesomeIcons.expand,
                                        iconSize: 24,
                                        iconPadding: const EdgeInsets.all(4),
                                      ),
                                    ),
                                  ),

                                /// Clear All Button
                                if (clearAllButton)
                                  IconButton(
                                    onPressed: field.value!.isEmpty
                                        ? null
                                        : () {
                                            FollyDialogs.yesNoDialog(
                                              context: field.context,
                                              message: sprintf(
                                                clearText,
                                                <dynamic>[
                                                  uiBuilder.superSingle(
                                                    field.context,
                                                  )
                                                ],
                                              ),
                                            ).then(
                                              (bool del) {
                                                if (del) {
                                                  field.value!.clear();
                                                  onChanged?.call(field.value!);
                                                  field.didChange(field.value);
                                                }
                                              },
                                            );
                                          },
                                    icon: const Icon(FontAwesomeIcons.trashCan),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expandable(
                        collapsed: field.value!.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 24),
                                child: Text(emptyText),
                              )
                            : onCollapsed == null
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                      horizontal: 32,
                                    ),
                                    child: Text(
                                      field.value!.join(' - '),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                : onCollapsed(field.context, field.value!),
                        expanded: Column(
                          children: <Widget>[
                            if (field.value!.isEmpty)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Text(emptyText),
                              )
                            else
                              ...field.value!.asMap().entries.map(
                                (MapEntry<int, T> entry) {
                                  return _MyListTile<T, UI>(
                                    field: field,
                                    index: entry.key,
                                    model: entry.value,
                                    uiBuilder: uiBuilder,
                                    removeText: removeText,
                                    enabled: enabled,
                                    beforeEdit: beforeEdit,
                                    routeEditBuilder: routeEditBuilder,
                                    listSort: listSort,
                                    onChanged: onChanged,
                                    showDeleteButton: showDeleteButton,
                                  );
                                },
                              ).toList(),

                            /// Add Button
                            if (showAddButton)
                              TableButton(
                                enabled: enabled,
                                iconData: FontAwesomeIcons.plus,
                                label: sprintf(
                                  addText,
                                  <dynamic>[
                                    uiBuilder.superSingle(field.context)
                                  ],
                                ).toUpperCase(),
                                onPressed: add,
                              ),
                          ],
                        ),
                      )
                    ],
                  ),
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
  final FormFieldState<List<T>> field;
  final int index;
  final T model;
  final UI uiBuilder;
  final String removeText;
  final bool enabled;
  final Future<bool> Function(BuildContext context, int index, T model)?
      beforeEdit;
  final Function(BuildContext context, T model, UI uiBuilder, bool edit)?
      routeEditBuilder;
  final int Function(T a, T b)? listSort;
  final void Function(List<T> value)? onChanged;
  final bool showDeleteButton;

  ///
  ///
  ///
  const _MyListTile({
    required this.field,
    required this.index,
    required this.model,
    required this.uiBuilder,
    required this.removeText,
    required this.enabled,
    required this.beforeEdit,
    required this.routeEditBuilder,
    required this.listSort,
    required this.onChanged,
    required this.showDeleteButton,
    super.key,
  });

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) => FollyFields().isNotMobile ||
          !enabled ||
          !showDeleteButton
      ? _internalTile(context, index, model)
      : Dismissible(
          // TODO(edufolly): Test the key in tests.
          key: Key('key_${index}_${model.id}'),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 8),
            child: const FaIcon(
              FontAwesomeIcons.trashCan,
              color: Colors.white,
            ),
          ),
          confirmDismiss: (DismissDirection direction) => _askDelete(context),
          onDismissed: (DismissDirection direction) => _delete(context, model),
          child: _internalTile(context, index, model),
        );

  ///
  ///
  ///
  Widget _internalTile(BuildContext context, int index, T model) {
    return ListTile(
      enabled: enabled,
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          uiBuilder.getLeading(context, model),
        ],
      ),
      title: uiBuilder.getTitle(context, model),
      subtitle: uiBuilder.getSubtitle(context, model),
      trailing: Visibility(
        visible: FollyFields().isNotMobile && enabled && showDeleteButton,
        child: IconButton(
          icon: const Icon(FontAwesomeIcons.trashCan),
          onPressed: enabled ? () => _delete(context, model, ask: true) : null,
        ),
      ),
      onTap: () async {
        if (beforeEdit != null) {
          bool go = await beforeEdit!(
            field.context,
            index,
            model,
          );
          if (!go) {
            return;
          }
        }

        if (routeEditBuilder != null) {
          T? returned = await Navigator.of(field.context).push(
            MaterialPageRoute<T>(
              builder: (BuildContext context) => routeEditBuilder!(
                context,
                model,
                uiBuilder,
                enabled,
              ),
            ),
          );

          if (returned != null) {
            field.value![index] = returned;

            field.value!.sort(
              listSort ?? (T a, T b) => a.toString().compareTo(b.toString()),
            );

            onChanged?.call(field.value!);

            field.didChange(field.value);
          }
        }
      },
    );
  }

  ///
  ///
  ///
  Future<void> _delete(
    BuildContext context,
    T model, {
    bool ask = false,
  }) async {
    bool del = true;

    if (ask) {
      del = (await _askDelete(context)) ?? false;
    }

    if (del) {
      field.value!.remove(model);

      onChanged?.call(field.value!);

      field.didChange(field.value);
    }
  }

  ///
  ///
  ///
  Future<bool?> _askDelete(BuildContext context) => FollyDialogs.yesNoDialog(
        context: context,
        message: sprintf(
          removeText,
          <dynamic>[uiBuilder.superSingle(context)],
        ),
      );
}
