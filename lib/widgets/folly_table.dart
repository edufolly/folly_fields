import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:folly_fields/widgets/folly_cell.dart';
import 'package:folly_fields/widgets/folly_divider.dart';

///
///
///
class FollyTableColumnBuilder {
  final double width;
  final FollyCell Function(int row) builder;
  final FollyCell header;

  ///
  ///
  ///
  FollyTableColumnBuilder({
    required this.width,
    required this.builder,
    this.header = const FollyCell.empty(),
  });
}

///
///
///
@Deprecated('Use BasicTable instead.')
class FollyTable extends StatefulWidget {
  final int rowsCount;
  final List<FollyTableColumnBuilder> columnBuilders;
  final double headerHeight;
  final double rowHeight;
  final void Function(int row)? onRowTap;
  final double dividerHeight;
  final double scrollBarThickness;
  final int scrollTimeout; // FIXME - Fix it!
  final bool verticalScrollAlwaysVisible;
  final bool horizontalScrollAlwaysVisible;
  final int freezeColumns;
  final Set<PointerDeviceKind>? dragDevices;

  ///
  ///
  ///
  @Deprecated('Use BasicTable instead.')
  const FollyTable({
    required this.rowsCount,
    required this.columnBuilders,
    this.headerHeight = 16.0,
    this.rowHeight = 16.0,
    this.onRowTap,
    this.dividerHeight = 1.0,
    this.scrollBarThickness = 8.0,
    this.scrollTimeout = 300,
    this.verticalScrollAlwaysVisible = true,
    this.horizontalScrollAlwaysVisible = true,
    this.freezeColumns = 0,
    this.dragDevices,
    super.key,
  });

  ///
  ///
  ///
  @override
  FollyTableState createState() => FollyTableState();
}

///
///
///
@Deprecated('Use BasicTable instead.')
class FollyTableState extends State<FollyTable> {
  final ScrollController _horizontalController = ScrollController();
  final ScrollController _verticalController = ScrollController();
  final ScrollController _internalController = ScrollController();
  final ScrollController _freezeController = ScrollController();

  int lastCall = 0;
  String caller = '';

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();

    _verticalController.addListener(() {
      if (caller.isEmpty ||
          DateTime.now().millisecondsSinceEpoch - lastCall >
              widget.scrollTimeout) {
        caller = 'vertical';
      }
      lastCall = DateTime.now().millisecondsSinceEpoch;

      if (caller == 'vertical') {
        _internalController.jumpTo(_verticalController.offset);
        if (widget.freezeColumns > 0) {
          _freezeController.jumpTo(_verticalController.offset);
        }
      }
    });

    _internalController.addListener(() {
      if (caller.isEmpty ||
          DateTime.now().millisecondsSinceEpoch - lastCall >
              widget.scrollTimeout) {
        caller = 'internal';
      }
      lastCall = DateTime.now().millisecondsSinceEpoch;

      if (caller == 'internal') {
        _verticalController.jumpTo(_internalController.offset);
        if (widget.freezeColumns > 0) {
          _freezeController.jumpTo(_internalController.offset);
        }
      }
    });

    if (widget.freezeColumns > 0) {
      _freezeController.addListener(() {
        if (caller.isEmpty ||
            DateTime.now().millisecondsSinceEpoch - lastCall >
                widget.scrollTimeout) {
          caller = 'freeze';
        }
        lastCall = DateTime.now().millisecondsSinceEpoch;

        if (caller == 'freeze') {
          _verticalController.jumpTo(_freezeController.offset);
          _internalController.jumpTo(_freezeController.offset);
        }
      });
    }
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        /// Frozen Content
        if (widget.freezeColumns > 0)
          _drawColumns(
            0,
            widget.freezeColumns,
            _freezeController,
          ),

        /// Table Content
        Flexible(
          child: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(
              dragDevices: widget.dragDevices,
            ),
            child: Scrollbar(
              controller: _horizontalController,
              thumbVisibility: widget.horizontalScrollAlwaysVisible,
              thickness: widget.scrollBarThickness,
              child: SingleChildScrollView(
                controller: _horizontalController,
                scrollDirection: Axis.horizontal,
                child: _drawColumns(
                  widget.freezeColumns,
                  widget.columnBuilders.length,
                  _internalController,
                ),
              ),
            ),
          ),
        ),

        /// Vertical Scrollbar
        Column(
          children: <Widget>[
            SizedBox(
              width: widget.scrollBarThickness,
              height: widget.headerHeight + widget.dividerHeight + 4.0,
            ),
            Expanded(
              child: Scrollbar(
                controller: _verticalController,
                // isAlwaysShown: widget.verticalScrollAlwaysVisible,
                thumbVisibility: widget.verticalScrollAlwaysVisible,
                thickness: widget.scrollBarThickness,
                child: SingleChildScrollView(
                  controller: _verticalController,
                  child: SizedBox(
                    width: widget.scrollBarThickness,
                    height: (widget.rowHeight + widget.dividerHeight + 4.0) *
                        widget.rowsCount,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  ///
  ///
  ///
  Column _drawColumns(
    int start,
    int end,
    ScrollController scrollController, {
    double halfPad = 2,
  }) {
    List<int> cols = List<int>.generate(
      end - start,
      (int index) => start + index,
    );

    double width = cols.fold(
      0,
      (double p, int i) => p + (widget.columnBuilders[i].width) + halfPad * 2,
    );

    return Column(
      children: <Widget>[
        Row(
          children: cols
              .map(
                (int col) => _buildCell(
                  padding: EdgeInsets.only(
                    left: halfPad,
                    right: halfPad,
                    bottom: halfPad * 2,
                  ),
                  cell: widget.columnBuilders[col].header,
                  width: widget.columnBuilders[col].width,
                  height: widget.headerHeight,
                ),
              )
              .toList(),
        ),
        SizedBox(
          width: width,
          child: FollyDivider(
            height: widget.dividerHeight,
          ),
        ),
        Expanded(
          child: SizedBox(
            width: width,
            child: ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(
                scrollbars: false,
                dragDevices: widget.dragDevices,
              ),
              child: ListView.builder(
                controller: scrollController,
                itemCount: widget.rowsCount,
                itemBuilder: (BuildContext context, int row) {
                  return Column(
                    children: <Widget>[
                      InkWell(
                        onTap: widget.onRowTap == null
                            ? null
                            : () => widget.onRowTap!(row),
                        hoverColor: Colors.transparent,
                        child: Row(
                          children: cols
                              .map(
                                (int col) => _buildCell(
                                  cell: widget.columnBuilders[col].builder
                                      .call(row),
                                  width: widget.columnBuilders[col].width,
                                  height: widget.rowHeight,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      FollyDivider(
                        height: widget.dividerHeight,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  ///
  ///
  ///
  Widget _buildCell({
    required FollyCell cell,
    required double width,
    required double height,
    EdgeInsetsGeometry padding = const EdgeInsets.all(2),
  }) =>
      Container(
        color: cell.color,
        padding: padding,
        child: SizedBox(
          width: width,
          height: height,
          child: cell,
        ),
      );

  ///
  ///
  ///
  @override
  void dispose() {
    _horizontalController.dispose();
    _verticalController.dispose();
    _internalController.dispose();
    super.dispose();
  }
}
