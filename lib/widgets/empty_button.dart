import 'package:flutter/material.dart';
import 'package:folly_fields/responsive/responsive.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
class EmptyButton extends ResponsiveStateless {
  ///
  ///
  ///
  const EmptyButton({
    super.sizeExtraSmall,
    super.sizeSmall,
    super.sizeMedium,
    super.sizeLarge,
    super.sizeExtraLarge,
    super.minHeight,
    super.key,
  });

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return const Flexible(
      flex: 0,
      child: IconButton(
        icon: FaIcon(
          FontAwesomeIcons.square,
          color: Colors.transparent,
        ),
        onPressed: null,
      ),
    );
  }
}
