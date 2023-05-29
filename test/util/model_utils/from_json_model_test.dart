import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/folly_fields.dart';
import 'package:folly_fields/util/model_utils.dart';

import '../../mocks/crud/mock_consumer.dart';
import '../../mocks/crud/mock_model.dart';
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

      const MockConsumer consumer = MockConsumer();

      final Map<Map<String, dynamic>?, MockModel?> domain =
          <Map<String, dynamic>?, MockModel?>{
        null: null,
        ...MockModel.baseDomain,
        MockModel.alineMap: MockModel.alineModel,
        MockModel.kateMap: MockModel.kateModel,
      };

      for (final MapEntry<Map<String, dynamic>?, MockModel?> input
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
