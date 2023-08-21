import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/model_utils.dart';

///
///
///
void main() {
  ///
  group(
    'ModelUtils fromJsonSafeBool',
    () {
      Map<dynamic, bool> domain = <dynamic, bool>{
        null: false,
        true: true,
        false: false,
        0: false,
        1.2: false,
        <dynamic>[]: false,
        <dynamic>{}: false,
        <dynamic, dynamic>{}: false,
        '': false,
        ' ': false,
        'A': false,
        'a': false,
        '0': false,
        '1': false,
        'true': true,
        ' true': true,
        ' true ': true,
        'true ': true,
        'True': true,
        'TRUE': true,
        'false': false,
        ' false': false,
        ' false ': false,
        'false ': false,
        'False': false,
        'FALSE': false,
      };

      for (final MapEntry<dynamic, bool>(
            :dynamic key,
            :bool value,
          ) in domain.entries) {
        test(
          '$key // $value',
          () => expect(ModelUtils.fromJsonSafeBool(key), value),
        );
      }
    },
  );
}
