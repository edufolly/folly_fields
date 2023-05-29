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
    'ModelUtils fromJsonList',
    () {
      FollyFields.start(
        MockConfig(),
        connectivity: MockConnectivity(),
      );

      const MockConsumer consumer = MockConsumer();

      final Map<List<Map<String, dynamic>>?, List<MockModel>> domain =
          <List<Map<String, dynamic>>?, List<MockModel>>{
        null: <MockModel>[],
        <Map<String, dynamic>>[]: <MockModel>[],
        <Map<String, dynamic>>[
          <String, dynamic>{},
          <String, dynamic>{},
        ]: <MockModel>[
          MockModel(),
          MockModel(),
        ],
        ...MockModel.baseDomain.map(
          (Map<String, dynamic> key, MockModel value) =>
              MapEntry<List<Map<String, dynamic>>, List<MockModel>>(
            <Map<String, dynamic>>[key],
            <MockModel>[value],
          ),
        ),
        <Map<String, dynamic>>[
          MockModel.alineMap,
          MockModel.kateMap,
        ]: <MockModel>[
          MockModel.alineModel,
          MockModel.kateModel,
        ],
        <Map<String, dynamic>>[
          MockModel.alineMap,
          MockModel.alineMap,
        ]: <MockModel>[
          MockModel.alineModel,
          MockModel.alineModel,
        ],
        <Map<String, dynamic>>[
          MockModel.alineMap,
          <String, dynamic>{},
        ]: <MockModel>[
          MockModel.alineModel,
          MockModel(),
        ],
      };

      for (final MapEntry<List<Map<String, dynamic>>?, List<MockModel>> input
          in domain.entries) {
        test(
          '${input.key} // ${input.value}',
          () {
            expect(ModelUtils.fromJsonList(input.key, consumer), input.value);
          },
        );
      }
    },
  );
}
