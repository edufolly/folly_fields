import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_builder.dart';
import 'package:folly_fields/crud/abstract_consumer.dart';
import 'package:folly_fields/crud/abstract_model.dart';
import 'package:folly_fields/crud/abstract_route.dart';
import 'package:folly_fields/folly_fields.dart';
import 'package:folly_fields/util/safe_builder.dart';
import 'package:folly_fields/widgets/circular_waiting.dart';
import 'package:folly_fields/widgets/folly_dialogs.dart';
import 'package:folly_fields/widgets/folly_divider.dart';
import 'package:folly_fields/widgets/text_message.dart';
import 'package:folly_fields/widgets/waiting_message.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sprintf/sprintf.dart';

///
///
///
abstract class AbstractList<
    T extends AbstractModel<ID>,
    B extends AbstractBuilder<T, ID>,
    C extends AbstractConsumer<T, ID>,
    ID> extends AbstractRoute {
  final bool selection;
  final bool multipleSelection;
  final bool invertSelection;
  final bool forceOffline;
  final C consumer;
  final B builder;
  final Future<Widget?> Function(
    BuildContext context,
    B builder,
    C consumer,
  )? onAdd;
  final Future<Widget?> Function(
    BuildContext context,
    T model,
    B builder,
    C consumer, {
    required bool edit,
  })? onUpdate;
  final Map<String, String> qsParam;
  final int itemsPerPage;
  final int qtdSuggestions;
  final Future<Widget?> Function(
    BuildContext context,
    T model,
    B builder,
    C consumer, {
    required bool edit,
  })? onLongPress;
  final String? searchFieldLabel;
  final TextStyle? searchFieldStyle;
  final InputDecorationTheme? searchFieldDecorationTheme;
  final TextInputType? searchKeyboardType;
  final TextInputAction searchTextInputAction;
  final IconData selectedIcon;
  final IconData unselectedIcon;
  final int minLengthToSearch;
  final String hintText;
  final String selectionText;
  final String startSearchText;
  final String deleteText;
  final String invertSelectionText;
  final String waitingText;
  final String deleteErrorText;
  final String searchListEmpty;
  final String addText;
  final bool showSearchButton;
  final String searchButtonText;
  final String listEmpty;
  final bool showRefreshButton;
  final String refreshButtonText;
  final Widget? Function(BuildContext context)? appBarLeading;
  final List<Widget> Function(
    BuildContext context,
    B builder,
    C consumer,
    Map<String, String> qsParam, {
    required bool selection,
  })? actions;
  final List<Widget> Function(
    BuildContext context,
    T model,
    B builder,
    C consumer,
    Map<String, String> qsParam,
    void Function({bool clear})? refresh, {
    required bool selection,
  })? rowActions;
  final double? leadingWidth;

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
    required this.selection,
    required this.multipleSelection,
    required this.consumer,
    required this.builder,
    this.invertSelection = false,
    this.forceOffline = false,
    this.onAdd,
    this.onUpdate,
    this.qsParam = const <String, String>{},
    this.itemsPerPage = 50,
    this.qtdSuggestions = 15,
    this.onLongPress,
    this.searchFieldLabel,
    this.searchFieldStyle,
    this.searchFieldDecorationTheme,
    this.searchKeyboardType,
    this.searchTextInputAction = TextInputAction.search,
    this.selectedIcon = FontAwesomeIcons.solidCircleCheck,
    this.unselectedIcon = FontAwesomeIcons.circle,
    this.minLengthToSearch = 3,
    this.hintText = 'Sugestões:',
    this.selectionText = 'Selecionar %s',
    this.startSearchText = 'Começe a sua pesquisa.\n'
        'Digite ao menos %s caracteres.',
    this.deleteText = 'Deseja excluir?',
    this.invertSelectionText = 'Inverter seleção',
    this.waitingText = 'Consultando...',
    this.deleteErrorText = 'Ocorreu um erro ao tentar excluir:\n%s',
    this.searchListEmpty = 'Nenhum documento.',
    this.addText = 'Adicionar %s',
    this.showSearchButton = true,
    this.searchButtonText = 'Pesquisar %s',
    this.listEmpty = 'Sem %s até o momento.',
    this.showRefreshButton = false,
    this.refreshButtonText = 'Atualizar',
    this.appBarLeading,
    this.actions,
    this.rowActions,
    this.leadingWidth,
    super.key,
  }) : assert(
          searchFieldStyle == null || searchFieldDecorationTheme == null,
          'searchFieldStyle or searchFieldDecorationTheme must be null.',
        );

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
  Future<void> onDeleteError(
    BuildContext context,
    T model,
    Exception e,
    StackTrace s,
  ) async {
    await FollyDialogs.dialogMessage(
      context: context,
      message: sprintf(deleteErrorText, <dynamic>[e.toString()]),
    );
  }

  ///
  ///
  ///
  @override
  AbstractListState<T, B, C, ID> createState() =>
      AbstractListState<T, B, C, ID>();
}

///
///
///
class AbstractListState<
    T extends AbstractModel<ID>,
    UI extends AbstractBuilder<T, ID>,
    C extends AbstractConsumer<T, ID>,
    ID> extends State<AbstractList<T, UI, C, ID>> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  final ScrollController _scrollController = ScrollController();
  final StreamController<AbstractListStateEnum> _streamController =
      StreamController<AbstractListStateEnum>();

  final ValueNotifier<bool> _insertNotifier = ValueNotifier<bool>(false);

  List<T> _globalItems = <T>[];
  bool _loading = false;
  int _page = 0;

  bool _update = false;
  bool _delete = false;
  bool _initiallyFilled = false;

  final Map<Object, T> _selections = <Object, T>{};

  final Map<String, String> _qsParam = <String, String>{};
  final List<String> _qsKeys = <String>[];

  FocusNode keyboardFocusNode = FocusNode();

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();

    if (widget.qsParam.isNotEmpty) {
      _qsParam.addAll(widget.qsParam);
      _qsKeys.addAll(widget.qsParam.keys);
    }

    _qsKeys.addAll(<String>['s']);
  }

  ///
  ///
  ///
  Future<bool> _loadPermissions(BuildContext context) async {
    if (!widget.selection) {
      ConsumerPermission permission =
          await widget.consumer.checkPermission(context, <String>[]);

      _insertNotifier.value = permission.insert && widget.onAdd != null;
      _update = permission.update && widget.onUpdate != null;
      _delete = permission.delete;
    }

    _scrollController.addListener(() {
      if (_scrollController.position.hasContentDimensions &&
          _scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent) {
        if (!_loading && _page >= 0) {
          _loadData(context, clear: false);
        }
      }
    });

    await _loadData(context);

    return true;
  }

  ///
  ///
  ///
  /// Returns the amount of fetched items.
  Future<int> _loadData(
    BuildContext context, {
    bool clear = true,
  }) async {
    if (clear) {
      _globalItems = <T>[];
      _page = 0;
      _streamController.add(AbstractListStateEnum.loadingMessage);
    } else {
      _loading = true;
      _streamController.add(AbstractListStateEnum.incrementalLoading);
    }

    try {
      _qsParam['s'] = '${widget.selection}';

      List<T> result = await widget.consumer.list(
        context,
        page: _page,
        size: widget.itemsPerPage,
        extraParams: _qsParam,
        forceOffline: widget.forceOffline,
      );

      if (result.isEmpty) {
        _streamController.add(AbstractListStateEnum.finishLoading);
      } else {
        _page++;
        _globalItems.addAll(result);
      }

      _streamController.add(AbstractListStateEnum.finishLoading);
      _loading = false;

      return result.length;
    } on Exception catch (e, s) {
      if (kDebugMode) {
        print('$e\n$s');
      }
      _streamController.addError(e, s);

      return 0;
    }
  }

  ///
  ///
  ///
  Widget _getScaffoldTitle(BuildContext context) => Text(
        widget.selection
            ? sprintf(
                widget.selectionText,
                <dynamic>[widget.builder.superSingle(context)],
              )
            : widget.builder.superPlural(context),
      );

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
        leadingWidth: widget.leadingWidth,
        title: _getScaffoldTitle(context),
        actions: <Widget>[
          /// Select All Button
          if (widget.selection &&
              widget.multipleSelection &&
              widget.invertSelection)
            IconButton(
              tooltip: widget.invertSelectionText,
              icon: const Icon(Icons.select_all),
              onPressed: () {
                for (final T model in _globalItems) {
                  if (_selections.containsKey(model.id)) {
                    _selections.remove(model.id);
                  } else {
                    _selections[model.id!] = model;
                  }
                }
                _streamController.add(AbstractListStateEnum.finishLoading);
              },
            ),

          /// Search Button
          if (widget.showSearchButton)
            IconButton(
              tooltip: sprintf(
                widget.searchButtonText,
                <dynamic>[widget.builder.superSingle(context)],
              ),
              icon: const Icon(Icons.search),
              onPressed: _search,
            ),

          /// Refresh Button
          if (widget.showRefreshButton)
            IconButton(
              tooltip: widget.refreshButtonText,
              icon: const Icon(FontAwesomeIcons.arrowsRotate),
              onPressed: () => _loadData(context),
            ),

          /// Selection Confirm Button
          if (widget.selection && widget.multipleSelection)
            IconButton(
              tooltip: sprintf(
                widget.selectionText,
                <dynamic>[widget.builder.superPlural(context)],
              ),
              icon: const FaIcon(FontAwesomeIcons.check),
              onPressed: () =>
                  Navigator.of(context).pop(List<T>.of(_selections.values)),
            ),

          /// Actions
          if (!widget.selection && widget.actions != null)
            ...widget.actions!(
              context,
              widget.builder,
              widget.consumer,
              _qsParam,
              selection: widget.selection,
            ),

          /// Add Button
          if (!FollyFields().isMobile && !widget.selection)
            ValueListenableBuilder<bool>(
              valueListenable: _insertNotifier,
              builder: (BuildContext context, bool insert, _) {
                return insert
                    ? IconButton(
                        tooltip: sprintf(
                          widget.addText,
                          <dynamic>[widget.builder.superSingle(context)],
                        ),
                        icon: const FaIcon(FontAwesomeIcons.plus),
                        onPressed: _addEntity,
                      )
                    : const SizedBox.shrink();
              },
            ),

          /// Legend Button
          if (!widget.selection &&
              widget.builder.listLegend(context).isNotEmpty)
            IconButton(
              tooltip: widget.builder.listLegendTitle(context),
              icon: FaIcon(widget.builder.listLegendIcon(context)),
              onPressed: _showListLegend,
            ),
        ],
      ),
      floatingActionButton: FollyFields().isMobile && !widget.selection
          ? ValueListenableBuilder<bool>(
              valueListenable: _insertNotifier,
              builder: (BuildContext context, bool insert, _) {
                return insert
                    ? FloatingActionButton(
                        tooltip: sprintf(
                          widget.addText,
                          <dynamic>[widget.builder.superSingle(context)],
                        ),
                        onPressed: _addEntity,
                        child: const FaIcon(FontAwesomeIcons.plus),
                      )
                    : const SizedBox.shrink();
              },
            )
          : null,
      bottomNavigationBar: widget.builder.buildBottomNavigationBar(context),
      body: widget.builder.buildListBody(
        context,
        SafeFutureBuilder<bool>(
          future: _loadPermissions(context),
          waitingMessage: widget.waitingText,
          builder: (BuildContext context, bool value, _) {
            return SafeStreamBuilder<AbstractListStateEnum>(
              stream: _streamController.stream,
              waitingMessage: widget.waitingText,
              builder: (BuildContext context, AbstractListStateEnum event, _) {
                if (event == AbstractListStateEnum.loadingMessage) {
                  return WaitingMessage(message: widget.waitingText);
                }

                /// CircularProgressIndicator will be at the list bottom,
                /// so we make space here with an extra index if
                /// event is incrementalLoading
                int itemCount = _globalItems.length;
                if (event == AbstractListStateEnum.incrementalLoading) {
                  itemCount++;
                }

                /// If this is the first 'finishLoading' event and the
                /// scrollbar hasn't even appeared yet, we won't be able to
                /// scroll further.
                /// This callback will be called after building this widget.
                if (event == AbstractListStateEnum.finishLoading &&
                    !_initiallyFilled) {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) async {
                      if (_scrollController.positions.isNotEmpty &&
                          _scrollController.position.hasContentDimensions &&
                          _scrollController.position.maxScrollExtent == 0) {
                        int extraAmount =
                            await _loadData(context, clear: false);
                        if (extraAmount == 0) {
                          // This flags that we won't try further '_loadData'
                          // calls
                          _initiallyFilled = true;
                        }
                      }
                    },
                  );
                }

                return RefreshIndicator(
                  key: _refreshIndicatorKey,
                  onRefresh: () => _loadData(context),
                  child: _globalItems.isEmpty
                      ? TextMessage(
                          sprintf(
                            widget.listEmpty,
                            <dynamic>[
                              widget.builder.superPlural(context).toLowerCase(),
                            ],
                          ),
                        )
                      : KeyboardListener(
                          autofocus: true,
                          focusNode: keyboardFocusNode,
                          onKeyEvent: (KeyEvent event) {
                            if (widget.showSearchButton &&
                                event.character != null) {
                              _search(event.character);
                            }
                          },
                          child: Scrollbar(
                            controller: _scrollController,
                            // isAlwaysShown: FollyFields().isWeb,
                            thumbVisibility: true,
                            child: ListView.separated(
                              physics: const AlwaysScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(16),
                              controller: _scrollController,
                              itemBuilder: (BuildContext context, int index) {
                                /// Updating...
                                if (index >= _globalItems.length) {
                                  return const SizedBox(
                                    height: 80,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }

                                T model = _globalItems[index];

                                return _delete &&
                                        FollyFields().isMobile &&
                                        widget.canDelete(model)
                                    ? Dismissible(
                                        key: Key('key_${model.id}'),
                                        direction: DismissDirection.endToStart,
                                        background: Container(
                                          color: Colors.red,
                                          alignment: Alignment.centerRight,
                                          padding: const EdgeInsets.only(
                                            right: 16,
                                          ),
                                          child: const FaIcon(
                                            FontAwesomeIcons.trashCan,
                                            color: Colors.white,
                                          ),
                                        ),
                                        confirmDismiss:
                                            (DismissDirection direction) =>
                                                _askDelete(),
                                        onDismissed:
                                            (DismissDirection direction) =>
                                                _deleteEntity(model),
                                        child: _buildResultItem(
                                          model: model,
                                          selected:
                                              _selections.containsKey(model.id),
                                          canDelete: false,
                                        ),
                                      )
                                    : _buildResultItem(
                                        model: model,
                                        selected:
                                            _selections.containsKey(model.id),
                                        canDelete: _delete &&
                                            FollyFields().isNotMobile &&
                                            widget.canDelete(model),
                                      );
                              },
                              separatorBuilder: (_, _) => const FollyDivider(),
                              itemCount: itemCount,
                            ),
                          ),
                        ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  ///
  ///
  ///
  void _search([String? query]) {
    showSearch<T?>(
      context: context,
      query: query,
      delegate: InternalSearch<T, UI, C, ID>(
        buildResultItem: _buildResultItem,
        canDelete: (T model) =>
            _delete && FollyFields().isNotMobile && widget.canDelete(model),
        extraParams: widget.qsParam,
        forceOffline: widget.forceOffline,
        itemsPerPage: widget.itemsPerPage,
        builder: widget.builder,
        consumer: widget.consumer,
        searchFieldLabel: widget.searchFieldLabel,
        searchFieldStyle: widget.searchFieldStyle,
        searchFieldDecorationTheme: widget.searchFieldDecorationTheme,
        keyboardType: widget.searchKeyboardType,
        textInputAction: widget.searchTextInputAction,
        minLengthToSearch: widget.minLengthToSearch,
        hintText: widget.hintText,
        startSearchText: widget.startSearchText,
        waitingText: widget.waitingText,
        searchListEmpty: widget.searchListEmpty,
      ),
    ).then(
      (T? entity) {
        if (entity != null) {
          _internalRoute(
            model: entity,
            selected: _selections.containsKey(entity.id),
          );
        }
      },
    );
  }

  ///
  ///
  ///
  Widget _buildResultItem({
    required T model,
    required bool selected,
    required bool canDelete,
    Future<void> Function()? afterDeleteRefresh,
    Function(T model)? onTap,
  }) {
    Widget? leading = widget.builder.getLeading(context, model);
    bool multipleSelection = widget.multipleSelection && onTap == null;

    return ListTile(
      leading: (leading != null || multipleSelection)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (multipleSelection)
                  FaIcon(selected ? widget.selectedIcon : widget.unselectedIcon)
                else
                  leading!,
              ],
            )
          : null,
      title: widget.builder.getTitle(context, model),
      subtitle: widget.builder.getSubtitle(context, model),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          /// Row Actions
          if (widget.rowActions != null)
            ...widget.rowActions!(
              context,
              model,
              widget.builder,
              widget.consumer,
              _qsParam,
              ({bool clear = true}) => _loadData(context, clear: clear),
              selection: widget.selection,
            ),

          /// Delete Button
          if (canDelete)
            IconButton(
              icon: const Icon(FontAwesomeIcons.trashCan),
              onPressed: () async {
                bool refresh = await _deleteEntity(model, ask: true);
                if (afterDeleteRefresh != null && refresh) {
                  await afterDeleteRefresh();
                }
              },
            ),
        ],
      ),
      onTap: onTap != null && !widget.selection
          ? () => onTap(model)
          : () => _internalRoute(model: model, selected: selected),
      onLongPress:
          widget.onLongPress == null ? null : () => _internalLongPress(model),
    );
  }

  ///
  ///
  ///
  Future<void> _internalLongPress(T model) async => _push(
        await widget.onLongPress?.call(
          context,
          model,
          widget.builder,
          widget.consumer,
          edit: _update,
        ),
      );

  ///
  ///
  ///
  Future<void> _addEntity() async => _push(
        await widget.onAdd?.call(
          context,
          widget.builder,
          widget.consumer,
        ),
      );

  ///
  ///
  ///
  Future<void> _internalRoute({
    required T model,
    required bool selected,
  }) async {
    if (widget.selection) {
      if (widget.multipleSelection) {
        if (selected) {
          _selections.remove(model.id);
        } else {
          _selections[model.id!] = model;
        }
        _streamController.add(AbstractListStateEnum.finishLoading);
      } else {
        Navigator.of(context).pop(model);
      }
    } else {
      Widget? next = await widget.onUpdate?.call(
        context,
        model,
        widget.builder,
        widget.consumer,
        edit: _update,
      );

      await _push(next);
    }
  }

  ///
  ///
  ///
  Future<void> _push(Widget? widget, [bool clear = true]) async {
    if (widget != null) {
      await Navigator.of(context).push(
        MaterialPageRoute<dynamic>(builder: (_) => widget),
      );

      if (mounted) {
        await _loadData(context, clear: clear);
      }
    }
  }

  ///
  ///
  ///
  Future<bool> _deleteEntity(T model, {bool ask = false}) async {
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
    } on Exception catch (e, s) {
      wait.close();

      if (kDebugMode) {
        print('$e\n$s');
      }

      await widget.onDeleteError(context, model, e, s);
    }

    return !ask;
  }

  ///
  ///
  ///
  Future<bool> _askDelete() => FollyDialogs.yesNoDialog(
        context: context,
        message: widget.deleteText,
      );

  ///
  ///
  ///
  void _showListLegend() {
    Map<String, Color> listLegend = widget.builder.listLegend(context);
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Row(
          children: <Widget>[
            FaIcon(widget.builder.listLegendIcon(context)),
            const SizedBox(
              width: 8,
            ),
            Text(widget.builder.listLegendTitle(context)),
          ],
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: listLegend.keys
                .map(
                  (String key) => ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.solidCircle,
                      color: listLegend[key],
                    ),
                    title: Text(key),
                  ),
                )
                .toList(),
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(widget.builder.listLegendButtonText(context)),
          ),
        ],
      ),
    );
  }

  ///
  ///
  ///
  @override
  void dispose() {
    keyboardFocusNode.dispose();
    _insertNotifier.dispose();
    _streamController.close();
    _scrollController.dispose();
    super.dispose();
  }
}

///
///
///
enum AbstractListStateEnum {
  finishLoading, // Gotta show only current list items
  loadingMessage, // Gotta show only a waiting message
  incrementalLoading, // Gotta show list items and a loading indicator at bottom
}

///
///
///
class InternalSearch<
    W extends AbstractModel<ID>,
    UI extends AbstractBuilder<W, ID>,
    C extends AbstractConsumer<W, ID>,
    ID> extends SearchDelegate<W?> {
  final UI builder;
  final C consumer;

  final Widget Function({
    required W model,
    required bool selected,
    required bool canDelete,
    Future<void> Function()? afterDeleteRefresh,
    Function(W model)? onTap,
  }) buildResultItem;

  final bool Function(W) canDelete;
  final Map<String, String> extraParams;
  final bool forceOffline;
  final int itemsPerPage;
  final int minLengthToSearch;
  final String hintText;
  final String startSearchText;
  final String waitingText;
  final String searchListEmpty;

  String? _lastQuery;
  Widget? _lastWidget;

  ///
  ///
  ///
  InternalSearch({
    required this.builder,
    required this.consumer,
    required this.buildResultItem,
    required this.canDelete,
    required this.extraParams,
    required this.forceOffline,
    required this.itemsPerPage,
    required this.minLengthToSearch,
    required this.hintText,
    required this.startSearchText,
    required this.waitingText,
    required this.searchListEmpty,
    required super.searchFieldLabel,
    required super.searchFieldStyle,
    required super.searchFieldDecorationTheme,
    required super.keyboardType,
    required super.textInputAction,
  });

  ///
  ///
  ///
  @override
  ThemeData appBarTheme(BuildContext context) {
    ThemeData theme = super.appBarTheme(context);

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
      onPressed: () => close(context, null),
    );
  }

  ///
  ///
  ///
  @override
  Widget buildResults(BuildContext context) {
    if (query.length < minLengthToSearch) {
      return Column(
        children: <Widget>[
          Expanded(
            child: builder.buildSearchBody(
              context,
              Center(
                child: Text(
                  sprintf(startSearchText, <dynamic>[minLengthToSearch]),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          builder.buildBottomNavigationBar(context) ?? const SizedBox.shrink(),
        ],
      );
    } else {
      Map<String, String> newParams = <String, String>{};

      if (extraParams.isNotEmpty) {
        newParams.addAll(extraParams);
      }

      if (query.contains('%')) {
        query = query.replaceAll('%', '');
      }

      newParams['t'] = query;

      return Column(
        children: <Widget>[
          Expanded(
            child: builder.buildSearchBody(
              context,
              SafeFutureBuilder<List<W>>(
                future: consumer.list(
                  context,
                  // TODO(edufolly): Page implementation.
                  size: itemsPerPage,
                  extraParams: newParams,
                  forceOffline: forceOffline,
                ),
                waitingMessage: waitingText,
                builder: (BuildContext context, List<W> data, _) =>
                    data.isNotEmpty
                        ? ListView.separated(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(16),
                            itemBuilder: (BuildContext context, int index) =>
                                buildResultItem(
                              model: data[index],
                              selected: false,
                              canDelete: canDelete(data[index]),
                              onTap: (W entity) => close(context, entity),
                              afterDeleteRefresh: () async => query += '%',
                            ),
                            separatorBuilder: (_, _) => const FollyDivider(),
                            itemCount: data.length,
                          )
                        : Center(child: Text(searchListEmpty)),
              ),
            ),
          ),
          builder.buildBottomNavigationBar(context) ?? const SizedBox.shrink(),
        ],
      );
    }
  }

  ///
  ///
  ///
  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length < minLengthToSearch) {
      return Column(
        children: <Widget>[
          Expanded(
            child: builder.buildSearchBody(
              context,
              Center(
                child: Text(
                  sprintf(startSearchText, <dynamic>[minLengthToSearch]),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          builder.buildBottomNavigationBar(context) ?? const SizedBox.shrink(),
        ],
      );
    } else {
      if (_lastQuery == query && _lastWidget != null) {
        return _lastWidget!;
      } else {
        Map<String, String> param = <String, String>{};

        _lastQuery = query;

        if (extraParams.isNotEmpty) {
          param.addAll(extraParams);
        }

        param['t'] = query.replaceAll('%', '');

        _lastWidget = Column(
          children: <Widget>[
            Expanded(
              child: builder.buildSearchBody(
                context,
                SafeFutureBuilder<List<W>>(
                  future: consumer.list(
                    context,
                    // TODO(edufolly): Page implementation.
                    size: itemsPerPage,
                    extraParams: param,
                    forceOffline: forceOffline,
                  ),
                  waitingMessage: waitingText,
                  builder: (BuildContext context, List<W> data, _) => data
                          .isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                hintText,
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
                                  W model = data[index];

                                  return ListTile(
                                    title: builder.getSuggestionTitle(
                                      context,
                                      model,
                                    ),
                                    subtitle: builder.getSuggestionSubtitle(
                                      context,
                                      model,
                                    ),
                                    onTap: () {
                                      _lastQuery = model.listSearchTerm;
                                      query = _lastQuery!;
                                      showResults(context);
                                    },
                                  );
                                },
                                itemCount: data.length,
                              ),
                            ),
                          ],
                        )
                      : Center(child: Text(searchListEmpty)),
                ),
              ),
            ),
            builder.buildBottomNavigationBar(context) ??
                const SizedBox.shrink(),
          ],
        );

        return _lastWidget!;
      }
    }
  }
}
