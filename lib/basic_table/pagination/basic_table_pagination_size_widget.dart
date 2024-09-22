import 'package:flutter/material.dart';
import 'package:folly_fields/basic_table/pagination/basic_table_pagination_controller.dart';

///
///
///
class BasicTablePaginationSizeWidget extends StatefulWidget {
  final BasicTablePaginationController controller;
  final List<int> pageSizes;
  final int? initialPageSize;
  final Function(int size, int page) onPageSizeChanged;

  ///
  ///
  ///
  const BasicTablePaginationSizeWidget({
    required this.controller,
    required this.pageSizes,
    required this.initialPageSize,
    required this.onPageSizeChanged,
    super.key,
  });

  ///
  ///
  ///
  @override
  State<BasicTablePaginationSizeWidget> createState() =>
      _BasicTablePaginationSizeWidgetState();
}

///
///
///
class _BasicTablePaginationSizeWidgetState
    extends State<BasicTablePaginationSizeWidget> {
  int _currentPageSize = 0;

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();
    _currentPageSize = widget.initialPageSize ?? widget.pageSizes.first;
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Row(
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
            if (size != null && _currentPageSize != size) {
              setState(() {
                _currentPageSize = size;
                widget.controller.reset();
                widget.onPageSizeChanged.call(
                  _currentPageSize,
                  widget.controller.currentPage,
                );
              });
            }
          },
        ),
      ],
    );
  }
}
