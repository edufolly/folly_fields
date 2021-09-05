import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
class AnimatedSearch extends StatefulWidget {
  final TextEditingController controller;
  final double maxSize;

  ///
  ///
  ///
  const AnimatedSearch({
    Key? key,
    required this.controller,
    this.maxSize = 200.0,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  _AnimatedSearchState createState() => _AnimatedSearchState();
}

///
///
///
class _AnimatedSearchState extends State<AnimatedSearch> {
  bool expanded = false;

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: expanded ? widget.maxSize : 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Visibility(
            visible: expanded,
            child: Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  controller: widget.controller,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  autofocus: expanded,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => setState(() {
              expanded = !expanded;
              if (!expanded) widget.controller.clear();
            }),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 12, 8, 12),
              child: Icon(
                FontAwesomeIcons.search,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
