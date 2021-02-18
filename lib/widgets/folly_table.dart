import 'package:flutter/material.dart';
import 'package:folly_fields/widgets/folly_divider.dart';
import 'package:intl/intl.dart';

///
///
///
class FollyTable extends StatelessWidget {
  final int rowsCount;
  final List<double> columnsSize;
  final List<FollyCell> headerColumns;
  final double headerHeight;
  final FollyCell Function(int row, int column) cellBuilder;
  final double rowHeight;
  final void Function(int row) onRowTap;

  ///
  ///
  ///
  const FollyTable({
    Key key,
    @required this.rowsCount,
    @required this.columnsSize,
    this.headerColumns,
    this.headerHeight = 16.0,
    @required this.cellBuilder,
    this.rowHeight = 16.0,
    this.onRowTap,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    double width = columnsSize.fold<double>(
      0.0,
      (double p, double e) => p + e + 4.0,
    );

    return Scrollbar(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: <Widget>[
            Row(
              children: columnsSize
                  .asMap()
                  .map(
                    (int column, double width) {
                      FollyCell cell = headerColumns[column];
                      return MapEntry<int, Widget>(
                        column,
                        Container(
                          color: cell.color,
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(2.0, 0.0, 2.0, 4.0),
                            child: SizedBox(
                              height: headerHeight,
                              width: width,
                              child: cell,
                            ),
                          ),
                        ),
                      );
                    },
                  )
                  .values
                  .toList(),
            ),
            Container(
              width: width,
              child: FollyDivider(),
            ),
            Expanded(
              child: SizedBox(
                width: width,
                child: Scrollbar(
                  child: ListView.builder(
                    itemCount: rowsCount ?? 0,
                    itemBuilder: (BuildContext context, int row) {
                      return Column(
                        children: <Widget>[
                          InkWell(
                            child: Row(
                              children: columnsSize
                                  .asMap()
                                  .map(
                                    (int column, double width) {
                                      FollyCell cell = cellBuilder(row, column);
                                      return MapEntry<int, Widget>(
                                        column,
                                        Container(
                                          color: cell.color,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: SizedBox(
                                              height: rowHeight,
                                              width: width,
                                              child: cell,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                  .values
                                  .toList(),
                            ),
                            onTap: () =>
                                onRowTap != null ? onRowTap(row) : () {},
                          ),
                          FollyDivider(),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///
///
///
class FollyCell extends StatelessWidget {
  final AlignmentGeometry align;
  final Color color;
  final Widget child;

  ///
  ///
  ///
  const FollyCell({
    Key key,
    this.align = Alignment.centerLeft,
    this.color = Colors.transparent,
    @required this.child,
  }) : super(key: key);

  ///
  ///
  ///
  FollyCell.empty({
    this.color = Colors.transparent,
  })  : align = Alignment.centerLeft,
        child = Container();

  ///
  ///
  ///
  FollyCell.textHeader(
    String text, {
    this.align = Alignment.bottomLeft,
    this.color = Colors.transparent,
    TextAlign textAlign = TextAlign.start,
    TextStyle style,
  }) : child = Text(
          text,
          textAlign: textAlign,
          style: style ??
              TextStyle(
                fontWeight: FontWeight.bold,
              ),
        );

  ///
  ///
  ///
  FollyCell.textHeaderCenter(
    String text, {
    this.color = Colors.transparent,
    TextStyle style,
  })  : align = Alignment.bottomCenter,
        child = Text(
          text,
          textAlign: TextAlign.center,
          style: style ??
              TextStyle(
                fontWeight: FontWeight.bold,
              ),
        );

  ///
  ///
  ///
  FollyCell.text(
    String text, {
    this.align = Alignment.centerLeft,
    this.color = Colors.transparent,
    TextAlign textAlign = TextAlign.start,
    TextStyle style,
  }) : child = Text(
          text ?? '',
          textAlign: textAlign,
          style: style,
        );

  ///
  ///
  ///
  FollyCell.number(
    num number, {
    this.align = Alignment.centerRight,
    this.color = Colors.transparent,
    TextAlign textAlign = TextAlign.end,
    TextStyle style,
    String locale = 'pt_br',
    String pattern = '#,##0.00',
  }) : child = Text(
          NumberFormat(pattern, locale).format(number),
          textAlign: textAlign,
          style: style,
        );

  ///
  ///
  ///
  FollyCell.integer(
    num number, {
    this.align = Alignment.centerRight,
    this.color = Colors.transparent,
    TextAlign textAlign = TextAlign.end,
    TextStyle style,
    String locale = 'pt_br',
    String pattern = '#,##0',
  }) : child = Text(
          NumberFormat(pattern, locale).format(number),
          textAlign: textAlign,
          style: style,
        );

  ///
  ///
  ///
  FollyCell.date(
    DateTime date, {
    this.align = Alignment.center,
    this.color = Colors.transparent,
    TextAlign textAlign = TextAlign.center,
    TextStyle style,
    String locale = 'pt_br',
    String pattern = 'dd/MM/yyyy',
  }) : child = Text(
          DateFormat(pattern, locale).format(date),
          textAlign: textAlign,
          style: style,
        );

  ///
  ///
  ///
  FollyCell.time(
    DateTime date, {
    this.align = Alignment.center,
    this.color = Colors.transparent,
    TextAlign textAlign = TextAlign.center,
    TextStyle style,
    String locale = 'pt_br',
    String pattern = 'HH:mm',
  }) : child = Text(
          DateFormat(pattern, locale).format(date),
          textAlign: textAlign,
          style: style,
        );

  ///
  ///
  ///
  FollyCell.dateTime(
    DateTime date, {
    this.align = Alignment.center,
    this.color = Colors.transparent,
    TextAlign textAlign = TextAlign.center,
    TextStyle style,
    String locale = 'pt_br',
    String pattern = 'dd/MM/yyyy HH:mm',
  }) : child = Text(
          DateFormat(pattern, locale).format(date),
          textAlign: textAlign,
          style: style,
        );

  ///
  ///
  ///
  FollyCell.iconButton(
    IconData iconData, {
    Function onPressed,
    this.align = Alignment.center,
    this.color = Colors.transparent,
  }) : child = FittedBox(
          child: IconButton(
            icon: Icon(iconData),
            onPressed: onPressed,
          ),
        );

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: align,
      child: child,
    );
  }
}
