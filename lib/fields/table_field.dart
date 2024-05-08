import 'package:flutter/material.dart';
import 'package:folly_fields/responsive/responsive.dart';
import 'package:folly_fields/responsive/responsive_builder.dart';
import 'package:folly_fields/responsive/responsive_form_field.dart';
import 'package:folly_fields/responsive/responsive_grid.dart';
import 'package:folly_fields/widgets/empty_button.dart';
import 'package:folly_fields/widgets/field_group.dart';
import 'package:folly_fields/widgets/folly_divider.dart';
import 'package:folly_fields/widgets/table_button.dart';
import 'package:folly_fields/widgets/table_icon_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sprintf/sprintf.dart';

///
///
///
class TableField<T> extends ResponsiveFormField<List<T>> {
  ///
  ///
  ///
  TableField({
    required List<T> super.initialValue,
    required String plural,
    required String single,
    required T Function() create,
    required List<Responsive> Function(
      BuildContext context,
      T row,
      int index,
      List<T> data, {
      required bool isCard,
      required bool enabled,
      required Function(List<T> value) didChange,
    }) buildRow,
    List<Widget> columnHeaders = const <Widget>[],
    List<int>? columnsFlex,
    Future<bool> Function(BuildContext context, List<T> data)? beforeAdd,
    Future<bool> Function(BuildContext context, T row, int index, List<T> data)?
        removeRow,
    String? Function(List<T>)? validator,
    void Function(List<T>)? onSaved,
    super.enabled,
    bool showAddButton = true,
    bool showTopAddButton = true,
    bool withDivider = true,
    AutovalidateMode autoValidateMode = AutovalidateMode.disabled,
    Widget Function(
      BuildContext context,
      List<T> data, {
      required bool isCard,
    })? buildFooter,
    InputDecoration? decoration,
    EdgeInsets padding = const EdgeInsets.all(8),
    super.sizeExtraSmall,
    super.sizeSmall,
    super.sizeMedium,
    super.sizeLarge,
    super.sizeExtraLarge,
    super.minHeight,
    ResponsiveSize? changeToCard,
    double? elevation,
    String emptyListText = 'Sem %s até o momento.',
    String removeText = 'Remover %s',
    String addText = 'Adicionar %s',
    super.key,
  })  : assert(
          columnsFlex == null || columnsFlex.length == columnHeaders.length,
          'columnsFlex must be null or columnsFlex.length equals to '
          'columnHeaders.length.',
        ),
        super(
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
                      labelText: plural,
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
                /// Empty
                if (field.value?.isEmpty ?? true)
                  SizedBox(
                    height: 75,
                    child: Center(
                      child: Text(sprintf(emptyListText, <dynamic>[plural])),
                    ),
                  )

                /// Table
                else
                  ResponsiveBuilder(
                    builder: (
                      BuildContext context,
                      ResponsiveSize responsiveSize,
                    ) {
                      bool isCard = false;
                      List<Widget> columnData = <Widget>[];

                      /// Card
                      if (changeToCard != null &&
                          responsiveSize <= changeToCard) {
                        isCard = true;

                        /// Card data
                        for (final MapEntry<int, T>(:int key, :T value)
                            in field.value!.asMap().entries) {
                          columnData.add(
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Card(
                                elevation: elevation,
                                child: ResponsiveGrid(
                                  margin: const EdgeInsets.all(4),
                                  children: <Responsive>[
                                    /// Fields
                                    ...buildRow(
                                      field.context,
                                      value,
                                      key,
                                      field.value!,
                                      isCard: isCard,
                                      enabled: enabled,
                                      didChange: field.didChange,
                                    ),

                                    /// Delete button
                                    if (removeRow != null)
                                      TableButton(
                                        enabled: enabled,
                                        iconData: FontAwesomeIcons.trashCan,
                                        padding: const EdgeInsets.all(8),
                                        label: sprintf(
                                          removeText,
                                          <dynamic>[single],
                                        ).toUpperCase(),
                                        onPressed: () async {
                                          bool go = await removeRow(
                                            field.context,
                                            value,
                                            key,
                                            field.value!,
                                          );
                                          if (!go) {
                                            return;
                                          }
                                          field.value!.removeAt(key);
                                          field.didChange(field.value);
                                        },
                                        sizeMedium: 12,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }

                        /// Table
                      } else {
                        /// Header
                        if (columnHeaders.isNotEmpty) {
                          columnData.add(
                            Row(
                              children: <Widget>[
                                /// Columns Names
                                ...columnHeaders.asMap().entries.map<Widget>(
                                  (MapEntry<int, Widget> entry) {
                                    int flex = columnsFlex?[entry.key] ?? 1;

                                    if (flex < 1) {
                                      return entry.value;
                                    }

                                    return Flexible(
                                      flex: flex,
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: entry.value,
                                      ),
                                    );
                                  },
                                ),

                                /// Empty column to delete button
                                if (removeRow != null)
                                  showTopAddButton
                                      ? TableIconButton(
                                          enabled: enabled,
                                          iconData: FontAwesomeIcons.plus,
                                          tooltip: sprintf(
                                            addText,
                                            <dynamic>[single],
                                          ),
                                          onPressed: () async {
                                            if (beforeAdd != null) {
                                              bool go = await beforeAdd(
                                                field.context,
                                                field.value!,
                                              );
                                              if (!go) {
                                                return;
                                              }
                                            }

                                            field.value!.insert(0, create());
                                            field.didChange(field.value);
                                          },
                                        )
                                      : const EmptyButton(),
                              ],
                            ),
                          );
                        }

                        /// Table data
                        for (final MapEntry<int, T>(:int key, :T value)
                            in field.value!.asMap().entries) {
                          columnData.addAll(
                            <Widget>[
                              /// Divider
                              if (withDivider || key == 0)
                                FollyDivider(enabled: enabled),

                              /// Row
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  /// Cells
                                  ...buildRow(
                                    field.context,
                                    value,
                                    key,
                                    field.value!,
                                    isCard: isCard,
                                    enabled: enabled,
                                    didChange: field.didChange,
                                  ).asMap().entries.map<Widget>(
                                    (MapEntry<int, Widget> entry) {
                                      int flex = columnsFlex?[entry.key] ?? 1;

                                      if (flex < 1) {
                                        return entry.value;
                                      }

                                      return Flexible(
                                        flex: flex,
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: entry.value,
                                        ),
                                      );
                                    },
                                  ),

                                  /// Delete button
                                  if (removeRow != null)
                                    TableIconButton(
                                      enabled: enabled,
                                      iconData: FontAwesomeIcons.trashCan,
                                      tooltip: sprintf(
                                        removeText,
                                        <dynamic>[single],
                                      ),
                                      onPressed: () async {
                                        bool go = await removeRow(
                                          field.context,
                                          value,
                                          key,
                                          field.value!,
                                        );
                                        if (!go) {
                                          return;
                                        }
                                        field.value!.removeAt(key);
                                        field.didChange(field.value);
                                      },
                                    ),
                                ],
                              ),
                            ],
                          );
                        }
                      }

                      /// Footer
                      if (buildFooter != null) {
                        columnData.add(
                          buildFooter(
                            field.context,
                            field.value!,
                            isCard: isCard,
                          ),
                        );
                      }

                      return Column(children: columnData);
                    },
                  ),

                /// Add button
                if (showAddButton)
                  TableButton(
                    enabled: enabled,
                    iconData: FontAwesomeIcons.plus,
                    label: sprintf(addText, <dynamic>[single]).toUpperCase(),
                    onPressed: () async {
                      if (beforeAdd != null) {
                        bool go = await beforeAdd(field.context, field.value!);
                        if (!go) {
                          return;
                        }
                      }

                      field.value!.add(create());
                      field.didChange(field.value);
                    },
                  ),
              ],
            );
          },
        );
}
