import 'package:folly_fields/folly_fields.dart';

///
///
///
class Config extends AbstractConfig {
  static final Config _singleton = Config._internal();

  ///
  ///
  ///
  ///
  factory Config() {
    return _singleton;
  }

  ///
  ///
  ///
  Config._internal();

  ///
  ///
  ///
  String get labelPrefix => '';
}
