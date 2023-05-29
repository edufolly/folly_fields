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
      final Map<dynamic, bool> domain = <dynamic, bool>{
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

      for (final MapEntry<dynamic, bool> input in domain.entries) {
        test(
          '${input.key} // ${input.value}',
          () {
            expect(ModelUtils.fromJsonSafeBool(input.key), input.value);
          },
        );
      }
    },
  );
}
