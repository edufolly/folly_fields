import 'dart:async';

import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_consumer.dart';
import 'package:folly_fields/crud/abstract_model.dart';
import 'package:folly_fields/crud/abstract_route.dart';
import 'package:folly_fields/crud/abstract_ui_builder.dart';
import 'package:folly_fields/folly_fields.dart';
import 'package:folly_fields/util/icon_helper.dart';
import 'package:folly_fields/widgets/circular_waiting.dart';
import 'package:folly_fields/widgets/folly_dialogs.dart';
import 'package:folly_fields/widgets/waiting_message.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
abstract class AbstractEdit<
    T extends AbstractModel<Object>,
    UI extends AbstractUIBuilder<T>,
    C extends AbstractConsumer<T>> extends StatefulWidget {
  final T model;
  final UI uiBuilder;
  final C? consumer;
  final bool edit;
  final CrossAxisAlignment crossAxisAlignment;
  final List<AbstractRoute> actionRoutes;

  ///
  ///
  ///
  const AbstractEdit(
    this.model,
    this.uiBuilder,
    this.consumer,
    this.edit, {
    Key? key,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.actionRoutes = const <AbstractRoute>[],
  }) : super(key: key);

  ///
  ///
  ///
  @override
  _AbstractEditState<T, UI, C> createState() => _AbstractEditState<T, UI, C>();

  ///
  ///
  ///
  Future<Map<String, dynamic>> stateInjection(
    BuildContext context,
    T model,
  ) async {
    return <String, dynamic>{};
  }

  ///
  ///
  ///
  List<Widget> formContent(
      BuildContext context,
      T model,
      bool edit,
      Map<String, dynamic> stateInjection,
      String prefix,
      Function(bool refresh) refresh);

  ///
  ///
  ///
  List<Widget> getFormContent(BuildContext context) {
    return formContent(
      context,
      model,
      edit,
      <String, dynamic>{},
      uiBuilder.prefix,
      (bool refresh) {}, // Era null
    );
  }

  ///
  ///
  ///
  void stateDispose(
    BuildContext context,
    Map<String, dynamic> stateInjection,
  ) {}
}

///
///
///
class _AbstractEditState<
    T extends AbstractModel<Object>,
    UI extends AbstractUIBuilder<T>,
    C extends AbstractConsumer<T>> extends State<AbstractEdit<T, UI, C>> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final StreamController<bool> _controller = StreamController<bool>();
  Map<String, dynamic> _stateInjection = <String, dynamic>{};
  T? _model;
  int? _initialHash;

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  ///
  ///
  ///
  Future<void> _loadData() async {
    try {
      bool exists = true;
      if (widget.model.id == null || widget.consumer == null) {
        Map<String, dynamic> copy = widget.model.toMap();
        _model = (widget.model.fromJson(copy) as T);
      } else {
        _model = await widget.consumer?.getById(context, widget.model);
      }

      _stateInjection = await widget.stateInjection(context, _model!);

      _controller.add(exists);

      _initialHash = _model.hashCode;
    } catch (error, stack) {
      _controller.addError(error, stack);
    }
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!widget.edit) return true;

        _formKey.currentState!.save();
        int currentHash = _model.hashCode;

        bool go = true;
        if (_initialHash != currentHash) {
          go = await FollyDialogs.yesNoDialog(
            context: context,
            title: 'Atenção',
            message: 'Modificações foram realizadas.\n\n'
                'Deseja sair mesmo assim?',
          );
        }
        return go;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.uiBuilder.getSuperSingle()),
          actions: <Widget>[
            if (widget.edit)
              IconButton(
                tooltip: 'Salvar',
                icon: FaIcon(
                  widget.consumer == null
                      ? FontAwesomeIcons.check
                      : FontAwesomeIcons.solidSave,
                ),
                onPressed: _save,
              ),

            // TODO - Transform to dropdown menu
            if (widget.actionRoutes.isNotEmpty && widget.consumer != null)
              ...widget.actionRoutes
                  .asMap()
                  .map(
                    (int index, AbstractRoute route) => MapEntry<int, Widget>(
                      index,
                      // TODO - Create an Action Route component.
                      FutureBuilder<ConsumerPermission>(
                        future: widget.consumer?.checkPermission(
                          context,
                          route.routeName,
                        ),
                        builder: (
                          BuildContext context,
                          AsyncSnapshot<ConsumerPermission> snapshot,
                        ) {
                          if (snapshot.hasData) {
                            ConsumerPermission permission = snapshot.data!;

                            return permission.view
                                ? IconButton(
                                    tooltip: permission.name,
                                    icon:
                                        IconHelper.faIcon(permission.iconName),
                                    onPressed: () async {
                                      print(route.path);

                                      dynamic close =
                                          await Navigator.of(context).pushNamed(
                                        route.path,
                                        arguments: _model,
                                      );

                                      if (close is bool) {
                                        if (close) {
                                          _initialHash = _model.hashCode;
                                          Navigator.of(context).pop();
                                        }
                                      }
                                    },
                                  )
                                : Container();
                          }

                          return Container();
                        },
                      ),
                    ),
                  )
                  .values
                  .toList(),
          ],
        ),
        bottomNavigationBar: widget.uiBuilder.buildBottomNavigationBar(context),
        body: widget.uiBuilder.buildBackgroundContainer(
          context,
          Form(
            key: _formKey,
            child: StreamBuilder<bool>(
              stream: _controller.stream,
              builder: (
                BuildContext context,
                AsyncSnapshot<bool> snapshot,
              ) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: widget.crossAxisAlignment,
                      children: widget.formContent(
                        context,
                        _model!,
                        widget.edit,
                        _stateInjection,
                        widget.uiBuilder.prefix,
                        _controller.add,
                      ),
                    ),
                  );
                }

                if (snapshot.hasError) {
                  if (FollyFields().isDebug) {
                    print(snapshot.error);
                    print(snapshot.stackTrace);
                  }

                  return Center(
                    child: Text(
                      'Ocorreu um erro:\n'
                      '${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                return WaitingMessage(message: 'Consultando...');
              },
            ),
          ),
        ),
      ),
    );
  }

  ///
  ///
  ///
  void _save() async {
    CircularWaiting wait = CircularWaiting(context);
    try {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        bool ok = true;

        if (widget.consumer != null) {
          ok = await widget.consumer!.beforeSaveOrUpdate(context, _model!);
          if (ok) {
            wait.show();
            ok = await widget.consumer!.saveOrUpdate(context, _model!);
            wait.close();
          }
        }

        if (ok) {
          _initialHash = _model.hashCode;
          Navigator.of(context).pop(_model);
        }
      }
    } catch (e, s) {
      wait.close();
      print(e);
      print(s);
      await FollyDialogs.dialogMessage(
        context: context,
        message: 'Ocorreu um erro ao tentar salvar:\n$e',
      );
    }
  }

  ///
  ///
  ///
  @override
  void dispose() {
    widget.stateDispose(context, _stateInjection);
    _controller.close();
    super.dispose();
  }
}
