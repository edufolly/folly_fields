import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/model_utils.dart';

///
///
///
void main() {
  ///
  group(
    'ModelUtils fromJsonRawMap',
    () {
      Map<Map<dynamic, dynamic>?, Map<String, dynamic>> domain =
          <Map<dynamic, dynamic>?, Map<String, dynamic>>{
        null: <String, dynamic>{},
        <dynamic, dynamic>{}: <String, dynamic>{},
        <dynamic, dynamic>{
          null: null,
          'key': 'value',
          true: false,
          0: 1,
          2.3: 3.2,
        }: <String, dynamic>{
          'null': null,
          'key': 'value',
          'true': false,
          '0': 1,
          '2.3': 3.2,
        },
      };

      for (MapEntry<Map<dynamic, dynamic>?, Map<String, dynamic>> input
          in domain.entries) {
        test(
          '${input.key} // ${input.value}',
          () {
            expect(
              ModelUtils.fromJsonRawMap<String, dynamic>(
                input.key,
                keyProducer: (dynamic k) => k.toString(),
                valueProducer: (dynamic v) => v,
              ),
              input.value,
            );
          },
        );
      }
    },
  );
}
