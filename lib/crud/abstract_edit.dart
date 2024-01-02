import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_consumer.dart';
import 'package:folly_fields/crud/abstract_edit_controller.dart';
import 'package:folly_fields/crud/abstract_model.dart';
import 'package:folly_fields/crud/abstract_route.dart';
import 'package:folly_fields/crud/abstract_ui_builder.dart';
import 'package:folly_fields/responsive/responsive.dart';
import 'package:folly_fields/responsive/responsive_grid.dart';
import 'package:folly_fields/util/safe_builder.dart';
import 'package:folly_fields/widgets/circular_waiting.dart';
import 'package:folly_fields/widgets/folly_dialogs.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sprintf/sprintf.dart';

///
///
///
abstract class AbstractEdit<
    T extends AbstractModel<ID>,
    UI extends AbstractUIBuilder<T, ID>,
    C extends AbstractConsumer<T, ID>,
    E extends AbstractEditController<T, ID>,
    ID> extends AbstractRoute {
  final T model;
  final UI uiBuilder;
  final C consumer;
  final bool edit;
  final E? editController;
  final CrossAxisAlignment rowCrossAxisAlignment;
  final Widget? Function(BuildContext context)? appBarLeading;
  final void Function(BuildContext context, T? model)? afterSave;
  final List<Widget> Function({
    required BuildContext context,
    required T model,
  })? actions;
  final String exitWithoutSaveMessage;
  final String saveErrorText;

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
    this.appBarLeading,
    this.afterSave,
    this.actions,
    this.exitWithoutSaveMessage = 'Modificações foram realizadas.\n\n'
        'Deseja sair mesmo assim?',
    this.saveErrorText = 'Ocorreu um erro ao tentar salvar:\n%s',
    super.key,
  });

  ///
  ///
  ///
  List<Responsive> formContent(
    BuildContext context,
    T model, {
    required bool edit,
    bool Function()? formValidate,
    void Function({required bool refresh})? refresh,
  });

  ///
  ///
  ///
  @override
  List<String> get routeName => consumer.routeName;

  ///
  ///
  ///
  Future<void> onSaveError(
    BuildContext context,
    T? model,
    Exception e,
    StackTrace s,
  ) async {
    await FollyDialogs.dialogMessage(
      context: context,
      message: sprintf(saveErrorText, <String>[e.toString()]),
    );
  }

  ///
  ///
  ///
  @override
  AbstractEditState<T, UI, C, E, ID> createState() =>
      AbstractEditState<T, UI, C, E, ID>();
}

///
///
///
class AbstractEditState<
        T extends AbstractModel<ID>,
        UI extends AbstractUIBuilder<T, ID>,
        C extends AbstractConsumer<T, ID>,
        E extends AbstractEditController<T, ID>,
        ID> extends State<AbstractEdit<T, UI, C, E, ID>>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final StreamController<bool> _controller = StreamController<bool>();

  late T _model;
  int _initialHash = 0;
  bool _alreadyPopped = false;

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
      _model = widget.consumer.fromJson(widget.model.toMap());

      if (widget.model.id != null && widget.consumer.routeName.isNotEmpty) {
        _model = await widget.consumer.getById(context, widget.model) ?? _model;
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
        leading: widget.appBarLeading == null
            ? null
            : widget.appBarLeading!(context),
        title: Text(widget.uiBuilder.superSingle(context)),
        actions: <Widget>[
          /// Actions
          if (widget.actions != null)
            ...widget.actions!(
              context: context,
              model: _model,
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
      body: widget.uiBuilder.buildEditBody(
        context,
        _model,
        Form(
          key: _formKey,
          canPop: false,
          onPopInvoked: (_) {
            if (_alreadyPopped) {
              return;
            }

            if (!widget.edit) {
              _alreadyPopped = true;
              Navigator.of(context).pop();
            }

            _formKey.currentState!.save();
            int currentHash = _model.hashCode;

            if (_initialHash != currentHash) {
              if (kDebugMode) {
                print('Hash: $_initialHash - $currentHash');
              }

              FollyDialogs.yesNoDialog(
                context: context,
                message: 'Modificações foram realizadas.\n\n'
                    'Deseja sair mesmo assim?',
              ).then((bool go) {
                if (go) {
                  _alreadyPopped = true;
                  Navigator.of(context).pop();
                }
              });
            } else {
              _alreadyPopped = true;
              Navigator.of(context).pop();
            }
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
                  edit: widget.edit,
                  formValidate: _formKey.currentState?.validate,
                  refresh: ({required bool refresh}) =>
                      _controller.add(refresh),
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
    T? model = _model;
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
        bool go = true;

        if (widget.consumer.routeName.isNotEmpty) {
          go = await widget.consumer.beforeSaveOrUpdate(context, _model);
          if (go) {
            model = await widget.consumer.saveOrUpdate(context, _model);
            go = model != null;
          }
        }

        wait.close();

        if (go) {
          _initialHash = _model.hashCode;
          if (widget.afterSave == null) {
            Navigator.of(context).pop(model);
          } else {
            widget.afterSave?.call(context, model);
          }
        }
      } else {
        wait.close();
      }
    } on Exception catch (e, s) {
      wait.close();

      if (kDebugMode) {
        print('$e\n$s');
      }

      await widget.onSaveError(context, model, e, s);
    }
  }

  ///
  ///
  ///
  @override
  void dispose() {
    widget.editController?.dispose(context);
    _controller.close();
    super.dispose();
  }
}
