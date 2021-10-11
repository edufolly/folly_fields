import 'package:flutter/widgets.dart';
import 'package:folly_fields/responsive/responsive_grid.dart';

///
///
///
abstract class ResponsiveWidget extends StatelessWidget {
  final int? sizeExtraSmall;
  final int? sizeSmall;
  final int sizeMedium;
  final int? sizeLarge;
  final int? sizeExtraLarge;
  final double minHeight;

  ///
  ///
  ///
  const ResponsiveWidget({
    this.sizeExtraSmall,
    this.sizeSmall,
    this.sizeMedium = 6,
    this.sizeLarge,
    this.sizeExtraLarge,
    this.minHeight = 100,
    Key? key,
  })  : assert(
            sizeExtraSmall == null ||
                (sizeExtraSmall >= 1 && sizeExtraSmall <= 12),
            'sizeExtraSmall must be between 1 and 12.'),
        assert(sizeSmall == null || (sizeSmall >= 1 && sizeSmall <= 12),
            'sizeSmall must be between 1 and 12.'),
        assert(sizeMedium >= 1 && sizeMedium <= 12,
            'sizeMedium must be between 1 and 12.'),
        assert(sizeLarge == null || (sizeLarge >= 1 && sizeLarge <= 12),
            'sizeLarge must be between 1 and 12.'),
        assert(
            sizeExtraLarge == null ||
                (sizeExtraLarge >= 1 && sizeExtraLarge <= 12),
            'sizeExtraLarge must be between 1 and 12.'),
        assert(minHeight >= 0, 'minHeight must be equal or greater than zero.'),
        super(key: key);

  ///
  ///
  ///
  int responsiveSize(ResponsiveSize size) {
    switch (size) {
      case ResponsiveSize.extraSmall:
        return sizeExtraSmall ?? sizeSmall ?? sizeMedium;
      case ResponsiveSize.small:
        return sizeSmall ?? sizeMedium;
      case ResponsiveSize.medium:
        return sizeMedium;
      case ResponsiveSize.large:
        return sizeLarge ?? sizeMedium;
      case ResponsiveSize.extraLarge:
        return sizeExtraLarge ?? sizeLarge ?? sizeMedium;
    }
  }
}
