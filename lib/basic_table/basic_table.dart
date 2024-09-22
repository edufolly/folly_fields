import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:folly_fields/basic_table/basic_table_column_builder.dart';

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

  // Header Properties
  final double headerHeight;
  final TextStyle? headerTextStyle;
  final Color? headerBackground;

  // Row Properties
  final double rowHeight;
  final Color? rowBackgroundOdd;
  final Color? rowBackgroundEven;

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
    this.headerHeight = 26,
    this.headerTextStyle,
    this.headerBackground,
    this.rowHeight = 26,
    this.rowBackgroundOdd,
    this.rowBackgroundEven,
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
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
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

        final double tableHeight = math.min(
          constraints.maxHeight -
              // (widget.dividerHeight * 5) -
              (widget.dividerHeight * 3) -
              // widget.commandsHeight -
              widget.headerHeight -
              // widget.paginationHeight -
              (hasHorizontalScrollBar
                  ? widget.dividerHeight + widget.scrollBarThickness + 4
                  : 0),
          widget.rowsCount * widget.rowHeight +
              (widget.rowsCount - 1) * widget.dividerHeight,
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
              // SizedBox(
              //   width: width,
              //   height: widget.commandsHeight,
              //   child: Row(
              //     children: <Widget>[
              //       Text(
              //         'Commands',
              //         style: Theme.of(context).textTheme.headlineSmall,
              //       ),
              //     ],
              //   ),
              // ),

              /// Divider
              // divider,

              /// Table
              Scrollbar(
                controller: _horizontalController,
                radius: Radius.zero,
                thumbVisibility: true,
                thickness: widget.scrollBarThickness,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: _horizontalController,
                  primary: false,
                  child: Column(
                    children: <Widget>[
                      /// Table header
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
                                  width: e.flexible ? ratio * e.width : e.width,
                                  height: widget.headerHeight,
                                  child: e.header?.call(context),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ),

                      /// Divider
                      divider,

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
                                    child: e.builder(context, index),
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

              /// Divider
              // divider,

              /// Pagination
              // SizedBox(
              //   width: width,
              //   height: widget.paginationHeight,
              //   child: Row(
              //     children: <Widget>[
              //       Text(
              //         'Pagination',
              //         style: Theme.of(context).textTheme.headlineSmall,
              //       ),
              //     ],
              //   ),
              // ),
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
