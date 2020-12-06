import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_consumer.dart';
import 'package:folly_fields/crud/abstract_model.dart';
import 'package:folly_fields/crud/abstract_ui_builder.dart';
import 'package:folly_fields/widgets/my_divider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
/// TODO - Testar com DataTable.
class TableFormField<T extends AbstractModel> extends FormField<List<T>> {
  ///
  ///
  ///
  TableFormField({
    Key key,
    @required List<T> initialValue,
    @required AbstractUIBuilder<T> uiBuilder,
    @required AbstractConsumer<T> consumer,
    @required List<String> columns,
    List<int> columnsFlex = const <int>[],
    @required List<Widget> Function(T row, int index, List<T> data) buildRow,
    Future<bool> Function(BuildContext context) beforeAdd,
    void Function(T row, int index, List<T> data) removeRow,
    FormFieldSetter<List<T>> onSaved,
    FormFieldValidator<List<T>> validator,
    bool enabled = true,
    AutovalidateMode autoValidateMode,
  })  : assert(columnsFlex == null || columnsFlex.length == columns.length),
        super(
          key: key,
          initialValue: initialValue ?? <T>[],
          onSaved: onSaved,
          validator: validator,
          enabled: enabled,
          autovalidateMode: autoValidateMode ?? AutovalidateMode.disabled,
          builder: (FormFieldState<List<T>> field) {
            final TextStyle columnTheme =
                Theme.of(field.context).textTheme.subtitle2;

            InputDecoration inputDecoration = InputDecoration(
              labelText: uiBuilder.getSuperPlural(),
              border: OutlineInputBorder(),
              counterText: '',
              errorText: field.errorText,
            );

            InputDecoration effectiveDecoration = inputDecoration
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InputDecorator(
                decoration: effectiveDecoration,
                child: Column(
                  children: <Widget>[
                    if (field.value.isEmpty)

                      /// Tabela vazia
                      Container(
                        height: 75.0,
                        child: Center(
                          child: Text(
                            'Sem ${uiBuilder.getSuperPlural()} até o momento.',
                          ),
                        ),
                      )
                    else

                      /// Tabela
                      Container(
                        width: double.infinity,
                        child: Column(
                          children: <Widget>[
                            /// Cabeçalho
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                /// Nome das colunas
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

                                /// Coluna vazia para o botão excluir
                                DeleteButton(
                                  onPressed: null,
                                  color: Colors.transparent,
                                  top: 0.0,
                                ),
                              ],
                            ),

                            /// Dados da tabela
                            ...field.value.asMap().entries.map<Widget>(
                                  (MapEntry<int, T> entry) => Column(
                                    children: <Widget>[
                                      /// Divisor
                                      MyDivider(
                                        color: Colors.black12,
                                      ),

                                      /// Linha
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          /// Células
                                          ...buildRow(
                                            entry.value,
                                            entry.key,
                                            field.value,
                                          )
                                              .asMap()
                                              .entries
                                              .map<Widget>(
                                                (MapEntry<int, Widget> entry) =>
                                                    Flexible(
                                                  flex:
                                                      columnsFlex[entry.key] ??
                                                          1,
                                                  child: SizedBox(
                                                    width: double.infinity,
                                                    child: entry.value,
                                                  ),
                                                ),
                                              )
                                              .toList(),

                                          /// Botão de excluir linha
                                          DeleteButton(
                                            onPressed: () {
                                              if (removeRow != null) {
                                                removeRow(
                                                  entry.value,
                                                  entry.key,
                                                  field.value,
                                                );
                                              }
                                              field.value.removeAt(entry.key);
                                              field.didChange(field.value);
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                          ],
                        ),
                      ),

                    /// Divisor
                    MyDivider(
                      color: Colors.black12,
                    ),

                    /// Botão Adicionar

                    AddButton(
                      text: Text(
                        'Adicionar ${uiBuilder.getSuperSingle()}'.toUpperCase(),
                        style: Theme.of(field.context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (beforeAdd != null) {
                          bool go = await beforeAdd(field.context);
                          if (!go) return;
                        }

                        field.value.add(consumer.modelInstance);
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
  final Text text;
  final VoidCallback onPressed;

  ///
  ///
  ///
  const AddButton({
    Key key,
    this.text,
    this.onPressed,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0),
      child: FlatButton(
        color: Colors.grey,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FaIcon(
                FontAwesomeIcons.plus,
                color: Colors.white,
              ),
            ),
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}

///
///
///
class DeleteButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;
  final double top;

  ///
  ///
  ///
  const DeleteButton({
    Key key,
    @required this.onPressed,
    this.color = Colors.black54,
    this.top = 12.0,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 0,
      child: IconButton(
        padding: EdgeInsets.only(
          top: top,
        ),
        icon: FaIcon(
          FontAwesomeIcons.trashAlt,
          color: color,
        ),
        onPressed: onPressed,
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
    Key key,
    this.flex = 1,
    @required this.child,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: flex ?? 1,
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
