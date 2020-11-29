import 'dart:async';

import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_consumer.dart';
import 'package:folly_fields/crud/abstract_model.dart';
import 'package:folly_fields/crud/abstract_ui_builder.dart';
import 'package:folly_fields/util/icon_helper.dart';
import 'package:folly_fields/widgets/my_dialogs.dart';
import 'package:folly_fields/widgets/my_divider.dart';
import 'package:folly_fields/widgets/text_message.dart';
import 'package:folly_fields/widgets/waiting_message.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
abstract class AbstractList<T extends AbstractModel> extends StatefulWidget {
  final bool selection;
  final bool multipleSelection;
  final bool invertSelection;
  final bool forceOffline;
  final AbstractConsumer<T> consumer;
  final AbstractUIBuilder<T> uiBuilder;
  final Widget Function(
    AbstractConsumer<T> consumer,
    AbstractUIBuilder<T> uiBuilder,
  ) onAdd;
  final Widget Function(
    T model,
    AbstractConsumer<T> consumer,
    AbstractUIBuilder<T> uiBuilder,
  ) onUpdate;
  final Map<String, String> qsParam;
  final int itemsPerPage;
  final int qtdSuggestions;
  final List<List<String>> actionRoutes;
  final bool debug;
  final bool isWeb;
  final bool isMobile;

  ///
  ///
  ///
  static final TextStyle SUGGESTION_STYLE = const TextStyle(
    fontStyle: FontStyle.italic,
  );

  ///
  ///
  ///
  const AbstractList({
    Key key,
    @required this.selection,
    @required this.multipleSelection,
    this.invertSelection = false,
    this.forceOffline = false,
    @required this.consumer,
    @required this.uiBuilder,
    this.onAdd,
    this.onUpdate,
    this.qsParam,
    this.itemsPerPage = 50,
    this.qtdSuggestions = 15,
    this.actionRoutes = const <List<String>>[],
    this.debug = false,
    this.isWeb = false,
    this.isMobile = true,
  }) : super(key: key);

  ///
  ///
  ///
  List<String> get routeName => consumer.routeName;

  ///
  ///
  ///
  bool canDelete(T model) => true;

  ///
  ///
  ///
  @override
  _AbstractListState<T> createState() => _AbstractListState<T>();
}

///
///
///
class _AbstractListState<T extends AbstractModel>
    extends State<AbstractList<T>> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  ScrollController _scrollController;
  StreamController<bool> _streamController;

  List<T> _globalItems = <T>[];
  bool _loading = false;
  int _page = 0;

  bool _insert = false;
  bool _update = false;
  bool _delete = false;

  Map<int, T> selections = <int, T>{};

  final Map<String, String> _qsParam = <String, String>{};

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();

    if (widget.qsParam != null && widget.qsParam.isNotEmpty) {
      _qsParam.addAll(widget.qsParam);
    }

    _scrollController = ScrollController();
    _streamController = StreamController<bool>();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (!_loading && _page != null) {
          _loadData(context, clear: false);
        }
      }
    });

    _loadData(context);
  }

  ///
  ///
  ///
  Future<void> _loadData(
    BuildContext context, {
    bool clear = true,
  }) async {
    if (clear) {
      _globalItems = <T>[];
      _page = 0;
      _streamController.add(null);
    } else {
      _loading = true;
      _streamController.add(false);

      // ignore: unawaited_futures
      Future<dynamic>.delayed(Duration(milliseconds: 200)).then((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
        );
      });
    }

    try {
      if (!widget.selection) {
        ConsumerPermission permission =
            await widget.consumer.checkPermission(context);

        _insert = permission.insert && widget.onAdd != null;
        _update = permission.update && widget.onUpdate != null;
        _delete = permission.delete;
      }

      _qsParam['f'] = '${_page * widget.itemsPerPage}';
      _qsParam['q'] = '${widget.itemsPerPage}';
      _qsParam['s'] = '${widget.selection}';

      List<T> result = await widget.consumer.list(
        context,
        forceOffline: widget.forceOffline,
        qsParam: _qsParam,
      );

      if (result.isEmpty) {
        _page = null;
      } else {
        _page++;
        _globalItems.addAll(result);
      }

      _streamController.add(true);
      _loading = false;
    } catch (exception, stack) {
      if (widget.debug) {
        print(exception);
        print(stack);
      }
      _streamController.addError(exception, stack);
    }
  }

  ///
  ///
  ///
  Widget _getScaffoldTitle() {
    return Text(widget.selection
        ? 'Selecionar ${widget.uiBuilder.getSuperSingle()}'
        : widget.uiBuilder.getSuperPlural());
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _streamController.stream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: _getScaffoldTitle(),
            ),
            bottomNavigationBar: widget.uiBuilder.buildBottomNavigationBar(
              context: context,
            ),
            body: widget.uiBuilder.buildBackgroundContainer(
              context: context,
              child: Column(
                children: <Widget>[
                  Scrollbar(
                    child: RefreshIndicator(
                      key: _refreshIndicatorKey,
                      onRefresh: () => _loadData(context),
                      child: TextMessage(snapshot.error.toString()),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (snapshot.hasData) {
          /// Mostrar o carregando no final da lista.
          int itemCount = _globalItems.length;
          if (!snapshot.data) {
            itemCount++;
          }

          Widget _fabAdd;

          List<Widget> _actions = <Widget>[];

          /// Botão Selecionar Todos
          if (widget.selection == true &&
              widget.multipleSelection == true &&
              widget.invertSelection == true) {
            _actions.add(
              IconButton(
                tooltip: 'Inverter seleção',
                icon: Icon(Icons.select_all),
                onPressed: () {
                  for (T model in _globalItems) {
                    if (selections.containsKey(model.id)) {
                      selections.remove(model.id);
                    } else {
                      selections[model.id] = model;
                    }
                  }
                  setState(() {});
                },
              ),
            );
          }

          /// Botão Pesquisar
          // TODO - if (Config().isOnline) {
          _actions.add(
            IconButton(
              tooltip: 'Pesquisar ${widget.uiBuilder.getSuperSingle()}',
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch<T>(
                  context: context,
                  delegate: InternalSearch<T>(
                    abstractListModel: widget,
                    buildResultItem: _buildResultItem,
                    canDelete: (T model) =>
                        _delete && widget.isWeb && widget.canDelete(model),
                    qsParam: widget.qsParam,
                  ),
                ).then((T entity) {
                  if (entity != null) {
                    _internalRoute(
                      entity,
                      !selections.containsKey(entity.id),
                    );
                  }
                });
              },
            ),
          );

          /// Botão Confirmar Seleção
          if (widget.selection) {
            if (widget.multipleSelection) {
              _actions.add(
                IconButton(
                  tooltip: 'Selecionar ${widget.uiBuilder.getSuperPlural()}',
                  icon: FaIcon(FontAwesomeIcons.check),
                  onPressed: () => Navigator.of(context)
                      .pop(List<T>.from(selections.values)),
                ),
              );
            }
          } else {
            /// Action Routes
            widget.actionRoutes.forEach(
              (List<String> action) {
                _actions.add(
                  FutureBuilder<ConsumerPermission>(
                    future: widget.consumer.checkPermission(
                      context,
                      paths: action,
                    ),
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<ConsumerPermission> snapshot,
                    ) {
                      if (snapshot.hasData) {
                        ConsumerPermission permission = snapshot.data;

                        return IconButton(
                          tooltip: permission.name,
                          icon: FaIcon(
                            IconHelper.data[permission.iconName],
                          ),
                          onPressed: () => Navigator.of(context)
                              .pushNamed('/${action.join('/')}'),
                        );
                      }

                      return Container();
                    },
                  ),
                );
              },
            );

            /// Botão Adicionar
            if (_insert) {
              if (widget.isWeb) {
                _actions.add(
                  IconButton(
                    tooltip: 'Adicionar ${widget.uiBuilder.getSuperSingle()}',
                    icon: FaIcon(FontAwesomeIcons.plus),
                    onPressed: _addEntity,
                  ),
                );
              } else {
                _fabAdd = FloatingActionButton(
                  tooltip: 'Adicionar ${widget.uiBuilder.getSuperSingle()}',
                  child: FaIcon(FontAwesomeIcons.plus),
                  onPressed: _addEntity,
                );
              }
            }
          }

          return Scaffold(
            appBar: AppBar(
              title: _getScaffoldTitle(),
              actions: _actions,
            ),
            bottomNavigationBar: widget.uiBuilder.buildBottomNavigationBar(
              context: context,
            ),
            body: widget.uiBuilder.buildBackgroundContainer(
              context: context,
              child: RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: () => _loadData(context),
                child: _globalItems.isEmpty
                    ? TextMessage(
                        'Sem '
                        '${widget.uiBuilder.getSuperPlural().toLowerCase()}'
                        ' até o momento.',
                      )
                    : ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.all(16.0),
                        controller: _scrollController,
                        itemBuilder: (BuildContext context, int index) {
                          /// Atualizando...
                          if (index >= _globalItems.length) {
                            return Container(
                              height: 80,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }

                          T model = _globalItems[index];

                          if (_delete &&
                              widget.isMobile &&
                              widget.canDelete(model)) {
                            return Dismissible(
                              key: Key('key_${model.id}'),
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
                              confirmDismiss: (DismissDirection direction) =>
                                  _askDelete(),
                              onDismissed: (DismissDirection direction) =>
                                  _deleteEntity(model),
                              child: _buildResultItem(
                                model: model,
                                selection: selections.containsKey(model.id),
                                canDelete: false,
                                onTap: null,
                              ),
                            );
                          } else {
                            return _buildResultItem(
                              model: model,
                              selection: selections.containsKey(model.id),
                              canDelete: _delete &&
                                  widget.isWeb &&
                                  widget.canDelete(model),
                              onTap: null,
                            );
                          }
                        },
                        separatorBuilder: (_, __) => MyDivider(),
                        itemCount: itemCount,
                      ),
              ),
            ),
            floatingActionButton: _fabAdd,
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: _getScaffoldTitle(),
          ),
          bottomNavigationBar: widget.uiBuilder.buildBottomNavigationBar(
            context: context,
          ),
          body: widget.uiBuilder.buildBackgroundContainer(
            context: context,
            child: WaitingMessage(message: 'Consultando...'),
          ),
        );
      },
    );
  }

  ///
  ///
  ///
  Widget _buildResultItem({
    T model,
    bool selection,
    bool canDelete,
    Future<void> Function() afterDeleteRefresh,
    Function onTap,
  }) {
    return ListTile(
      leading: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          widget.multipleSelection && onTap == null
              ? FaIcon(
                  selection
                      ? FontAwesomeIcons.checkCircle
                      : FontAwesomeIcons.circle,
                )
              : widget.uiBuilder.getLeading(model),
        ],
      ),
      title: widget.uiBuilder.getTitle(model),
      subtitle: widget.uiBuilder.getSubtitle(model),
      trailing: canDelete
          ? IconButton(
              icon: Icon(FontAwesomeIcons.trashAlt),
              onPressed: () async {
                bool refresh = await _deleteEntity(model, ask: true);
                if (afterDeleteRefresh != null && refresh) {
                  await afterDeleteRefresh();
                }
              },
            )
          : Container(width: 1, height: 1),
      onTap: onTap != null
          ? () => onTap(model)
          : () => _internalRoute(
                model,
                !(selection ?? false),
              ),
    );
  }

  ///
  ///
  ///
  void _addEntity() async {
    await Navigator.of(context).push(
      MaterialPageRoute<dynamic>(
        builder: (_) => widget.onAdd(
          widget.consumer,
          widget.uiBuilder,
        ),
      ),
    );

    await _loadData(context, clear: true);
  }

  ///
  ///
  ///
  Future<bool> _deleteEntity(T model, {bool ask = false}) async {
    // FIXME - Possível bug em erros na web.
    try {
      bool del = true;

      if (ask) {
        del = await _askDelete();
      }

      if (del) {
        await widget.consumer.delete(context, model);

        if (ask) {
          await _loadData(context);
        }

        return ask;
      }
    } catch (e) {
      await MyDialogs.dialogMessage(
        context: context,
        message: 'Ocorreu um erro ao tentar excluir:\n$e',
      );
    }
    return !ask;
  }

  ///
  ///
  ///
  Future<bool> _askDelete() => MyDialogs.yesNoDialog(
        context: context,
        title: 'Atenção',
        message: 'Deseja excluir?',
      );

  ///
  ///
  ///
  void _internalRoute(T model, bool selected) {
    if (widget.selection) {
      if (widget.multipleSelection) {
        if (selected) {
          selections[model.id] = model;
        } else {
          selections.remove(model.id);
        }
        if (mounted) {
          setState(() {});
        }
      } else {
        Navigator.of(context).pop(model);
      }
    } else if (_update) {
      Navigator.of(context)
          .push(
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => widget.onUpdate(
                model,
                widget.consumer,
                widget.uiBuilder,
              ),
            ),
          )
          .then(
            (dynamic value) => _loadData(
              context,
              clear: true,
            ),
          );
    } else {
      return null;
    }
  }
}

///
///
///
class InternalSearch<W extends AbstractModel> extends SearchDelegate<W> {
  final AbstractList<W> abstractListModel;

  final Widget Function({
    @required W model,
    @required bool selection,
    @required bool canDelete,
    @required Future<void> Function() afterDeleteRefresh,
    @required Function(W model) onTap,
  }) buildResultItem;

  final bool Function(W) canDelete;

  final Map<String, String> qsParam;

  String _lastQuery;
  Widget _lastWidget;

  ///
  ///
  ///
  InternalSearch({
    @required this.abstractListModel,
    @required this.buildResultItem,
    @required this.canDelete,
    @required this.qsParam,
  });

  ///
  ///
  ///
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  ///
  ///
  ///
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  ///
  ///
  ///
  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Center(
        child: Text(
          'Começe a sua pesquisa.\n'
          'Digite ao menos 3 caracteres.',
        ),
      );
    } else {
      Map<String, String> param = <String, String>{};

      if (qsParam != null && qsParam.isNotEmpty) {
        param.addAll(qsParam);
      }

      if (query.contains('%')) {
        query = query.replaceAll('%', '');
      }

      param['t'] = query.toLowerCase();

      return FutureBuilder<List<W>>(
        future: abstractListModel.consumer.list(
          context,
          forceOffline: abstractListModel.forceOffline,
          qsParam: param,
        ),
        builder: (BuildContext context, AsyncSnapshot<List<W>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.isNotEmpty) {
              return ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return buildResultItem(
                    model: snapshot.data[index],
                    selection: false,
                    canDelete: canDelete(snapshot.data[index]),
                    onTap: (W entity) => close(context, entity),
                    afterDeleteRefresh: () async => query += '%',
                  );
                },
                separatorBuilder: (_, __) => MyDivider(),
                itemCount: snapshot.data.length,
              );
            } else {
              return Center(
                child: Text('Nenhum documento.'),
              );
            }
          }

          // TODO - Tratar erro.

          return WaitingMessage(message: 'Consultando...');
        },
      );
    }
  }

  ///
  ///
  ///
  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length < 3) {
      return Center(
        child: Text(
          'Começe a sua pesquisa.\n'
          'Digite ao menos 3 caracteres.',
        ),
      );
    } else {
      if (_lastQuery == query && _lastWidget != null) {
        return _lastWidget;
      } else {
        Map<String, String> param = <String, String>{};

        _lastQuery = query;

        if (qsParam != null && qsParam.isNotEmpty) {
          param.addAll(qsParam);
        }

        param['t'] = query.replaceAll('%', '').toLowerCase();

        param['q'] = abstractListModel.itemsPerPage.toString();

        _lastWidget = FutureBuilder<List<W>>(
          future: abstractListModel.consumer.list(
            context,
            forceOffline: abstractListModel.forceOffline,
            qsParam: param,
          ),
          builder: (BuildContext context, AsyncSnapshot<List<W>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.isNotEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Sugestões:',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          W model = snapshot.data[index];

                          return ListTile(
                            title: abstractListModel.uiBuilder
                                .getSuggestionTitle(model),
                            subtitle: abstractListModel.uiBuilder
                                .getSuggestionSubtitle(model),
                            onTap: () {
                              _lastQuery = model.searchTerm;
                              query = _lastQuery;
                              showResults(context);
                            },
                          );
                        },
                        itemCount: snapshot.data.length,
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Text('Nenhum documento.'),
                );
              }
            }

            // TODO - Tratar erro.

            return WaitingMessage(message: 'Consultando...');
          },
        );

        return _lastWidget;
      }
    }
  }
}
