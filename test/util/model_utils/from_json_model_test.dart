import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/folly_fields.dart';
import 'package:folly_fields/util/model_utils.dart';

import '../../mocks/crud/mock_string_consumer.dart';
import '../../mocks/crud/mock_string_model.dart';
import '../../mocks/mock_config.dart';
import '../../mocks/mock_connectivity.dart';

///
///
///
void main() {
  ///
  group(
    'ModelUtils fromJsonModel',
    () {
      FollyFields.start(
        MockConfig(),
        connectivity: MockConnectivity(),
      );

      const MockStringConsumer consumer = MockStringConsumer();

      final Map<Map<String, dynamic>?, MockStringModel?> domain =
          <Map<String, dynamic>?, MockStringModel?>{
        null: null,
        ...MockStringModel.baseDomain,
        MockStringModel.alineMap: MockStringModel.alineModel,
        MockStringModel.kateMap: MockStringModel.kateModel,
      };

      for (final MapEntry<Map<String, dynamic>?, MockStringModel?> input
          in domain.entries) {
        test(
          '${input.key} // ${input.value}',
          () {
            expect(
              ModelUtils.fromJsonModel(input.key, consumer),
              input.value,
            );
          },
        );
      }
    },
  );
}
