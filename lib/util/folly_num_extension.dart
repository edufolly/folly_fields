import 'dart:math';

///
///
///
extension FollyNumExtension on num {
  ///
  ///
  ///
  num get toRadians => this * pi / 180;

  ///
  ///
  ///
  num get toDegrees => this * 180 / pi;

  ///
  ///
  ///
  double get log10 => (this == 0) ? 0 : log(this) / ln10;

  ///
  ///
  ///
  double logBase(num base) => (this == 0) ? 0 : log(this) / log(base);

  ///
  ///
  ///
  T min<T extends num>(T other) => (this < other ? this : other) as T;

  ///
  ///
  ///
  T max<T extends num>(T other) => (this > other ? this : other) as T;
}
