// ignore_for_file: avoid-top-level-members-in-tests

import 'package:folly_fields/folly_fields.dart';

///
///
///
class MockConfig extends AbstractConfig {
  static final MockConfig _singleton = MockConfig._internal();

  factory MockConfig() {
    return _singleton;
  }

  MockConfig._internal();
}
