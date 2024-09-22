import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folly_fields/basic_table/pagination/basic_table_pagination_controller.dart';
import 'package:folly_fields/util/folly_num_extension.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
class BasicTablePaginationWidget extends StatefulWidget {
  final BasicTablePaginationController controller;
  final double paginationIconSize;
  final int totalPages;
  final Function(int page)? onPageChanged;

  ///
  ///
  ///
  const BasicTablePaginationWidget({
    required this.controller,
    required this.paginationIconSize,
    required this.totalPages,
    required this.onPageChanged,
    super.key,
  });

  ///
  ///
  ///
  @override
  State<BasicTablePaginationWidget> createState() =>
      _BasicTablePaginationWidgetState();
}

///
///
///
class _BasicTablePaginationWidgetState
    extends State<BasicTablePaginationWidget> {
  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        /// First Page
        IconButton(
          tooltip: 'First',
          onPressed: widget.controller.currentPage > 1
              ? () => setState(() {
                    widget.controller.currentPage = 1;
                    widget.onPageChanged?.call(widget.controller.currentPage);
                  })
              : null,
          icon: const FaIcon(FontAwesomeIcons.anglesLeft),
          iconSize: widget.paginationIconSize,
        ),

        /// Previous Page
        IconButton(
          tooltip: 'Previous',
          onPressed: widget.controller.currentPage > 1
              ? () => setState(() {
                    widget.controller.currentPage--;
                    widget.onPageChanged?.call(widget.controller.currentPage);
                  })
              : null,
          icon: const FaIcon(FontAwesomeIcons.angleLeft),
          iconSize: widget.paginationIconSize,
        ),

        /// Current Page
        SizedBox(
          width: (widget.totalPages + 1).log10.ceil() * 10 + 10,
          child: TextField(
            decoration: const InputDecoration(
              isDense: true,
            ),
            keyboardType: TextInputType.number,
            controller: widget.controller.controller,
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
                widget.controller.currentPage = page;
                widget.onPageChanged?.call(widget.controller.currentPage);
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
          onPressed: widget.controller.currentPage < widget.totalPages
              ? () => setState(() {
                    widget.controller.currentPage++;
                    widget.onPageChanged?.call(widget.controller.currentPage);
                  })
              : null,
          icon: const FaIcon(FontAwesomeIcons.angleRight),
          iconSize: widget.paginationIconSize,
        ),

        /// First Page
        IconButton(
          tooltip: 'Last',
          onPressed: widget.controller.currentPage < widget.totalPages
              ? () => setState(() {
                    widget.controller.currentPage = widget.totalPages;
                    widget.onPageChanged?.call(widget.controller.currentPage);
                  })
              : null,
          icon: const FaIcon(FontAwesomeIcons.anglesRight),
          iconSize: widget.paginationIconSize,
        ),
      ],
    );
  }
}
