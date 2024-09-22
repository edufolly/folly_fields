import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folly_fields/basic_table/basic_table_column_builder.dart';
import 'package:folly_fields/util/folly_num_extension.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
class BasicTable extends StatefulWidget {
  final int rowsCount;
  final List<BasicTableColumnBuilder> columnBuilders;

  // Table Properties
  final Decoration? decoration;
  final double dividerHeight;
  final Color dividerColor;
  final double scrollBarThickness;

  // Commands Properties
  final double commandsHeight;
  final MainAxisAlignment commandsAlignment;
  final List<Widget>? commands;

  // Header Properties
  final double headerHeight;
  final TextStyle? headerTextStyle;
  final Color? headerBackground;

  // Row Properties
  final double rowHeight;
  final Color? rowBackgroundOdd;
  final Color? rowBackgroundEven;

  // Pagination Properties
  final double paginationHeight;
  final double paginationIconSize;
  final EdgeInsetsGeometry paginationPadding;
  final List<int> pageSizes;
  final int? initialPageSize;
  final Function(int size)? onPageSizeChanged;
  final int totalPages;
  final int initialPage;
  final Function(int page)? onPageChanged;

  ///
  ///
  ///
  const BasicTable({
    required this.rowsCount,
    required this.columnBuilders,
    this.decoration,
    this.dividerHeight = 1,
    this.dividerColor = Colors.grey,
    this.scrollBarThickness = 6,
    this.commandsHeight = 0,
    this.commandsAlignment = MainAxisAlignment.end,
    this.commands,
    this.headerHeight = 26,
    this.headerTextStyle,
    this.headerBackground,
    this.rowHeight = 26,
    this.rowBackgroundOdd,
    this.rowBackgroundEven,
    this.paginationHeight = 46,
    this.paginationIconSize = 12,
    this.paginationPadding = const EdgeInsets.symmetric(horizontal: 8),
    this.initialPageSize,
    this.pageSizes = const <int>[10, 25, 50, 100],
    this.onPageSizeChanged,
    this.totalPages = 0,
    this.initialPage = 1,
    this.onPageChanged,
    super.key,
  });

  ///
  ///
  ///
  @override
  State<BasicTable> createState() => _BasicTableState();
}

///
///
///
class _BasicTableState extends State<BasicTable> {
  final ScrollController _horizontalController = ScrollController();
  final ScrollController _verticalController = ScrollController();
  final TextEditingController _pageController = TextEditingController();

  int _currentPageSize = 0;

  ///
  ///
  ///
  int get _currentPage => int.tryParse(_pageController.text) ?? 1;

  ///
  ///
  ///
  set _currentPage(int value) => _pageController.text = value.toString();

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();
    _currentPageSize = widget.initialPageSize ?? widget.pageSizes.first;
    _pageController.text = widget.initialPage.toString();
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    final Color rowBackgroundOdd = widget.rowBackgroundOdd ??
        Theme.of(context).colorScheme.surfaceContainerLow;

    final Color rowBackgroundEven = widget.rowBackgroundEven ??
        Theme.of(context).colorScheme.surfaceContainerHighest;

    final TextStyle headerTextStyle = widget.headerTextStyle ??
        (Theme.of(context).textTheme.bodyLarge ?? const TextStyle()).copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).appBarTheme.foregroundColor,
        );

    final Decoration decoration = widget.decoration ??
        BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHigh,
          border: Border.all(
            color: widget.dividerColor,
            width: widget.dividerHeight,
          ),
        );

    return LayoutBuilder(
      builder: (
        BuildContext context,
        BoxConstraints constraints,
      ) {
        final double fixedTableWidth = widget.columnBuilders.fold<double>(
          0,
          (double p, BasicTableColumnBuilder e) => e.flexible ? p : p + e.width,
        );

        final double screenWidth =
            constraints.maxWidth - fixedTableWidth - (widget.dividerHeight * 2);

        final double flexibleTableWidth = widget.columnBuilders.fold<double>(
          0,
          (double p, BasicTableColumnBuilder e) => e.flexible ? p + e.width : p,
        );

        final double ratio = screenWidth > flexibleTableWidth
            ? screenWidth / flexibleTableWidth
            : 1;

        final double width = flexibleTableWidth * ratio + fixedTableWidth;

        final bool hasHorizontalScrollBar = ratio <= 1.003;

        final bool hasCommands = widget.commandsHeight > 0 &&
            widget.commands != null &&
            widget.commands!.isNotEmpty;

        final bool hasHeader = widget.headerHeight > 0;

        final bool hasPagination =
            widget.onPageSizeChanged != null || widget.onPageChanged != null;

        final double tableHeight = (widget.rowsCount * widget.rowHeight +
                (widget.rowsCount - 1) * widget.dividerHeight)
            .min(
          constraints.maxHeight -
              (widget.dividerHeight * 2) -
              (hasHeader ? widget.dividerHeight : 0) -
              (hasCommands ? widget.commandsHeight + widget.dividerHeight : 0) -
              widget.headerHeight -
              (hasPagination
                  ? widget.paginationHeight + widget.dividerHeight
                  : 0) -
              (hasHorizontalScrollBar
                  ? widget.dividerHeight + widget.scrollBarThickness + 4
                  : 0),
        );

        final Widget divider = Container(
          width: width,
          height: widget.dividerHeight,
          color: widget.dividerColor,
        );

        // DecoratedBox has a bug with border and color.
        // ignore: use_decorated_box
        return Container(
          decoration: decoration,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              /// Commands
              if (widget.commandsHeight > 0) ...<Widget>[
                SizedBox(
                  width: width,
                  height: widget.commandsHeight,
                  child: Row(
                    mainAxisAlignment: widget.commandsAlignment,
                    children: widget.commands!,
                  ),
                ),
                divider,
              ],

              /// Table
              Scrollbar(
                controller: _horizontalController,
                thumbVisibility: true,
                thickness: widget.scrollBarThickness,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: _horizontalController,
                  primary: false,
                  child: Column(
                    children: <Widget>[
                      /// Table header
                      if (hasHeader) ...<Widget>[
                        ColoredBox(
                          color: widget.headerBackground ??
                              Theme.of(context).appBarTheme.backgroundColor ??
                              Colors.transparent,
                          child: DefaultTextStyle(
                            style: headerTextStyle,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: widget.columnBuilders.map(
                                (BasicTableColumnBuilder e) {
                                  // TODO(edufolly): Implements sorting.
                                  return SizedBox(
                                    width:
                                        e.flexible ? ratio * e.width : e.width,
                                    height: widget.headerHeight,
                                    child: e.header?.call(context),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                        ),
                        divider,
                      ],

                      /// Table rows
                      SizedBox(
                        width: width,
                        height: tableHeight,
                        child: ListView.separated(
                          controller: _verticalController,
                          itemCount: widget.rowsCount,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: widget.columnBuilders.map(
                                (BasicTableColumnBuilder e) {
                                  return Container(
                                    color: index.isOdd
                                        ? rowBackgroundOdd
                                        : rowBackgroundEven,
                                    width:
                                        e.flexible ? ratio * e.width : e.width,
                                    height: widget.rowHeight,
                                    child: e.builder(
                                      context,
                                      index,
                                      _currentPage,
                                      _currentPageSize,
                                    ),
                                  );
                                },
                              ).toList(),
                            );
                          },
                          separatorBuilder: (_, __) => divider,
                        ),
                      ),

                      /// Scrollbar
                      if (hasHorizontalScrollBar) ...<Widget>[
                        divider,
                        SizedBox(
                          width: width,
                          height: widget.scrollBarThickness + 4,
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              /// Pagination
              if (hasPagination) ...<Widget>[
                divider,
                SizedBox(
                  width: width,
                  height: widget.paginationHeight,
                  child: Padding(
                    padding: widget.paginationPadding,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        /// Page Size
                        if (widget.onPageSizeChanged != null)
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Text('Rows per page:'),
                              const SizedBox(width: 8),
                              DropdownButton<int>(
                                isDense: true,
                                value: _currentPageSize,
                                items: widget.pageSizes.map((int value) {
                                  return DropdownMenuItem<int>(
                                    value: value,
                                    child: Text(value.toString()),
                                  );
                                }).toList(),
                                onChanged: (int? size) {
                                  if (size != null &&
                                      _currentPageSize != size) {
                                    setState(() {
                                      _currentPageSize = size;
                                      _currentPage = 1;
                                      widget.onPageSizeChanged
                                          ?.call(_currentPageSize);
                                    });
                                  }
                                },
                              ),
                            ],
                          )
                        else
                          const SizedBox.shrink(),

                        /// Pagination
                        if (widget.onPageChanged != null)
                          Row(
                            // mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              /// First Page
                              IconButton(
                                tooltip: 'First',
                                onPressed: _currentPage > 1
                                    ? () => setState(() {
                                          _currentPage = 1;
                                          widget.onPageChanged
                                              ?.call(_currentPage);
                                        })
                                    : null,
                                icon: const FaIcon(FontAwesomeIcons.anglesLeft),
                                iconSize: widget.paginationIconSize,
                              ),

                              /// Previous Page
                              IconButton(
                                tooltip: 'Previous',
                                onPressed: _currentPage > 1
                                    ? () => setState(() {
                                          _currentPage--;
                                          widget.onPageChanged
                                              ?.call(_currentPage);
                                        })
                                    : null,
                                icon: const FaIcon(FontAwesomeIcons.angleLeft),
                                iconSize: widget.paginationIconSize,
                              ),

                              /// Current Page
                              SizedBox(
                                width: widget.totalPages.log10.ceil() * 10 + 20,
                                child: TextField(
                                  decoration: const InputDecoration(
                                    isDense: true,
                                  ),
                                  keyboardType: TextInputType.number,
                                  controller: _pageController,
                                  textAlign: TextAlign.center,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  onSubmitted: (String value) {
                                    int page = int.tryParse(value) ?? 1;

                                    if (page < 1) {
                                      page = 1;
                                    }

                                    if (page > widget.totalPages) {
                                      page = widget.totalPages;
                                    }

                                    setState(() {
                                      _currentPage = page;
                                      widget.onPageChanged?.call(_currentPage);
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 4, 2),
                                child: Text(
                                  'of ${widget.totalPages}',
                                ),
                              ),

                              /// Next Page
                              IconButton(
                                tooltip: 'Next',
                                onPressed: _currentPage < widget.totalPages
                                    ? () => setState(() {
                                          _currentPage++;
                                          widget.onPageChanged
                                              ?.call(_currentPage);
                                        })
                                    : null,
                                icon: const FaIcon(FontAwesomeIcons.angleRight),
                                iconSize: widget.paginationIconSize,
                              ),

                              /// First Page
                              IconButton(
                                tooltip: 'Last',
                                onPressed: _currentPage < widget.totalPages
                                    ? () => setState(() {
                                          _currentPage = widget.totalPages;
                                          widget.onPageChanged
                                              ?.call(_currentPage);
                                        })
                                    : null,
                                icon:
                                    const FaIcon(FontAwesomeIcons.anglesRight),
                                iconSize: widget.paginationIconSize,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  ///
  ///
  ///
  @override
  void dispose() {
    _horizontalController.dispose();
    _verticalController.dispose();
    super.dispose();
  }
}
