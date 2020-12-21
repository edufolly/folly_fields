import 'package:folly_fields/folly_fields.dart';

///
///
///
class Config extends AbstractConfig {
  static final Config _singleton = Config._internal();

  ///
  ///
  ///
  Config._internal();

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
  String get prefix => '';
}
