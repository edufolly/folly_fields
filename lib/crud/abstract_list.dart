import 'dart:async';

import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_consumer.dart';
import 'package:folly_fields/crud/abstract_function.dart';
import 'package:folly_fields/crud/abstract_model.dart';
import 'package:folly_fields/crud/abstract_route.dart';
import 'package:folly_fields/crud/abstract_ui_builder.dart';
import 'package:folly_fields/folly_fields.dart';
import 'package:folly_fields/util/icon_helper.dart';
import 'package:folly_fields/widgets/circular_waiting.dart';
import 'package:folly_fields/widgets/folly_dialogs.dart';
import 'package:folly_fields/widgets/folly_divider.dart';
import 'package:folly_fields/widgets/text_message.dart';
import 'package:folly_fields/widgets/waiting_message.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
abstract class AbstractList<
    T extends AbstractModel<Object>,
    UI extends AbstractUIBuilder<T>,
    C extends AbstractConsumer<T>> extends AbstractRoute {
  final bool selection;
  final bool multipleSelection;
  final bool invertSelection;
  final bool forceOffline;
  final C consumer;
  final UI uiBuilder;
  final Future<Widget?> Function(
    BuildContext context,
    UI uiBuilder,
    C consumer,
  )? onAdd;
  final Future<Widget?> Function(
    BuildContext context,
    T model,
    UI uiBuilder,
    C consumer,
    bool edit,
  )? onUpdate;
  final Map<String, String> qsParam;
  final int itemsPerPage;
  final int qtdSuggestions;
  final List<AbstractRoute> actionRoutes;
  final Future<Widget?> Function(
    BuildContext context,
    T model,
    UI uiBuilder,
    C consumer,
    bool edit,
  )? onLongPress;
  final Map<AbstractRoute, ActionFunction<T>>? actionFunctions;
  final String? searchFieldLabel;
  final TextStyle? searchFieldStyle;
  final InputDecorationTheme? searchFieldDecorationTheme;
  final TextInputType? searchKeyboardType;
  final TextInputAction searchTextInputAction;

  ///
  ///
  ///
  static const TextStyle suggestionStyle = TextStyle(
    fontStyle: FontStyle.italic,
  );

  ///
  ///
  ///
  const AbstractList({
    Key? key,
    required this.selection,
    required this.multipleSelection,
    this.invertSelection = false,
    this.forceOffline = false,
    required this.consumer,
    required this.uiBuilder,
    this.onAdd,
    this.onUpdate,
    this.qsParam = const <String, String>{},
    this.itemsPerPage = 50,
    this.qtdSuggestions = 15,
    this.actionRoutes = const <AbstractRoute>[],
    this.onLongPress,
    this.actionFunctions,
    this.searchFieldLabel,
    this.searchFieldStyle,
    this.searchFieldDecorationTheme,
    this.searchKeyboardType,
    this.searchTextInputAction = TextInputAction.search,
  })  : assert(searchFieldStyle == null || searchFieldDecorationTheme == null),
        super(key: key);

  ///
  ///
  ///
  @override
  List<String> get routeName => consumer.routeName;

  ///
  ///
  ///
  bool canDelete(T model) => true;

  ///
  ///
  ///
  @override
  _AbstractListState<T, UI, C> createState() => _AbstractListState<T, UI, C>();
}

///
///
///
class _AbstractListState<
    T extends AbstractModel<Object>,
    UI extends AbstractUIBuilder<T>,
    C extends AbstractConsumer<T>> extends State<AbstractList<T, UI, C>> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  final ScrollController _scrollController = ScrollController();
  final StreamController<bool?> _streamController = StreamController<bool?>();

  List<T> _globalItems = <T>[];
  bool _loading = false;
  int _page = 0;

  bool _insert = false;
  bool _update = false;
  bool _delete = false;

  Map<Object, T> selections = <Object, T>{};

  final Map<String, String> _qsParam = <String, String>{};

  final Map<ConsumerPermission, AbstractRoute> permissions =
      <ConsumerPermission, AbstractRoute>{};

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();

    if (widget.qsParam.isNotEmpty) {
      _qsParam.addAll(widget.qsParam);
    }

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        if (!_loading && _page >= 0) {
          _loadData(context, clear: false);
        }
      }
    });

    _loadPermissions(context);
  }

  ///
  ///
  ///
  Future<void> _loadPermissions(BuildContext context) async {
    if (widget.actionFunctions != null) {
      for (MapEntry<AbstractRoute, ActionFunction<T>> entry
          in widget.actionFunctions!.entries) {
        AbstractRoute route = entry.key;

        ConsumerPermission permission =
            await widget.consumer.checkPermission(context, route.routeName);

        if (permission.view) permissions[permission] = route;
      }
    }

    await _loadData(context);
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

      // // ignore: unawaited_futures
      // Future<dynamic>.delayed(Duration(milliseconds: 200)).then((_) {
      //   _scrollController.animateTo(
      //     _scrollController.position.maxScrollExtent,
      //     curve: Curves.easeOut,
      //     duration: const Duration(milliseconds: 300),
      //   );
      // });
    }

    try {
      if (!widget.selection) {
        ConsumerPermission permission =
            await widget.consumer.checkPermission(context, <String>[]);

        _insert = permission.insert && widget.onAdd != null;
        _update = permission.update && widget.onUpdate != null;
        _delete = permission.delete;
      }

      _qsParam['f'] = '${_page * widget.itemsPerPage}';
      _qsParam['q'] = '${widget.itemsPerPage}';
      _qsParam['s'] = '${widget.selection}';

      List<T> result = await widget.consumer.list(
        context,
        _qsParam,
        widget.forceOffline,
      );

      if (result.isEmpty) {
        _page = -1;
      } else {
        _page++;
        _globalItems.addAll(result);
      }

      _streamController.add(true);
      _loading = false;
    } catch (e, s) {
      if (FollyFields().isDebug) {
        // ignore: avoid_print
        print('$e\n$s');
      }
      _streamController.addError(e, s);
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
    return StreamBuilder<bool?>(
      stream: _streamController.stream,
      builder: (BuildContext context, AsyncSnapshot<bool?> snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: _getScaffoldTitle(),
            ),
            bottomNavigationBar:
                widget.uiBuilder.buildBottomNavigationBar(context),
            body: widget.uiBuilder.buildBackgroundContainer(
              context,
              Column(
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
          if (!snapshot.data!) {
            itemCount++;
          }

          Widget? _fabAdd;

          List<Widget> _actions = <Widget>[];

          /// Botão Selecionar Todos
          if (widget.selection == true &&
              widget.multipleSelection == true &&
              widget.invertSelection == true) {
            _actions.add(
              IconButton(
                tooltip: 'Inverter seleção',
                icon: const Icon(Icons.select_all),
                onPressed: () {
                  for (T model in _globalItems) {
                    if (selections.containsKey(model.id)) {
                      selections.remove(model.id);
                    } else {
                      selections[model.id!] = model;
                    }
                  }
                  setState(() {});
                },
              ),
            );
          }

          /// Botão Pesquisar
          if (FollyFields().isOnline) {
            _actions.add(
              IconButton(
                tooltip: 'Pesquisar ${widget.uiBuilder.getSuperSingle()}',
                icon: const Icon(Icons.search),
                onPressed: () {
                  showSearch<T?>(
                    context: context,
                    delegate: InternalSearch<T, UI, C>(
                      buildResultItem: _buildResultItem,
                      canDelete: (T model) =>
                          _delete &&
                          FollyFields().isWeb &&
                          widget.canDelete(model),
                      qsParam: widget.qsParam,
                      forceOffline: widget.forceOffline,
                      itemsPerPage: widget.itemsPerPage,
                      uiBuilder: widget.uiBuilder,
                      consumer: widget.consumer,
                      searchFieldLabel: widget.searchFieldLabel,
                      searchFieldStyle: widget.searchFieldStyle,
                      searchFieldDecorationTheme:
                          widget.searchFieldDecorationTheme,
                      keyboardType: widget.searchKeyboardType,
                      textInputAction: widget.searchTextInputAction,
                    ),
                  ).then((T? entity) {
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
          }

          /// Botão Confirmar Seleção
          if (widget.selection) {
            if (widget.multipleSelection) {
              _actions.add(
                IconButton(
                  tooltip: 'Selecionar ${widget.uiBuilder.getSuperPlural()}',
                  icon: const FaIcon(FontAwesomeIcons.check),
                  onPressed: () => Navigator.of(context)
                      .pop(List<T>.from(selections.values)),
                ),
              );
            }
          } else {
            /// Action Routes
            for (AbstractRoute route in widget.actionRoutes) {
              _actions.add(
                // TODO - Create an Action Route component.
                FutureBuilder<ConsumerPermission>(
                  future: widget.consumer.checkPermission(
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
                              icon: IconHelper.faIcon(permission.iconName),
                              onPressed: () =>
                                  Navigator.of(context).pushNamed(route.path),
                            )
                          : const SizedBox(width: 0, height: 0);
                    }

                    return const SizedBox(width: 0, height: 0);
                  },
                ),
              );
            }

            /// Botão Adicionar
            if (_insert) {
              if (FollyFields().isWeb) {
                _actions.add(
                  IconButton(
                    tooltip: 'Adicionar ${widget.uiBuilder.getSuperSingle()}',
                    icon: const FaIcon(FontAwesomeIcons.plus),
                    onPressed: _addEntity,
                  ),
                );
              } else {
                _fabAdd = FloatingActionButton(
                  tooltip: 'Adicionar ${widget.uiBuilder.getSuperSingle()}',
                  onPressed: _addEntity,
                  child: const FaIcon(FontAwesomeIcons.plus),
                );
              }
            }
          }

          return Scaffold(
            appBar: AppBar(
              title: _getScaffoldTitle(),
              actions: _actions,
            ),
            bottomNavigationBar:
                widget.uiBuilder.buildBottomNavigationBar(context),
            body: widget.uiBuilder.buildBackgroundContainer(
              context,
              RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: () => _loadData(context),
                child: _globalItems.isEmpty
                    ? TextMessage(
                        'Sem '
                        '${widget.uiBuilder.getSuperPlural().toLowerCase()}'
                        ' até o momento.',
                      )
                    : Scrollbar(
                        controller: _scrollController,
                        isAlwaysShown: FollyFields().isWeb,
                        child: ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(16.0),
                          controller: _scrollController,
                          itemBuilder: (BuildContext context, int index) {
                            /// Atualizando...
                            if (index >= _globalItems.length) {
                              return const SizedBox(
                                height: 80,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }

                            T model = _globalItems[index];

                            if (_delete &&
                                FollyFields().isMobile &&
                                widget.canDelete(model)) {
                              return Dismissible(
                                key: Key('key_${model.id}'),
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  color: Colors.red,
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.only(right: 16.0),
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
                                    FollyFields().isWeb &&
                                    widget.canDelete(model),
                                onTap: null,
                              );
                            }
                          },
                          separatorBuilder: (_, __) => const FollyDivider(),
                          itemCount: itemCount,
                        ),
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
          bottomNavigationBar:
              widget.uiBuilder.buildBottomNavigationBar(context),
          body: widget.uiBuilder.buildBackgroundContainer(
            context,
            const WaitingMessage(message: 'Consultando...'),
          ),
        );
      },
    );
  }

  ///
  ///
  ///
  Widget _buildResultItem({
    required T model,
    required bool selection,
    required bool canDelete,
    Future<void> Function()? afterDeleteRefresh,
    Function? onTap,
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
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ...permissions.entries.map(
            (MapEntry<ConsumerPermission, AbstractRoute> entry) {
              ConsumerPermission permission = entry.key;
              ActionFunction<T> actionFunction =
                  widget.actionFunctions![entry.value]!;
              // TODO - Create an Action Route component.
              return FutureBuilder<bool>(
                initialData: false,
                future: actionFunction.showButton(context, model),
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.hasData && snapshot.data!) {
                    return IconButton(
                      tooltip: permission.name,
                      icon: IconHelper.faIcon(permission.iconName),
                      onPressed: () async {
                        Widget widget =
                            await actionFunction.onPressed(context, model);

                        await Navigator.of(context).push(
                          MaterialPageRoute<dynamic>(builder: (_) => widget),
                        );

                        await _loadData(context, clear: true);
                      },
                    );
                  }
                  return const SizedBox(width: 0, height: 0);
                },
              );
            },
          ),
          if (canDelete)
            IconButton(
              icon: const Icon(FontAwesomeIcons.trashAlt),
              onPressed: () async {
                bool refresh = await _deleteEntity(model, ask: true);
                if (afterDeleteRefresh != null && refresh) {
                  await afterDeleteRefresh();
                }
              },
            ),
        ],
      ),
      onTap: onTap != null
          ? () => onTap(model)
          : () => _internalRoute(model, !selection),
      onLongPress:
          widget.onLongPress == null ? null : () => _internalLongPress(model),
    );
  }

  ///
  ///
  ///
  void _internalLongPress(T model) async => _push(await widget.onLongPress!(
        context,
        model,
        widget.uiBuilder,
        widget.consumer,
        _update,
      ));

  ///
  ///
  ///
  void _addEntity() async => _push(await widget.onAdd!(
        context,
        widget.uiBuilder,
        widget.consumer,
      ));

  ///
  ///
  ///
  void _internalRoute(T model, bool selected) async {
    if (widget.selection) {
      if (widget.multipleSelection) {
        if (selected) {
          selections[model.id!] = model;
        } else {
          selections.remove(model.id);
        }
        if (mounted) {
          setState(() {});
        }
      } else {
        Navigator.of(context).pop(model);
      }
    } else {
      Widget? next = await widget.onUpdate!(
        context,
        model,
        widget.uiBuilder,
        widget.consumer,
        _update,
      );

      _push(next);
    }
  }

  ///
  ///
  ///
  void _push(Widget? widget, [bool clear = true]) async {
    if (widget != null) {
      await Navigator.of(context).push(
        MaterialPageRoute<T>(builder: (_) => widget),
      );

      await _loadData(context, clear: clear);
    }
  }

  ///
  ///
  ///
  Future<bool> _deleteEntity(T model, {bool ask = false}) async {
    // FIXME - Possível bug em erros na web.
    CircularWaiting wait = CircularWaiting(context);
    try {
      bool del = true;

      if (ask) {
        del = await _askDelete();
      }

      if (del) {
        del = await widget.consumer.beforeDelete(context, model);
      }

      if (del) {
        wait.show();
        await widget.consumer.delete(context, model);
        wait.close();

        if (ask) {
          await _loadData(context);
        }

        return ask;
      }
    } catch (e, s) {
      wait.close();

      if (FollyFields().isDebug) {
        // ignore: avoid_print
        print('$e\n$s');
      }

      await FollyDialogs.dialogMessage(
        context: context,
        message: 'Ocorreu um erro ao tentar excluir:\n$e',
      );
    }
    return !ask;
  }

  ///
  ///
  ///
  Future<bool> _askDelete() => FollyDialogs.yesNoDialog(
        context: context,
        title: 'Atenção',
        message: 'Deseja excluir?',
      );
}

///
///
///
class InternalSearch<
    W extends AbstractModel<Object>,
    UI extends AbstractUIBuilder<W>,
    C extends AbstractConsumer<W>> extends SearchDelegate<W?> {
  final UI uiBuilder;
  final C consumer;

  final Widget Function({
    required W model,
    required bool selection,
    required bool canDelete,
    Future<void> Function()? afterDeleteRefresh,
    Function(W model)? onTap,
  }) buildResultItem;

  final bool Function(W) canDelete;
  final Map<String, String> qsParam;
  final bool forceOffline;
  final int itemsPerPage;

  String? _lastQuery;
  Widget? _lastWidget;

  ///
  ///
  ///
  InternalSearch({
    required this.uiBuilder,
    required this.consumer,
    required this.buildResultItem,
    required this.canDelete,
    required this.qsParam,
    required this.forceOffline,
    required this.itemsPerPage,
    required String? searchFieldLabel,
    required TextStyle? searchFieldStyle,
    required InputDecorationTheme? searchFieldDecorationTheme,
    required TextInputType? keyboardType,
    required TextInputAction textInputAction,
  }) : super(
          searchFieldLabel: searchFieldLabel,
          searchFieldStyle: searchFieldStyle,
          searchFieldDecorationTheme: searchFieldDecorationTheme,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
        );

  ///
  ///
  ///
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = super.appBarTheme(context);

    return theme.copyWith(
      appBarTheme: theme.appBarTheme.copyWith(
        backgroundColor: theme.colorScheme.surface,
      ),
    );
  }

  ///
  ///
  ///
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.clear),
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
      icon: const Icon(Icons.arrow_back),
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
      return Column(
        children: <Widget>[
          Expanded(
            child: uiBuilder.buildBackgroundContainer(
              context,
              const Center(
                child: Text(
                  'Começe a sua pesquisa.\n'
                  'Digite ao menos 3 caracteres.',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          uiBuilder.buildBottomNavigationBar(context),
        ],
      );
    } else {
      Map<String, String> param = <String, String>{};

      if (qsParam.isNotEmpty) {
        param.addAll(qsParam);
      }

      if (query.contains('%')) {
        query = query.replaceAll('%', '');
      }

      param['t'] = query.toLowerCase();

      return Column(
        children: <Widget>[
          Expanded(
            child: uiBuilder.buildBackgroundContainer(
              context,
              FutureBuilder<List<W>>(
                future: consumer.list(context, param, forceOffline),
                builder:
                    (BuildContext context, AsyncSnapshot<List<W>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) {
                      return ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16.0),
                        itemBuilder: (BuildContext context, int index) {
                          return buildResultItem(
                            model: snapshot.data![index],
                            selection: false,
                            canDelete: canDelete(snapshot.data![index]),
                            onTap: (W entity) => close(context, entity),
                            afterDeleteRefresh: () async => query += '%',
                          );
                        },
                        separatorBuilder: (_, __) => const FollyDivider(),
                        itemCount: snapshot.data!.length,
                      );
                    } else {
                      return const Center(
                        child: Text('Nenhum documento.'),
                      );
                    }
                  }

                  // TODO - Tratar erro.

                  return const WaitingMessage(message: 'Consultando...');
                },
              ),
            ),
          ),
          uiBuilder.buildBottomNavigationBar(context),
        ],
      );
    }
  }

  ///
  ///
  ///
  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length < 3) {
      return Column(
        children: <Widget>[
          Expanded(
            child: uiBuilder.buildBackgroundContainer(
              context,
              const Center(
                child: Text(
                  'Começe a sua pesquisa.\n'
                  'Digite ao menos 3 caracteres.',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          uiBuilder.buildBottomNavigationBar(context),
        ],
      );
    } else {
      if (_lastQuery == query && _lastWidget != null) {
        return _lastWidget!;
      } else {
        Map<String, String> param = <String, String>{};

        _lastQuery = query;

        if (qsParam.isNotEmpty) {
          param.addAll(qsParam);
        }

        param['t'] = query.replaceAll('%', '').toLowerCase();

        param['q'] = itemsPerPage.toString();

        _lastWidget = Column(
          children: <Widget>[
            Expanded(
              child: uiBuilder.buildBackgroundContainer(
                context,
                FutureBuilder<List<W>>(
                  future: consumer.list(context, param, forceOffline),
                  builder:
                      (BuildContext context, AsyncSnapshot<List<W>> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isNotEmpty) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Sugestões:',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemBuilder: (BuildContext context, int index) {
                                  W model = snapshot.data![index];

                                  return ListTile(
                                    title: uiBuilder.getSuggestionTitle(model),
                                    subtitle:
                                        uiBuilder.getSuggestionSubtitle(model),
                                    onTap: () {
                                      _lastQuery = model.searchTerm;
                                      query = _lastQuery!;
                                      showResults(context);
                                    },
                                  );
                                },
                                itemCount: snapshot.data!.length,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const Center(
                          child: Text('Nenhum documento.'),
                        );
                      }
                    }

                    // TODO - Tratar erro.

                    return const WaitingMessage(message: 'Consultando...');
                  },
                ),
              ),
            ),
            uiBuilder.buildBottomNavigationBar(context),
          ],
        );

        return _lastWidget!;
      }
    }
  }
}
