import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_consumer.dart';
import 'package:folly_fields/crud/abstract_model.dart';
import 'package:folly_fields/crud/abstract_ui_builder.dart';
import 'package:folly_fields/widgets/add_button.dart';
import 'package:folly_fields/widgets/delete_button.dart';
import 'package:folly_fields/widgets/empty_button.dart';
import 'package:folly_fields/widgets/field_group.dart';
import 'package:folly_fields/widgets/folly_divider.dart';
import 'package:folly_fields/widgets/header_cell.dart';

///
///
/// TODO - Test layout with DataTable.
/// TODO - Customize messages.
/// TODO - Create controller??
///
class TableField<T extends AbstractModel<Object>> extends FormField<List<T>> {
  ///
  ///
  ///
  TableField({
    Key? key,
    required List<T> initialValue,
    required AbstractUIBuilder<T> uiBuilder,
    required AbstractConsumer<T> consumer,
    required List<String> columns,
    List<int> columnsFlex = const <int>[],
    required List<Widget> Function(
      BuildContext context,
      T row,
      int index,
      List<T> data,
      bool enabled,
    )
        buildRow,
    Future<bool> Function(BuildContext context, List<T> data)? beforeAdd,
    void Function(BuildContext context, T row, int index, List<T> data)?
        removeRow,
    FormFieldSetter<List<T>>? onSaved,
    FormFieldValidator<List<T>>? validator,
    bool enabled = true,
    bool showAddButton = true,
    AutovalidateMode autoValidateMode = AutovalidateMode.disabled,
    Widget Function(BuildContext context, List<T> data)? buildFooter,
    InputDecoration? decoration,
    EdgeInsets padding = const EdgeInsets.all(8.0),
  })  : assert(columnsFlex.length == columns.length),
        super(
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
            TextStyle? columnHeaderTheme =
                Theme.of(field.context).textTheme.subtitle2;

            Color disabledColor = Theme.of(field.context).disabledColor;

            if (columnHeaderTheme != null && !enabled) {
              columnHeaderTheme =
                  columnHeaderTheme.copyWith(color: disabledColor);
            }

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

                  /// Empty table
                  SizedBox(
                    height: 75.0,
                    child: Center(
                      child: Text(
                        'Sem ${uiBuilder.getSuperPlural()} até o momento.',
                      ),
                    ),
                  )
                else

                  /// Table
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        /// Header
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            /// Columns Names
                            ...columns
                                .asMap()
                                .entries
                                .map<Widget>(
                                  (MapEntry<int, String> entry) => HeaderCell(
                                    flex: columnsFlex[entry.key],
                                    child: Text(
                                      entry.value,
                                      style: columnHeaderTheme,
                                    ),
                                  ),
                                )
                                .toList(),

                            /// Empty column to delete button
                            if (removeRow != null) const EmptyButton(),
                          ],
                        ),

                        /// Table data
                        ...field.value!.asMap().entries.map<Widget>(
                              (MapEntry<int, T> entry) => Column(
                                children: <Widget>[
                                  /// Divider
                                  FollyDivider(
                                    color: enabled ? null : disabledColor,
                                  ),

                                  /// Row
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      /// Cells
                                      ...buildRow(
                                        field.context,
                                        entry.value,
                                        entry.key,
                                        field.value!,
                                        enabled,
                                      )
                                          .asMap()
                                          .entries
                                          .map<Widget>(
                                            (MapEntry<int, Widget> entry) =>
                                                Flexible(
                                              flex: columnsFlex[entry.key],
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: entry.value,
                                              ),
                                            ),
                                          )
                                          .toList(),

                                      /// Delete button
                                      if (removeRow != null)
                                        DeleteButton(
                                          enabled: enabled,
                                          onPressed: () {
                                            removeRow(
                                              field.context,
                                              entry.value,
                                              entry.key,
                                              field.value!,
                                            );
                                            field.value!.removeAt(entry.key);
                                            field.didChange(field.value);
                                          },
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                        /// Footer
                        if (buildFooter != null)
                          buildFooter(field.context, field.value!),
                      ],
                    ),
                  ),

                /// Add button
                if (showAddButton)
                  AddButton(
                    enabled: enabled,
                    label:
                        'Adicionar ${uiBuilder.getSuperSingle()}'.toUpperCase(),
                    onPressed: () async {
                      if (beforeAdd != null) {
                        bool go = await beforeAdd(field.context, field.value!);
                        if (!go) return;
                      }

                      field.value!.add(consumer.fromJson(<String, dynamic>{}));
                      field.didChange(field.value);
                    },
                  ),
              ],
            );
          },
        );
}
