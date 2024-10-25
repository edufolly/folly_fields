import 'package:flutter/widgets.dart';

///
///
///
abstract class BasicTableAbstractCell extends StatelessWidget {
  final EdgeInsets _padding;
  final AlignmentGeometry _align;
  final Color? _background;

  ///
  ///
  ///
  const BasicTableAbstractCell({
    EdgeInsets? padding,
    AlignmentGeometry? align,
    Color? background,
    super.key,
  })  : _padding = padding ?? const EdgeInsets.all(2),
        _align = align ?? Alignment.centerLeft,
        _background = background;

  ///
  ///
  ///
  EdgeInsets get padding => _padding;

  ///
  ///
  ///
  AlignmentGeometry get align => _align;

  ///
  ///
  ///
  Color? get background => _background;

  ///
  ///
  ///
  Widget get child;

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      alignment: align,
      color: background,
      child: child,
    );
    // TODO(edufolly): Possible alignment bug.
    // return Padding(
    //   padding: padding,
    //   child: Align(
    //     alignment: align,
    //     child: child,
    //   ),
    // );
  }
}
