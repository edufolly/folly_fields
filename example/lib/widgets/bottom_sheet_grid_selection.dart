import 'dart:async';

import 'package:flutter/material.dart';
import 'package:folly_fields/extensions/scope_extension.dart';
import 'package:folly_fields/extensions/string_extension.dart';
import 'package:folly_fields_example/models/abstract_base_model.dart';
import 'package:folly_fields_example/widgets/search_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomSheetGridSelection<Entity extends AbstractBaseModel<Id>, Id>
    extends StatefulWidget {
  final Future<List<Entity>> Function(int page, int size, String? search) list;
  final Widget Function(BuildContext context, Entity model) itemBuilder;
  final List<Entity> selection;
  final Widget? title;
  final bool enableSearch;
  final int pageSize;
  final Duration searchDebounce;
  final bool multiple;
  final EdgeInsets padding;
  final double maxCrossAxisExtent;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  const BottomSheetGridSelection({
    required this.list,
    required this.itemBuilder,
    required this.selection,
    this.title,
    this.enableSearch = true,
    this.pageSize = 40,
    this.searchDebounce = const Duration(seconds: 1),
    this.multiple = true,
    this.padding = const EdgeInsets.all(8),
    this.maxCrossAxisExtent = 120,
    this.mainAxisSpacing = 6,
    this.crossAxisSpacing = 6,
    super.key,
  });

  @override
  State<BottomSheetGridSelection<Entity, Id>> createState() =>
      _BottomSheetGridSelectionState<Entity, Id>();
}

class _BottomSheetGridSelectionState<Entity extends AbstractBaseModel<Id>, Id>
    extends State<BottomSheetGridSelection<Entity, Id>> {
  final ScrollController _scrollController = ScrollController();
  final List<Entity> _list = <Entity>[];
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  int _page = 0;
  bool _loading = false;

  late VoidCallback _scrollListener;
  late VoidCallback _debounceListener;
  late Map<Id?, Entity> _selection;

  @override
  void initState() {
    super.initState();

    _selection = widget.selection.asMap().map(
      (final int k, final Entity v) => MapEntry<Id?, Entity>(v.id, v),
    );

    _scrollListener = () {
      if (_scrollController.position.hasContentDimensions &&
          _scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent * 0.9 &&
          !_loading &&
          _page >= 0) {
        unawaited(_loadData());
      }
    };

    _scrollController.addListener(_scrollListener);

    _debounceListener = () {
      if (_debounce?.isActive ?? false) {
        _debounce?.cancel();
      }

      _debounce = Timer(widget.searchDebounce, () => _loadData(clear: true));
    };

    _searchController.addListener(_debounceListener);

    unawaited(_loadData());
  }

  Future<void> _loadData({final bool clear = false}) async {
    setState(() => _loading = true);

    if (clear) {
      _page = 0;
      _list.clear();
    }

    final String term = _searchController.text.trim();

    try {
      final List<Entity> list = await widget.list(
        _page,
        widget.pageSize,
        term.isNullOrBlank ? null : term,
      );

      _list.addAll(list);
      _page++;

      if (list.length < widget.pageSize) _page = -1;
    } on Exception catch (e, s) {
      debugPrintStack(label: e.toString(), stackTrace: s);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(final BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // Title
        if (isNotNull(widget.title)) widget.title!,

        // Search
        if (widget.enableSearch)
          SearchField(_searchController, hintText: 'Pesquisar'),

        // List
        Expanded(
          child: GridView.builder(
            padding: widget.padding,
            controller: _scrollController,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: widget.maxCrossAxisExtent,
              mainAxisSpacing: widget.mainAxisSpacing,
              crossAxisSpacing: widget.crossAxisSpacing,
            ),
            itemCount: _list.length + (_loading ? 1 : 0),
            itemBuilder: (final BuildContext context, final int index) {
              if (index >= _list.length) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }

              final Entity model = _list[index];

              return Card(
                elevation: 2,
                clipBehavior: Clip.antiAlias,
                color: _selection.containsKey(model.id)
                    ? theme.colorScheme.primary.withAlpha(50)
                    : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: theme.colorScheme.outlineVariant),
                ),
                child: InkWell(
                  onTap: () {
                    if (!widget.multiple) {
                      Navigator.of(context).pop(<Entity>[model]);
                      return;
                    }

                    setState(() {
                      if (_selection.containsKey(model.id)) {
                        _selection.remove(model.id);
                      } else {
                        _selection[model.id] = model;
                      }
                    });
                  },
                  child: widget.itemBuilder(context, model),
                ),
              );
            },
          ),
        ),

        // Selection Button
        if (widget.multiple)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: FilledButton.icon(
              icon: const Icon(FontAwesomeIcons.check),
              label: const Text('Confirmar seleção'),
              onPressed: () =>
                  Navigator.of(context).pop(_selection.values.toList()),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }
}
