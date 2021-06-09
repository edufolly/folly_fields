import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_consumer.dart';
import 'package:folly_fields/crud/abstract_model.dart';
import 'package:folly_fields/crud/abstract_ui_builder.dart';
import 'package:folly_fields/widgets/folly_divider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
            BuildContext context, T row, int index, List<T> data)
        buildRow,
    Future<bool> Function(BuildContext context, List<T> data)? beforeAdd,
    void Function(BuildContext context, T row, int index, List<T> data)?
        removeRow,
    FormFieldSetter<List<T>>? onSaved,
    FormFieldValidator<List<T>>? validator,
    bool enabled = true,
    AutovalidateMode autoValidateMode = AutovalidateMode.disabled,
    Widget Function(BuildContext context, List<T> data)? buildFooter,
    InputDecoration? decoration,
    EdgeInsets padding = const EdgeInsets.all(8.0),
  })  : assert(columnsFlex.length == columns.length),
        super(
          key: key,
          initialValue: initialValue,
          onSaved: onSaved,
          validator: validator,
          enabled: enabled,
          autovalidateMode: autoValidateMode,
          builder: (FormFieldState<List<T>> field) {
            final TextStyle? columnTheme =
                Theme.of(field.context).textTheme.subtitle2;

            InputDecoration effectiveDecoration = (decoration ??
                    InputDecoration(
                      labelText: uiBuilder.getSuperPlural(),
                      border: OutlineInputBorder(),
                      counterText: '',
                    ))
                .applyDefaults(Theme.of(field.context).inputDecorationTheme)
                .copyWith(errorText: field.errorText);

            return Padding(
              padding: padding,
              child: InputDecorator(
                decoration: effectiveDecoration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    if (field.value!.isEmpty)

                      /// Empty table
                      Container(
                        height: 75.0,
                        child: Center(
                          child: Text(
                            'Sem ${uiBuilder.getSuperPlural()} até o momento.',
                          ),
                        ),
                      )
                    else

                      /// Table
                      Container(
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
                                      (MapEntry<int, String> entry) =>
                                          HeaderCell(
                                        flex: columnsFlex[entry.key],
                                        child: Text(
                                          entry.value,
                                          style: columnTheme,
                                        ),
                                      ),
                                    )
                                    .toList(),

                                /// Empty column to delete button
                                EmptyButton(),
                              ],
                            ),

                            /// Table data
                            ...field.value!.asMap().entries.map<Widget>(
                                  (MapEntry<int, T> entry) => Column(
                                    children: <Widget>[
                                      /// Divider
                                      FollyDivider(),

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
                                          DeleteButton(
                                            onPressed: () {
                                              if (removeRow != null) {
                                                removeRow(
                                                  field.context,
                                                  entry.value,
                                                  entry.key,
                                                  field.value!,
                                                );
                                              }
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
                    AddButton(
                      label: 'Adicionar ${uiBuilder.getSuperSingle()}'
                          .toUpperCase(),
                      onPressed: () async {
                        if (beforeAdd != null) {
                          bool go =
                              await beforeAdd(field.context, field.value!);
                          if (!go) return;
                        }

                        field.value!
                            .add(consumer.fromJson(<String, dynamic>{}));
                        field.didChange(field.value);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
}

///
///
///
class AddButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  ///
  ///
  ///
  const AddButton({
    Key? key,
    required this.label,
    this.onPressed,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(12.0),
        ),
        icon: FaIcon(
          FontAwesomeIcons.plus,
        ),
        label: Text(
          label.toUpperCase(),
          overflow: TextOverflow.ellipsis,
        ),
        onPressed: onPressed,
      ),
    );
  }
}

///
///
///
class EmptyButton extends StatelessWidget {
  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 0,
      child: IconButton(
        icon: FaIcon(
          FontAwesomeIcons.trashAlt,
          color: Colors.transparent,
        ),
        onPressed: null,
      ),
    );
  }
}

///
///
///
class DeleteButton extends StatelessWidget {
  final VoidCallback onPressed;

  ///
  ///
  ///
  const DeleteButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 0,
      child: Padding(
        padding: EdgeInsets.only(
          top: 12.0,
        ),
        child: IconButton(
          icon: FaIcon(
            FontAwesomeIcons.trashAlt,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}

///
///
///
class HeaderCell extends StatelessWidget {
  final int flex;
  final Widget child;

  ///
  ///
  ///
  const HeaderCell({
    Key? key,
    this.flex = 1,
    required this.child,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
        ),
        child: SizedBox(
          width: double.infinity,
          child: child,
        ),
      ),
    );
  }
}
