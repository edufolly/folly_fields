import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_consumer.dart';
import 'package:folly_fields/crud/abstract_edit_content.dart';
import 'package:folly_fields/crud/abstract_edit_controller.dart';
import 'package:folly_fields/crud/abstract_function.dart';
import 'package:folly_fields/crud/abstract_model.dart';
import 'package:folly_fields/crud/abstract_route.dart';
import 'package:folly_fields/crud/abstract_ui_builder.dart';
import 'package:folly_fields/crud/empty_edit_controller.dart';
import 'package:folly_fields/responsive/responsive_grid.dart';
import 'package:folly_fields/util/safe_builder.dart';
import 'package:folly_fields/widgets/circular_waiting.dart';
import 'package:folly_fields/widgets/folly_dialogs.dart';
import 'package:folly_fields/widgets/model_function_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
abstract class AbstractEdit<
        T extends AbstractModel<Object>,
        UI extends AbstractUIBuilder<T>,
        C extends AbstractConsumer<T>,
        E extends AbstractEditController<T>> extends AbstractRoute
    implements AbstractEditContent<T, E> {
  final T model;
  final UI uiBuilder;
  final C consumer;
  final bool edit;
  final E? editController;
  final CrossAxisAlignment rowCrossAxisAlignment;
  final List<AbstractModelFunction<T>>? modelFunctions;

  ///
  ///
  ///
  const AbstractEdit(
    this.model,
    this.uiBuilder,
    this.consumer, {
    required this.edit,
    this.editController,
    this.rowCrossAxisAlignment = CrossAxisAlignment.start,
    this.modelFunctions,
    super.key,
  });

  ///
  ///
  ///
  @override
  List<String> get routeName => consumer.routeName;

  ///
  ///
  ///
  @override
  AbstractEditState<T, UI, C, E> createState() =>
      AbstractEditState<T, UI, C, E>();
}

///
///
///
class AbstractEditState<
        T extends AbstractModel<Object>,
        UI extends AbstractUIBuilder<T>,
        C extends AbstractConsumer<T>,
        E extends AbstractEditController<T>>
    extends State<AbstractEdit<T, UI, C, E>>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final StreamController<bool> _controller = StreamController<bool>();
  final StreamController<bool> _controllerModelFunctions =
      StreamController<bool>();

  late T _model;
  int _initialHash = 0;

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
      if (widget.model.id == null || widget.consumer.routeName.isEmpty) {
        _model = widget.consumer.fromJson(widget.model.toMap());
      } else {
        _model = await widget.consumer.getById(context, widget.model);
      }

      if (widget.modelFunctions != null) {
        _controllerModelFunctions.add(true);
      }

      await widget.editController?.init(context, _model);

      _controller.add(true);

      _initialHash = _model.hashCode;
    } on Exception catch (error, stack) {
      _controller.addError(error, stack);
    }
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.uiBuilder.superSingle(context)),
        actions: <Widget>[
          SilentStreamBuilder<bool>(
            stream: _controllerModelFunctions.stream,
            initialData: false,
            builder: (BuildContext context, bool data, _) => data
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: widget.modelFunctions!
                        .asMap()
                        .map(
                          (
                            int index,
                            AbstractModelFunction<T> editFunction,
                          ) =>
                              MapEntry<int, Widget>(
                            index,
                            SilentFutureBuilder<ConsumerPermission>(
                              future: widget.consumer.checkPermission(
                                context,
                                editFunction.routeName,
                              ),
                              builder: (
                                BuildContext context,
                                ConsumerPermission permission,
                                _,
                              ) {
                                if (permission.view) {
                                  _formKey.currentState!.save();

                                  return ModelFunctionButton<T>(
                                    rowFunction: editFunction,
                                    permission: permission,
                                    model: _model,
                                    callback: (Object? object) =>
                                        _controller.add(true),
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                          ),
                        )
                        .values
                        .toList(),
                  )
                : const SizedBox.shrink(),
          ),

          /// Save Button
          if (widget.edit)
            IconButton(
              tooltip: 'Salvar',
              icon: FaIcon(
                widget.consumer.routeName.isEmpty
                    ? FontAwesomeIcons.check
                    : FontAwesomeIcons.solidFloppyDisk,
              ),
              onPressed: _save,
            ),
        ],
      ),
      bottomNavigationBar: widget.uiBuilder.buildBottomNavigationBar(context),
      body: widget.uiBuilder.buildBackgroundContainer(
        context,
        Form(
          key: _formKey,
          onWillPop: () async {
            if (!widget.edit) {
              return true;
            }

            _formKey.currentState!.save();
            int currentHash = _model.hashCode;

            bool go = true;
            if (_initialHash != currentHash) {
              go = await FollyDialogs.yesNoDialog(
                context: context,
                message: 'Modificações foram realizadas.\n\n'
                    'Deseja sair mesmo assim?',
              );
            }
            return go;
          },
          child: SafeStreamBuilder<bool>(
            stream: _controller.stream,
            waitingMessage: 'Consultando...',
            builder: (
              BuildContext context,
              bool data,
              _,
            ) =>
                SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ResponsiveGrid(
                rowCrossAxisAlignment: widget.rowCrossAxisAlignment,
                children: widget.formContent(
                  context,
                  _model,
                  widget.uiBuilder.labelPrefix,
                  _controller.add,
                  _formKey.currentState!.validate,
                  widget.editController ?? (EmptyEditController<T>() as E),
                  edit: widget.edit,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///
  ///
  ///
  Future<void> _save() async {
    CircularWaiting wait = CircularWaiting(context);

    try {
      wait.show();

      _formKey.currentState!.save();

      if (widget.editController != null) {
        bool validated = await widget.editController!.validate(context, _model);
        if (!validated) {
          wait.close();
          return;
        }
      }

      if (_formKey.currentState!.validate()) {
        bool ok = true;

        if (widget.consumer.routeName.isNotEmpty) {
          ok = await widget.consumer.beforeSaveOrUpdate(context, _model);
          if (ok) {
            ok = await widget.consumer.saveOrUpdate(context, _model);
          }
        }

        wait.close();

        if (ok) {
          _initialHash = _model.hashCode;
          Navigator.of(context).pop(_model);
        }
      } else {
        wait.close();
      }
    } on Exception catch (e, s) {
      wait.close();

      if (kDebugMode) {
        print('$e\n$s');
      }

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
    widget.editController?.dispose(context);
    _controller.close();
    _controllerModelFunctions.close();
    super.dispose();
  }
}
