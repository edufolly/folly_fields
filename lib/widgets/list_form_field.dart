import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_model.dart';
import 'package:folly_fields/crud/abstract_ui_builder.dart';
import 'package:folly_fields/widgets/my_dialogs.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
class ListFormField<T extends AbstractModel> extends FormField<List<T>> {
  final AbstractUIBuilder<T> uiBuilder;
  final Widget Function(BuildContext, AbstractUIBuilder<T>) routeAddBuilder;
  final Widget Function(BuildContext, AbstractUIBuilder<T>, T) routeEditBuilder;
  final bool isWeb; // TODO - Pode ficar dentro do uiBuilder?
  final Future<bool> Function(BuildContext) beforeAdd;
  final Future<bool> Function(BuildContext, int, T) beforeEdit;

  ///
  ///
  ///
  ListFormField({
    Key key,
    @required List<T> list,
    @required this.uiBuilder,
    @required this.routeAddBuilder, // TODO - Precisa ser required?
    this.routeEditBuilder,
    FormFieldSetter<List<T>> onSaved,
    FormFieldValidator<List<T>> validator,
    bool enabled = true,
    this.isWeb = true,
    this.beforeAdd,
    this.beforeEdit,
  }) : super(
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
  _ListFormFieldState<T> createState() => _ListFormFieldState<T>(
        uiBuilder,
        routeAddBuilder,
        routeEditBuilder,
        isWeb,
        beforeAdd,
        beforeEdit,
      );
}

///
///
///
class _ListFormFieldState<T extends AbstractModel>
    extends FormFieldState<List<T>> {
  final AbstractUIBuilder<T> uiBuilder;
  final Widget Function(BuildContext, AbstractUIBuilder<T>) routeAddBuilder;
  final Widget Function(BuildContext, AbstractUIBuilder<T>, T) routeEditBuilder;
  final bool isWeb;
  final Future<bool> Function(BuildContext) beforeAdd;
  final Future<bool> Function(BuildContext, int, T) beforeEdit;

  ///
  ///
  ///
  _ListFormFieldState(
    this.uiBuilder,
    this.routeAddBuilder,
    this.routeEditBuilder,
    this.isWeb,
    this.beforeAdd,
    this.beforeEdit,
  );

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    super.build(context);

    InputDecoration inputDecoration = InputDecoration(
      labelText: uiBuilder.getSuperPlural(),
      border: OutlineInputBorder(),
      counterText: '',
      errorText: errorText,
    );

    InputDecoration effectiveDecoration =
        inputDecoration.applyDefaults(Theme.of(context).inputDecorationTheme);

    List<Widget> widgets = <Widget>[];

    if (value.isEmpty) {
      widgets.add(Container(
        height: 75.0,
        child: Center(
          child: Text('Sem ${uiBuilder.getSuperPlural()} até o momento.'),
        ),
      ));
    } else {
      value.asMap().forEach((int index, T model) {
        widgets.add(_getTile(context, index, model));
      });
    }

    widgets.add(
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
          onPressed: _add,
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InputDecorator(
        decoration: effectiveDecoration,
        child: Column(
          children: widgets,
        ),
      ),
    );
  }

  ///
  ///
  ///
  Widget _getTile(BuildContext context, int index, T model) {
    int id = model.id;
    return isWeb
        ? _internalTile(context, index, model)
        : Dismissible(
            // FIXME - Possui acentuação e espaços.
            key: Key('key_${uiBuilder.getSuperSingle()}_$id'),
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
            confirmDismiss: (DismissDirection direction) => _askDelete(),
            onDismissed: (DismissDirection direction) => _delete(model),
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
        visible: isWeb,
        child: IconButton(
          icon: Icon(FontAwesomeIcons.trashAlt),
          onPressed: () => _delete(model, ask: true),
        ),
      ),
      onTap:
          routeEditBuilder == null ? null : () => _edit(context, index, model),
    );
  }

  ///
  ///
  ///
  Future<bool> _askDelete() => MyDialogs.yesNoDialog(
        context: context,
        title: 'Atenção',
        message: 'Deseja remover ${uiBuilder.getSuperSingle()}?',
      );

  ///
  ///
  ///
  void _delete(T model, {bool ask = false}) async {
    bool delete = true;

    if (ask) {
      delete = await _askDelete();
    }

    if (delete) {
      value.remove(model);
      didChange(value);
    }
  }

  ///
  ///
  ///
  void _add() async {
    if (beforeAdd != null) {
      bool go = await beforeAdd(context);
      if (!go) return;
    }

    final dynamic selected = await Navigator.of(context).push(
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => routeAddBuilder(context, uiBuilder),
      ),
    );

    if (selected != null) {
      if (selected is List) {
        for (T item in selected) {
          if (item.id == null ||
              !value.any((T element) => element.id == item.id)) {
            value.add(item);
          }
        }
      } else {
        if ((selected as AbstractModel).id == null ||
            !value.any(
                (T element) => element.id == (selected as AbstractModel).id)) {
          value.add(selected);
        }
      }

      value.sort((T a, T b) => a.toString().compareTo(b.toString()));

      didChange(value);
    }
  }

  ///
  ///
  ///
  void _edit(BuildContext context, int index, T model) async {
    if (beforeEdit != null) {
      bool go = await beforeEdit(context, index, model);
      if (!go) return;
    }

    T returned = await Navigator.of(context).push(
      MaterialPageRoute<T>(
        builder: (BuildContext context) => routeEditBuilder(
          context,
          uiBuilder,
          model,
        ),
      ),
    );

    if (returned != null) {
      value[index] = returned;
      didChange(value);
    }
  }
}
