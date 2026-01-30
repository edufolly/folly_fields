import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AnimatedSearch extends StatefulWidget {
  final TextEditingController controller;
  final double maxSize;

  const AnimatedSearch({
    required this.controller,
    this.maxSize = 200.0,
    super.key,
  });

  @override
  AnimatedSearchState createState() => AnimatedSearchState();
}

class AnimatedSearchState extends State<AnimatedSearch> {
  bool expanded = false;

  @override
  Widget build(final BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: expanded ? widget.maxSize : 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Visibility(
            visible: expanded,
            child: Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: TextField(
                  controller: widget.controller,
                  decoration: const InputDecoration(border: InputBorder.none),
                  autofocus: expanded,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => setState(() {
              expanded = !expanded;
              if (!expanded) {
                widget.controller.clear();
              }
            }),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 12, 8, 12),
              child: Icon(
                FontAwesomeIcons.magnifyingGlass,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
