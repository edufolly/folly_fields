import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_consumer.dart';
import 'package:folly_fields/crud/abstract_model.dart';
import 'package:folly_fields/crud/abstract_ui_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
class TableFormField<T extends AbstractModel> extends FormField<List<T>> {
  final AbstractUIBuilder<T> uiBuilder;
  final AbstractConsumer<T> consumer;
  final List<String> columns;
  final List<int> columnsFlex;
  final List<Widget> Function(T row, int index, List<T> data) buildRow;
  final Future<bool> Function(BuildContext context) beforeAdd;
  final void Function(T row, int index, List<T> data) removeRow;
  final bool isWeb;

  ///
  ///
  ///
  TableFormField({
    Key key,
    @required List<T> list,
    @required this.uiBuilder,
    @required this.consumer,
    @required this.columns,
    this.columnsFlex,
    @required this.buildRow,
    this.beforeAdd,
    this.removeRow,
    FormFieldSetter<List<T>> onSaved,
    FormFieldValidator<List<T>> validator,
    bool enabled = true,
    this.isWeb = true,
  })  : assert(columnsFlex == null || columnsFlex.length == columns.length),
        super(
          key: key,
          initialValue: list,
          onSaved: onSaved,
          validator: validator,
          enabled: enabled,
          builder: (FormFieldState<List<T>> field) => null,
        );

  ///
  ///
  ///
  @override
  _TableFormFieldState<T> createState() => _TableFormFieldState<T>(
        uiBuilder,
        consumer,
        columns,
        columnsFlex,
        buildRow,
        beforeAdd,
        removeRow,
        isWeb,
      );
}

///
///
///
class _TableFormFieldState<T extends AbstractModel>
    extends FormFieldState<List<T>> {
  final AbstractUIBuilder<T> uiBuilder;
  final AbstractConsumer<T> consumer;
  final List<String> columns;
  final List<int> columnsFlex;
  final List<Widget> Function(T row, int index, List<T> data) buildRow;
  final Future<bool> Function(BuildContext context) beforeAdd;
  final void Function(T row, int index, List<T> data) removeRow;
  final bool isWeb;

  ///
  ///
  ///
  _TableFormFieldState(
    this.uiBuilder,
    this.consumer,
    this.columns,
    this.columnsFlex,
    this.buildRow,
    this.beforeAdd,
    this.removeRow,
    this.isWeb,
  );

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final TextStyle columnTheme = Theme.of(context).textTheme.subtitle1;

    InputDecoration inputDecoration = InputDecoration(
      labelText: uiBuilder.getSuperPlural(),
      border: OutlineInputBorder(),
      counterText: '',
      errorText: errorText,
    );

    InputDecoration effectiveDecoration =
        inputDecoration.applyDefaults(Theme.of(context).inputDecorationTheme);

    List<Widget> internal = <Widget>[];

    if (value.isEmpty) {
      /// Tabela vazia.
      internal.add(Container(
        height: 75.0,
        child: Center(
          child: Text('Sem ${uiBuilder.getSuperPlural()} até o momento.'),
        ),
      ));
    } else {
      /// Conteúdo da tabela.
      List<Widget> tableBody = <Widget>[];

      /// Cabeçalho
      List<Widget> header = <Widget>[];

      /// Nome das Colunas
      for (int x = 0; x < columns.length; x++) {
        header.add(
          Flexible(
            flex: columnsFlex != null ? columnsFlex[x] : 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: SizedBox(
                width: double.infinity,
                child: Text(columns[x], style: columnTheme),
              ),
            ),
          ),
        );
      }

      /// Coluna vazia para o botão excluir.
      header.add(
        Flexible(
          flex: 0,
          child: IconButton(
            icon: FaIcon(
              FontAwesomeIcons.trashAlt,
              color: Colors.transparent,
            ),
            onPressed: null,
          ),
        ),
      );

      /// Adicionando cabeçalho na tabela.
      tableBody.add(
        Row(
          mainAxisSize: MainAxisSize.max,
          children: header,
        ),
      );

      /// Dados da tabela
      for (int i = 0; i < value.length; i++) {
        /// Divisor
        tableBody.add(Divider());

        /// Células
        List<Widget> tableRow = <Widget>[];

        List<Widget> cells = buildRow(value[i], i, value);

        for (int j = 0; j < cells.length; j++) {
          tableRow.add(
            Flexible(
              flex: columnsFlex != null ? columnsFlex[j] : 1,
              child: SizedBox(
                width: double.infinity,
                child: cells[j],
              ),
            ),
          );
        }

        /// Botão de excluir linha
        tableRow.add(
          Flexible(
            flex: 0,
            child: IconButton(
              icon: FaIcon(
                FontAwesomeIcons.trashAlt,
                color: Colors.black54,
              ),
              onPressed: () {
                if (removeRow != null) {
                  removeRow(value[i], i, value);
                }
                value.removeAt(i);
                didChange(value);
              },
            ),
          ),
        );

        tableBody.add(
          Row(
            children: tableRow,
          ),
        );
      }

      /// Tabela
      internal.add(
        Container(
          width: double.infinity,
          child: Column(
            children: tableBody,
          ),
        ),
      );
    }

    /// Botão Adicionar
    internal.add(
      Padding(
        padding: const EdgeInsets.only(
          left: 12.0,
          top: 12.0,
          right: 12.0,
        ),
        child: RaisedButton(
          elevation: 0.0,
          disabledElevation: 0.0,
          highlightElevation: 0.0,
          focusElevation: 0.0,
          hoverElevation: 0.0,
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
              Text(
                'Adicionar ${uiBuilder.getSuperSingle()}'.toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(color: Colors.white),
              ),
            ],
          ),
          onPressed: () async {
            if (beforeAdd != null) {
              bool go = await beforeAdd(context);
              if (!go) return;
            }

            value.add(consumer.modelInstance);
            didChange(value);
          },
        ),
      ),
    );

    /// Widget final
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InputDecorator(
        decoration: effectiveDecoration,
        child: Column(
          children: internal,
        ),
      ),
    );
  }
}
